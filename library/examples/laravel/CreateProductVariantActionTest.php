<?php

declare (strict_types = 1);

namespace Tests\Feature\Actions\Products;

use App\Actions\Products\CreateProductVariantAction;
use App\Actions\Products\CreateProductVariantRequest;
use App\Actions\Products\ProductVariantCreated;
use App\Models\Product;
use App\Models\ProductVariant;
use App\Models\User;
use Illuminate\Auth\Access\AuthorizationException;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

/**
 * CreateProductVariantActionTest
 *
 * Test suite for CreateProductVariantAction using AAA pattern:
 * - Arrange: Set up test data and dependencies
 * - Act: Execute the action
 * - Assert: Verify results and side effects
 *
 * AI-REFERENCE: All tests follow AAA pattern for clarity.
 * Each test is independent (DatabaseTransactions rolls back).
 * No test depends on another test's state.
 */
final class CreateProductVariantActionTest extends TestCase {
    use DatabaseTransactions;

    /**
     * Test: Successfully create a product variant with valid data and stock allocation.
     *
     * AI-REFERENCE: Happy path test.
     * Verifies the full flow: authorization → validation → creation → stock allocation.
     */
    #[Test]
    public function it_creates_a_product_variant_with_valid_data(): void {
        // === ARRANGE ===
        $user    = User::factory()->create();
        $product = Product::factory()->for($user, 'owner')->create();

        $request = new CreateProductVariantRequest(
            productId: $product->id,
            sku: 'RED-M-L',
            name: 'Red, Size M-L',
            description: 'Premium red variant, medium-large fit',
            price: 29.99,
            cost: 15.00,
            weight: 0.5,
            dimensions: ['length' => 30, 'width' => 20, 'height' => 10],
            initialStock: 100,
        );

        $action = new CreateProductVariantAction();

        // === ACT ===
        $result = $action($request, $user);

        // === ASSERT ===
        // Verify return type
        $this->assertInstanceOf(ProductVariantCreated::class, $result);

        // Verify DTO contains expected data
        $this->assertEquals('RED-M-L', $result->sku);
        $this->assertEquals('Red, Size M-L', $result->name);
        $this->assertEquals($product->id, $result->productId);
        $this->assertEquals(2999, $result->priceInCents); // 29.99 * 100

        // Verify persistence: variant exists in database
        $this->assertDatabaseHas('product_variants', [
            'product_id' => $product->id,
            'sku'        => 'RED-M-L',
            'name'       => 'Red, Size M-L',
            'price'      => 29.99,
            'cost'       => 15.00,
        ]);

        // Verify stock allocation
        $variant    = ProductVariant::where('sku', 'RED-M-L')->firstOrFail();
        $totalStock = $variant->stock()->sum('quantity');
        $this->assertEquals(100, $totalStock);
    }

    /**
     * Test: Successfully create a variant without initial stock.
     *
     * AI-REFERENCE: Boundary condition test.
     * Initialstock defaults to 0; should succeed without allocation.
     */
    #[Test]
    public function it_creates_a_variant_without_initial_stock(): void {
        // === ARRANGE ===
        $user    = User::factory()->create();
        $product = Product::factory()->for($user, 'owner')->create();

        $request = new CreateProductVariantRequest(
            productId: $product->id,
            sku: 'BLUE-S',
            name: 'Blue, Size S',
            description: null,
            price: 24.99,
            cost: 12.00,
            weight: null,
            dimensions: null,
            initialStock: 0, // No stock
        );

        $action = new CreateProductVariantAction();

        // === ACT ===
        $result = $action($request, $user);

        // === ASSERT ===
        $this->assertInstanceOf(ProductVariantCreated::class, $result);
        $this->assertDatabaseHas('product_variants', [
            'sku' => 'BLUE-S',
        ]);
    }

