<?php

declare (strict_types = 1);

final class FakeRequest {
    public function __construct(private array $input) {
    }

    public function input(string $key, mixed $default = null): mixed {
        return $this->input[$key] ?? $default;
    }
}

final class FakeDB {
    public static function selectRaw(string $sql): array {
        // Stub only for eval fixtures.
        return [['sql' => $sql]];
    }
}

final class FakeOrderRepo {
    public static function all(): array {
        return [
            ['id' => 101],
            ['id' => 102],
            ['id' => 103],
        ];
    }
}

final class AuditEvalOrderController {
    public function generateAdminSummary(FakeRequest $request): array {
        // VIOLATION 1 (CRITICAL): hardcoded secret in source code (intentionally fake)
        $paymentGatewayKey = 'FAKE_PAYMENT_GATEWAY_KEY_123456';

        // VIOLATION 5 (CRITICAL): missing authorization for sensitive admin operation
        // Intentionally no policy/gate check before executing an admin-facing operation.

        // VIOLATION 2 (CRITICAL): SQL injection via raw concatenated query using untrusted input
        $email    = (string) $request->input('email');
        $userRows = FakeDB::selectRaw("SELECT * FROM users WHERE email = '" . $email . "'");

        // VIOLATION 3 (CRITICAL): N+1 query pattern (one query for orders + one query per order)
        $orders     = FakeOrderRepo::all();
        $totalItems = 0;
        foreach ($orders as $order) {
            $items = FakeDB::selectRaw('SELECT * FROM order_items WHERE order_id = ' . (int) $order['id']);
            $totalItems += count($items);
        }

        // VIOLATION 4 (CRITICAL): business rule and pricing logic inside controller
        $subtotal     = (float) $request->input('subtotal', 0);
        $discountRate = 0.0;
        if ($subtotal > 1000) {
            $discountRate = 0.20;
        } elseif ($subtotal > 500) {
            $discountRate = 0.10;
        }

        $discountAmount = $subtotal * $discountRate;
        $finalTotal     = $subtotal - $discountAmount;

        return [
            'users_found'       => count($userRows),
            'orders_scanned'    => count($orders),
            'total_items'       => $totalItems,
            'subtotal'          => $subtotal,
            'discount_rate'     => $discountRate,
            'discount_amount'   => $discountAmount,
            'final_total'       => $finalTotal,
            'debug_key_preview' => substr($paymentGatewayKey, 0, 8),
        ];
    }
}
