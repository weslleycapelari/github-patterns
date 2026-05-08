<?php

declare (strict_types = 1);

namespace App\Actions\Products;

use App\Models\Product;
use App\Models\ProductVariant;
use App\Models\User;
use Illuminate\Auth\Access\AuthorizationException;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

/**
 * CreateProductVariantAction
 *
 * Demonstrates Laravel excellence patterns:
 * - Immutable DTOs at boundaries
 * - Early returns for guard clauses
 * - Type-strict parameters and returns
 * - Policy-based authorization
 * - Transaction safety for multi-step operations
 * - Single responsibility (one action = one use case)
 *
 * Usage:
 *   $request = new CreateProductVariantRequest(...);
 *   $action = new CreateProductVariantAction();
 *   $result = $action($request, auth()->user());
 */
final class CreateProductVariantAction {
    /**
     * Execute the action: create a new product variant with authorized checks.
     *
     * AI-REFERENCE: Single responsibility pattern.
     * This action handles ONE use case: creating a product variant.
     * Validation, authorization, and persistence are composed but clear.
     *
     * @param  CreateProductVariantRequest  $request  Immutable DTO with validated input
     * @param  User                         $user     Authenticated user (actor)
     * @return ProductVariantCreated                   Immutable DTO output
     *
     * @throws AuthorizationException     If user lacks permission
     * @throws \InvalidArgumentException  If request data is invalid
     */
    public function __invoke(
        CreateProductVariantRequest $request,
        User $user,
    ): ProductVariantCreated {
        // AI-REFERENCE: Early return guard clauses.
        // Fail fast before any mutation. Authorization first.
        $this->authorize($request->productId, $user);

        // AI-REFERENCE: Transaction boundary.
        // Multi-step state changes must be atomic.
        // If variant creation succeeds but stock allocation fails,
        // the whole operation rolls back.
        return DB::transaction(
            fn() => $this->createVariant($request, $user)
        );
    }

    /**
     * Authorize the user to create a variant for the product.
     *
     * AI-REFERENCE: Policy-based authorization (not gate).
     * Gates are global toggles; policies bind authorization to a model.
     * This ensures that authorization scales with your data model.
     *
     * @throws AuthorizationException
     */
    private function authorize(int $productId, User $user): void {
        $product = Product::findOrFail($productId);

        // AI-REFERENCE: Use Laravel's Policy::authorize() for clarity.
        // This is type-safe and throws AuthorizationException if denied.
        if (!$user->can('update', $product)) {
            throw new AuthorizationException(
                'You are not authorized to create variants for this product.'
            );
        }
    }

    /**
     * Persist the new variant and return the result.
     *
     * AI-REFERENCE: Pure business logic, isolated from framework concerns.
     * This private method contains the core logic and is fully testable.
     */
    private function createVariant(
        CreateProductVariantRequest $request,
        User $user,
    ): ProductVariantCreated {
        // AI-REFERENCE: Fetch required model within the transaction.
        // If the product was deleted between authorize() and here,
        // the transaction prevents inconsistent state.
        $product = Product::lockForUpdate()->findOrFail($request->productId);

        // AI-REFERENCE: Guard clause for duplicate SKU.
        // Early return pattern: if a variant with this SKU exists, fail fast.
        $existingVariant = ProductVariant::query()
            ->where('product_id', $product->id)
            ->where('sku', $request->sku)
            ->first();

        if ($existingVariant instanceof ProductVariant) {
            throw new \InvalidArgumentException(
                sprintf(
                    'A variant with SKU "%s" already exists for this product.',
                    $request->sku
                )
            );
        }

        // AI-REFERENCE: Immutable spread for safe data construction.
        // Create a new ProductVariant with validated and typed data.
        // No hidden mutations; all state changes are explicit.
        $variant = new ProductVariant([
            'product_id'  => $product->id,
            'sku'         => $request->sku,
            'name'        => $request->name,
            'description' => $request->description,
            'price'       => $request->price,
            'cost'        => $request->cost,
            'weight'      => $request->weight,
            'dimensions'  => $request->dimensions, // JSON: immutable in scope
        ]);

        // AI-REFERENCE: Explicit type and validation.
        // Save returns bool; check it to ensure success.
        $isSaved = $variant->save();

        if (!$isSaved) {
            throw new \RuntimeException('Failed to persist product variant.');
        }

        // AI-REFERENCE: Allocate initial stock in the same transaction.
        // If allocation fails, the entire transaction rolls back.
        $this->allocateInitialStock($variant, $request->initialStock);

        // AI-REFERENCE: Return immutable DTO output.
        // Caller receives only the data they need.
        // No hidden side effects; no mutable model returned.
        return new ProductVariantCreated(
            id: $variant->id,
            sku: $variant->sku,
            name: $variant->name,
            productId: $product->id,
            priceInCents: intval($variant->price * 100),
        );
    }