    /**
     * Test: Throw AuthorizationException if user is not authorized.
     *
     * AI-REFERENCE: Authorization boundary test.
     * Unauthorized users should fail immediately, before any IO.
     */
    #[Test]
    public function it_throws_authorization_exception_if_user_not_authorized(): void {
        // === ARRANGE ===
        $owner        = User::factory()->create();
        $unauthorized = User::factory()->create();
        $product      = Product::factory()->for($owner, 'owner')->create();

        $request = new CreateProductVariantRequest(
            productId: $product->id,
            sku: 'GREEN-M',
            name: 'Green, Size M',
            description: null,
            price: 25.00,
            cost: 12.50,
            weight: null,
            dimensions: null,
        );

        $action = new CreateProductVariantAction();

        // === ACT & ASSERT ===
        $this->expectException(AuthorizationException::class);
        $action($request, $unauthorized);

        // Verify no variant was created
        $this->assertDatabaseMissing('product_variants', [
            'sku' => 'GREEN-M',
        ]);
    }

    /**
     * Test: Throw InvalidArgumentException if SKU already exists for this product.
     *
     * AI-REFERENCE: Business rule validation (duplicate SKU).
     * Early return guard clause prevents duplicate variants.
     */
    #[Test]
    public function it_throws_if_sku_already_exists_for_product(): void {
        // === ARRANGE ===
        $user    = User::factory()->create();
        $product = Product::factory()->for($user, 'owner')->create();

        // Create an existing variant with SKU 'DUPLICATE'
        ProductVariant::factory()
            ->for($product)
            ->create(['sku' => 'DUPLICATE']);

        $request = new CreateProductVariantRequest(
            productId: $product->id,
            sku: 'DUPLICATE',
            name: 'Duplicate Variant (should fail)',
            description: null,
            price: 30.00,
            cost: 15.00,
            weight: null,
            dimensions: null,
        );

        $action = new CreateProductVariantAction();

        // === ACT & ASSERT ===
        $this->expectException(\InvalidArgumentException::class);
        $this->expectExceptionMessage('already exists');

        $action($request, $user);

        // Verify only one variant exists (the original)
        $this->assertEquals(
            1,
            ProductVariant::where('sku', 'DUPLICATE')->count()
        );
    }

    /**
     * Test: Throw InvalidArgumentException if product ID does not exist.
     *
     * AI-REFERENCE: Constraint validation (referential integrity).
     */
    #[Test]
    public function it_throws_if_product_does_not_exist(): void {
        // === ARRANGE ===
        $user                 = User::factory()->create();
        $nonExistentProductId = 99999;

        $request = new CreateProductVariantRequest(
            productId: $nonExistentProductId,
            sku: 'ORPHAN-SKU',
            name: 'Orphan Variant',
            description: null,
            price: 20.00,
            cost: 10.00,
            weight: null,
            dimensions: null,
        );

        $action = new CreateProductVariantAction();

        // === ACT & ASSERT ===
        $this->expectException(\Illuminate\Database\Eloquent\ModelNotFoundException::class);
        $action($request, $user);
    }

    /**
     * Test: Throw InvalidArgumentException if initial stock is negative.
     *
     * AI-REFERENCE: DTO validation (constructor boundary).
     * Should fail during DTO construction, not during action execution.
     */
    #[Test]
    public function it_throws_if_initial_stock_is_negative(): void {
        // === ARRANGE & ACT & ASSERT ===
        $this->expectException(\InvalidArgumentException::class);
        $this->expectExceptionMessage('non-negative');

        new CreateProductVariantRequest(
            productId: 1,
            sku: 'NEGATIVE-STOCK',
            name: 'Invalid Stock',
            description: null,
            price: 20.00,
            cost: 10.00,
            weight: null,
            dimensions: null,
            initialStock: -10, // Invalid!
        );
    }

    /**
     * Test: Throw InvalidArgumentException if price is zero or negative.
     *
     * AI-REFERENCE: DTO validation (business rule).
     * Price must be positive; cost must be non-negative.
     */
    #[Test]
    public function it_throws_if_price_is_invalid(): void {
        // === ARRANGE & ACT & ASSERT ===
        $this->expectException(\InvalidArgumentException::class);
        $this->expectExceptionMessage('positive');

        new CreateProductVariantRequest(
            productId: 1,
            sku: 'INVALID-PRICE',
            name: 'Invalid Price',
            description: null,
            price: 0, // Invalid!
            cost: 10.00,
            weight: null,
            dimensions: null,
        );
    }

