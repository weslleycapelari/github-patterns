# MVP Prompt 02 — Módulo de Pedidos (Order + OrderItem)

## Objetivo

Implementar domínio de pedidos com transições de status e reserva/liberação de estoque com TDD.

## Prompt

```text
Projeto: Elite-Shop (Laravel 13.8). Contexto completo no llms.txt e nos arquivos existentes.

Modelos já existentes: Product, ProductVariant, User.

TAREFA: Implemente o módulo de Pedidos completo seguindo TDD (escreva os testes ANTES do código):

**1. Migrations (em ordem):**
- `create_orders_table`: id, user_id FK (nullable — guest checkout), guest_email (nullable), status enum(pending/confirmed/processing/shipped/delivered/cancelled) default pending, subtotal decimal(10,2), discount decimal(10,2) default 0, shipping_cost decimal(10,2) default 0, total decimal(10,2), notes text nullable, timestamps, softDeletes. Indexes: (user_id, status), (status, created_at).
- `create_order_items_table`: id, order_id FK cascade, product_variant_id FK restrict, quantity unsigned int, unit_price decimal(10,2), total_price decimal(10,2) (calculado: quantity * unit_price), timestamps.

**2. Enums:**
- `app/Enums/OrderStatus.php`: Pending, Confirmed, Processing, Shipped, Delivered, Cancelled. Método `isTerminal(): bool` (Delivered, Cancelled). Método `canTransitionTo(OrderStatus): bool` (regras de máquina de estado).

**3. DTOs:**
- `app/DataTransferObjects/OrderItemData.php`: readonly, productVariantId, quantity, unitPrice
- `app/DataTransferObjects/CreateOrderData.php`: readonly, ?int $userId, ?string $guestEmail, array $items (OrderItemData[]), ?string $notes

**4. Models:**
- `app/Models/Order.php`: SoftDeletes, casts (status=>OrderStatus, decimais), $guarded=['*'], relationships: user(), items(), scopePending(), scopeByStatus()
- `app/Models/OrderItem.php`: casts decimais, $guarded=['*'], relationships: order(), variant()

**5. Exceptions:**
- `app/Exceptions/OrderNotFoundException.php`
- `app/Exceptions/InvalidOrderTransitionException.php` — mensagem: "Cannot transition order [{$orderId}] from {$from->value} to {$to->value}."

**6. Service:**
- `app/Services/OrderService.php`: métodos create(CreateOrderData): Order, confirm(Order): Order, cancel(Order): Order, markShipped(Order): Order. Cada transição usa canTransitionTo() e lança InvalidOrderTransitionException se inválida. O create() reserva estoque chamando ProductService::adjustStock() com StockMovementType::Reservation e lança InsufficientStockException se não houver estoque. Use DB::transaction().

**7. Testes Pest** em `tests/Unit/Services/OrderServiceTest.php` — mínimo 20 casos cobrindo: criação com itens, reserva de estoque, transições válidas e inválidas, guest checkout, cancelamento libera estoque.

Siga as regras: imutabilidade, early return, funções < 50 linhas, $guarded=['*'] nos models.
```

## Critérios de aceite

- Migrations de `orders` e `order_items` aplicadas com índices solicitados.
- `OrderStatus` com `isTerminal()` e `canTransitionTo()` cobrindo a máquina de estados.
- `OrderService` com transações e integração com reserva/liberação de estoque.
- Testes de `OrderService` com no mínimo 20 cenários passando.