    /**
     * Allocate initial stock for the newly created variant.
     *
     * AI-REFERENCE: Composed responsibility.
     * Stock allocation is a separate concern but must succeed atomically
     * with variant creation (within the transaction).
     */
    private function allocateInitialStock(
        ProductVariant $variant,
        int $quantity,
    ): void {
        // Guard: only allocate positive quantities.
        if ($quantity < 0) {
            throw new \InvalidArgumentException('Initial stock quantity must be non-negative.');
        }

        if ($quantity === 0) {
            return; // No stock to allocate.
        }

        // Create a stock record (simplified; your implementation may vary).
        $variant->stock()->create([
            'warehouse_id' => config('warehouse.default_id'),
            'quantity'     => $quantity,
            'reserved'     => 0,
        ]);
    }
}

/**
 * CreateProductVariantRequest
 *
 * Immutable DTO for input validation.
 *
 * AI-REFERENCE: Data Transfer Object (DTO) for boundaries.
 * This ensures type safety at the action entry point.
 * All properties are typed and immutable (readonly).
 */
final class CreateProductVariantRequest {
    /**
     * @param  int     $productId      Product ID (from authenticated request)
     * @param  string  $sku           SKU value (validated, unique per product)
     * @param  string  $name          Variant name (e.g., "Red, Size M")
     * @param  string|null $description Optional description
     * @param  float   $price         Retail price in main currency unit
     * @param  float   $cost          Cost in main currency unit
     * @param  float|null $weight     Weight in kg (nullable for digital products)
     * @param  array|null $dimensions Dimensions as JSON: {length, width, height}
     * @param  int     $initialStock  Quantity to allocate at creation
     */
    public function __construct(
        readonly public int $productId,
        readonly public string $sku,
        readonly public string $name,
        readonly public ?string $description,
        readonly public float $price,
        readonly public float $cost,
        readonly public ?float $weight,
        readonly public ?array $dimensions,
        readonly public int $initialStock = 0,
    ) {
        // AI-REFERENCE: Constructor validation.
        // Fail fast if DTO is constructed with invalid data.
        $this->validateInputs();
    }

    /**
     * Validate DTO constraints.
     */
    private function validateInputs(): void {
        // SKU must not be empty.
        if (empty(trim($this->sku))) {
            throw new \InvalidArgumentException('SKU cannot be empty.');
        }

        // Prices must be positive.
        if ($this->price <= 0 || $this->cost < 0) {
            throw new \InvalidArgumentException('Price must be positive; cost must be non-negative.');
        }

        // Cost must not exceed price (not a hard rule, but logged).
        if ($this->cost > $this->price) {
            \Log::warning('Cost exceeds price for SKU: ' . $this->sku);
        }

        // Weight must be positive if provided.
        if ($this->weight !== null && $this->weight <= 0) {
            throw new \InvalidArgumentException('Weight must be positive.');
        }
    }