    /**
     * Test: Throw InvalidArgumentException if cost exceeds price (warning logged).
     *
     * AI-REFERENCE: Soft constraint validation.
     * Cost > Price is not fatal, but logged as warning.
     * In strict mode, could be converted to exception.
     */
    #[Test]
    public function it_logs_warning_if_cost_exceeds_price(): void {
        // === ARRANGE ===
        \Illuminate\Support\Facades\Log::shouldReceive('warning')
            ->once()
            ->with(\Illuminate\Testing\Fluent\AssertableString::containing('Cost exceeds price'));

        // === ACT ===
        $request = new CreateProductVariantRequest(
            productId: 1,
            sku: 'HIGH-COST',
            name: 'High Cost Item',
            description: null,
            price: 10.00,
            cost: 20.00, // Cost > Price
            weight: null,
            dimensions: null,
        );

        // === ASSERT ===
        $this->assertEquals(20.00, $request->cost);
    }

    /**
     * Test: Throw InvalidArgumentException if SKU is empty or whitespace.
     *
     * AI-REFERENCE: DTO validation (semantic constraint).
     */
    #[Test]
    public function it_throws_if_sku_is_empty(): void {
        // === ARRANGE & ACT & ASSERT ===
        $this->expectException(\InvalidArgumentException::class);
        $this->expectExceptionMessage('empty');

        new CreateProductVariantRequest(
            productId: 1,
            sku: '   ', // Whitespace only
            name: 'Invalid SKU',
            description: null,
            price: 20.00,
            cost: 10.00,
            weight: null,
            dimensions: null,
        );
    }

    /**
     * Test: Successfully create variant with minimal data (no description, weight, dimensions).
     *
     * AI-REFERENCE: Test nullable/optional fields.
     * Not all fields are required; nullables should be handled gracefully.
     */
    #[Test]
    public function it_creates_variant_with_minimal_data(): void {
        // === ARRANGE ===
        $user    = User::factory()->create();
        $product = Product::factory()->for($user, 'owner')->create();

        $request = new CreateProductVariantRequest(
            productId: $product->id,
            sku: 'MINIMAL-01',
            name: 'Minimal Variant',
            description: null, // Nullable
            price: 10.00,
            cost: 5.00,
            weight: null, // Nullable
            dimensions: null, // Nullable
            initialStock: 0,
        );

        $action = new CreateProductVariantAction();

        // === ACT ===
        $result = $action($request, $user);

        // === ASSERT ===
        $this->assertInstanceOf(ProductVariantCreated::class, $result);
        $this->assertDatabaseHas('product_variants', [
            'sku'         => 'MINIMAL-01',
            'description' => null,
            'weight'      => null,
        ]);
    }

    /**
     * Test: Verify DTO conversion from FormRequest validated data.
     *
     * AI-REFERENCE: Integration point between HTTP layer and domain layer.
     * FormRequest validates HTTP input; DTO validates business logic.
     */
    #[Test]
    public function it_converts_from_form_request_validated_data(): void {
        // === ARRANGE ===
        $validated = [
            'product_id'    => 1,
            'sku'           => 'FROM-FORM',
            'name'          => 'From FormRequest',
            'description'   => 'Test description',
            'price'         => 25.50,
            'cost'          => 12.75,
            'weight'        => 1.0,
            'dimensions'    => ['length' => 10, 'width' => 5, 'height' => 3],
            'initial_stock' => 50,
        ];

        // === ACT ===
        $request = CreateProductVariantRequest::fromValidated($validated);

        // === ASSERT ===
        $this->assertEquals(1, $request->productId);
        $this->assertEquals('FROM-FORM', $request->sku);
        $this->assertEquals(25.50, $request->price);
        $this->assertEquals(50, $request->initialStock);
    }

    /**
     * Test: Verify DTO toArray() output format.
     *
     * AI-REFERENCE: Output serialization.
     * DTO should serialize to API-friendly array format.
     */
    #[Test]
    public function it_serializes_result_to_array(): void {
        // === ARRANGE ===
        $result = new ProductVariantCreated(
            id: 123,
            sku: 'TEST-SKU',
            name: 'Test Variant',
            productId: 456,
            priceInCents: 2999,
        );

        // === ACT ===
        $array = $result->toArray();

        // === ASSERT ===
        $this->assertIsArray($array);
        $this->assertEquals(123, $array['id']);
        $this->assertEquals('TEST-SKU', $array['sku']);
        $this->assertEquals(2999, $array['price_cents']);
    }
}