    /**
     * Factory method for creating from FormRequest data.
     *
     * AI-REFERENCE: Conversion from FormRequest to DTO.
     * FormRequest validates the HTTP layer; DTO validates business logic.
     * Separation of concerns: framework validation vs. domain validation.
     *
     * @param  array  $validated  Pre-validated data from FormRequest::validated()
     * @return static
     */
    public static function fromValidated(array $validated): static
    {
        return new static(
            productId: intval($validated['product_id']),
            sku: strval($validated['sku']),
            name: strval($validated['name']),
            description: $validated['description'] ?? null,
            price: floatval($validated['price']),
            cost: floatval($validated['cost']),
            weight: isset($validated['weight']) ? floatval($validated['weight']) : null,
            dimensions: $validated['dimensions'] ?? null,
            initialStock: intval($validated['initial_stock'] ?? 0),
        );
    }
}

/**
 * ProductVariantCreated
 *
 * Immutable DTO for output result.
 *
 * AI-REFERENCE: Output DTO (result contract).
 * Caller receives only what they need to know.
 * No risk of caller mutating model state.
 */
final class ProductVariantCreated {
    public function __construct(
        readonly public int $id,
        readonly public string $sku,
        readonly public string $name,
        readonly public int $productId,
        readonly public int $priceInCents,
    ) {
    }

    /**
     * Serialize to API response.
     *
     * @return array<string, mixed>
     */
    public function toArray(): array {
        return [
            'id'          => $this->id,
            'sku'         => $this->sku,
            'name'        => $this->name,
            'product_id'  => $this->productId,
            'price_cents' => $this->priceInCents,
        ];
    }
}

/**
 * CreateProductVariantFormRequest
 *
 * Laravel FormRequest for HTTP validation.
 *
 * AI-REFERENCE: FormRequest for framework-level validation.
 * Validates HTTP input, prevents XSS/injection, and handles common violations.
 * Complements the DTO's business logic validation.
 */
final class CreateProductVariantFormRequest {
    /**
     * Get validation rules.
     *
     * @return array<string, array<string>|string>
     */
    public function rules(): array {
        return [
            'product_id'    => ['required', 'integer', 'exists:products,id'],
            'sku'           => ['required', 'string', 'min:3', 'max:50', 'regex:/^[A-Z0-9\-]+$/'],
            'name'          => ['required', 'string', 'min:3', 'max:255'],
            'description'   => ['nullable', 'string', 'max:1000'],
            'price'         => ['required', 'numeric', 'min:0.01', 'decimal:2'],
            'cost'          => ['required', 'numeric', 'min:0', 'decimal:2'],
            'weight'        => ['nullable', 'numeric', 'min:0.01'],
            'dimensions'    => ['nullable', 'json'],
            'initial_stock' => ['nullable', 'integer', 'min:0'],
        ];
    }

    /**
     * Get custom validation messages.
     *
     * @return array<string, string>
     */
    public function messages(): array {
        return [
            'sku.regex'         => 'SKU must contain only uppercase letters, numbers, and hyphens.',
            'product_id.exists' => 'The selected product does not exist.',
        ];
    }
}

/**
 * ============================================================================
 * EXAMPLE TEST (AAA Pattern)
 * ============================================================================
 *
 * This demonstrates how to test the action with the AAA pattern:
 * Arrange, Act, Assert.
 *
 * File: tests/Feature/Actions/CreateProductVariantActionTest.php
 */

// namespace Tests\Feature\Actions;
//
// use App\Actions\Products\CreateProductVariantAction;
// use App\Actions\Products\CreateProductVariantRequest;
// use App\Models\Product;
// use App\Models\User;
// use Illuminate\Auth\Access\AuthorizationException;
// use Illuminate\Foundation\Testing\DatabaseTransactions;
// use Illuminate\Foundation\Testing\WithFaker;
// use Illuminate\Support\Facades\DB;
// use PHPUnit\Framework\Attributes\Test;
// use Tests\TestCase;
//
// final class CreateProductVariantActionTest extends TestCase
// {
//     use DatabaseTransactions;
//
//     #[Test]
//     public function it_creates_a_product_variant_with_valid_data(): void
//     {
//         // === ARRANGE ===
//         // Create a product owned by the user.
//         $user = User::factory()->create();
//         $product = Product::factory()->for($user, 'owner')->create();
//
//         // Prepare the request DTO.
//         $request = new CreateProductVariantRequest(
//             productId: $product->id,
//             sku: 'RED-M-L',
//             name: 'Red, Size M-L',
//             description: 'Red variant, medium-large',
//             price: 29.99,
//             cost: 15.00,
//             weight: 0.5,
//             dimensions: ['length' => 30, 'width' => 20, 'height' => 10],
//             initialStock: 100,
//         );
//
//         $action = new CreateProductVariantAction();
//
//         // === ACT ===
//         $result = $action($request, $user);
//
//         // === ASSERT ===
//         $this->assertInstanceOf(ProductVariantCreated::class, $result);
//         $this->assertEquals('RED-M-L', $result->sku);
//         $this->assertEquals('Red, Size M-L', $result->name);
//         $this->assertEquals($product->id, $result->productId);
//         $this->assertEquals(2999, $result->priceInCents);
//
//         // Verify the variant was persisted.
//         $this->assertDatabaseHas('product_variants', [
//             'product_id' => $product->id,
//             'sku' => 'RED-M-L',
//             'name' => 'Red, Size M-L',
//         ]);
//
//         // Verify initial stock was allocated.
//         $variant = \App\Models\ProductVariant::where('sku', 'RED-M-L')->firstOrFail();
//         $this->assertEquals(100, $variant->stock()->sum('quantity'));
//     }
//
//     #[Test]
//     public function it_throws_if_user_not_authorized(): void
//     {
//         // === ARRANGE ===
//         $owner = User::factory()->create();
//         $unauthorized = User::factory()->create();
//         $product = Product::factory()->for($owner, 'owner')->create();
//
//         $request = new CreateProductVariantRequest(
//             productId: $product->id,
//             sku: 'BLUE-S',
//             name: 'Blue, Size S',
//             description: null,
//             price: 29.99,
//             cost: 15.00,
//             weight: null,
//             dimensions: null,
//         );
//
//         $action = new CreateProductVariantAction();
//
//         // === ACT & ASSERT ===
//         $this->expectException(AuthorizationException::class);
//         $action($request, $unauthorized);
//     }
//
//     #[Test]
//     public function it_throws_if_sku_already_exists(): void
//     {
//         // === ARRANGE ===
//         $user = User::factory()->create();
//         $product = Product::factory()->for($user, 'owner')->create();
//         ProductVariant::factory()->for($product)->create(['sku' => 'EXISTING']);
//
//         $request = new CreateProductVariantRequest(
//             productId: $product->id,
//             sku: 'EXISTING',
//             name: 'Duplicate variant',
//             description: null,
//             price: 29.99,
//             cost: 15.00,
//             weight: null,
//             dimensions: null,
//         );
//
//         $action = new CreateProductVariantAction();
//
//         // === ACT & ASSERT ===
//         $this->expectException(\InvalidArgumentException::class);
//         $action($request, $user);
//     }
//
//     #[Test]
//     public function it_rolls_back_if_stock_allocation_fails(): void
//     {
//         // === ARRANGE ===
//         $user = User::factory()->create();
//         $product = Product::factory()->for($user, 'owner')->create();
//
//         $request = new CreateProductVariantRequest(
//             productId: $product->id,
//             sku: 'ROLLBACK-TEST',
//             name: 'Test rollback',
//             description: null,
//             price: 29.99,
//             cost: 15.00,
//             weight: null,
//             dimensions: null,
//             initialStock: 100,
//         );
//
//         $action = new CreateProductVariantAction();
//
//         // Mock stock allocation to fail.
//         \Illuminate\Support\Facades\DB::shouldReceive('transaction')
//             ->andThrow(new \Exception('Stock allocation failed'));
//
//         // === ACT & ASSERT ===
//         $this->expectException(\Exception::class);
//         $action($request, $user);
//
//         // Variant should NOT exist (rolled back).
//         $this->assertDatabaseMissing('product_variants', [
//             'sku' => 'ROLLBACK-TEST',
//         ]);
//     }
// }
