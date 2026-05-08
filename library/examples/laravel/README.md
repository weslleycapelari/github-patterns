# Laravel Examples

Reference implementations for Laravel projects following the standards in `library/standards/` and `library/stacks/laravel/`.

## Files

### 1. `PerfectAction.php`

**Purpose**: Reference implementation of a domain action class with Laravel best practices.

**Pattern**: Command pattern combined with DTOs for type-safe, testable business logic.

**Case Study**: `CreateProductVariantAction` demonstrates:

- ✅ Single responsibility principle (one action = one use case)
- ✅ Immutable DTOs for input (CreateProductVariantRequest)
- ✅ Immutable DTOs for output (ProductVariantCreated)
- ✅ Guard clauses and early returns
- ✅ Authorization checks with policies (not gates)
- ✅ Database transaction safety
- ✅ Type hints on parameters and returns (strict_types=1)
- ✅ Custom exceptions for domain rules
- ✅ Composed private methods for complex logic
- ✅ FormRequest for framework-level validation
- ✅ Comments with `// AI-REFERENCE:` explaining each pattern
- ✅ Validation with Psalm level 8+, PHPStan level 9

**Implementation Standards**:

- [code-design-logic.md](../standards/code-design-logic.md) — Immutability, guard clauses
- [testing-excellence.md](../standards/testing-excellence.md) — TDD, AAA pattern
- [php-standards.instructions.md](../stacks/laravel/php-standards.instructions.md) — Type safety, validation

### 2. `PerfectAction.md`

**Purpose**: Complete guide to understanding and implementing `PerfectAction.php`.

**Contents**:

- Detailed breakdown of each class and method
- Explanation of every pattern (why it's implemented that way)
- Test examples with AAA pattern
- Validation checklist (13 quality gates)
- Integration steps for your project
- Anti-patterns to avoid
- References and further reading

**Use this to**:

- Onboard new team members
- Deep-dive code reviews
- Train teams on excellence standards
- Define your own coding guidelines

### 3. `CreateProductVariantActionTest.php`

**Purpose**: Complete test suite for the action, demonstrating AAA pattern and comprehensive coverage.

**Test Coverage** (13 tests):

- ✅ Happy path: successful creation with stock allocation
- ✅ Boundary conditions: zero stock, minimal data
- ✅ Authorization failures: unauthorized user
- ✅ Validation failures: duplicate SKU, invalid product ID
- ✅ Constraint violations: negative stock, invalid price
- ✅ Soft constraints: cost > price (logged warning)
- ✅ DTO conversion: from FormRequest to domain
- ✅ Serialization: DTO to JSON-ready array

**Pattern**: Every test follows AAA (Arrange → Act → Assert)

**Use this to**:

- Copy and adapt for your own action tests
- Learn how to test actions without framework mocks
- Verify that the pattern works in a real Laravel test suite

---

## How to Use PerfectAction.php as a Template

### Step 1: Understand the Structure

Read through the file in this order:

1. **Class docstring** — Explains the use case and patterns
2. **Public `__invoke()` method** — Entry point with type hints
3. **Private methods** — Composed responsibilities
4. **DTOs** — Input/Output contracts
5. **FormRequest** — HTTP validation
6. **Test examples** (in comments) — AAA pattern examples

### Step 2: Create Your Action

Copy the structure for your domain action:

```php
<?php

declare(strict_types=1);

namespace App\Actions\YourDomain;

final class YourAction
{
    public function __invoke(
        YourRequest $request,
        User $user,
    ): YourResult {
        // 1. Guard clauses first (authorization, validation)
        $this->authorize($request, $user);

        // 2. Use DB::transaction for multi-step operations
        return DB::transaction(
            fn () => $this->executeCore($request, $user)
        );
    }

    private function authorize(YourRequest $request, User $user): void
    {
        // Check permissions using policies
        if (!$user->can('action', $request->model())) {
            throw new AuthorizationException('Not authorized');
        }
    }

    private function executeCore(YourRequest $request, User $user): YourResult
    {
        // Business logic
        // Return immutable result DTO
        return new YourResult(...);
    }
}
```

### Step 3: Create DTOs

Always use DTOs at boundaries:

```php
// Input DTO
final class YourRequest
{
    public function __construct(
        readonly public int $id,
        readonly public string $name,
        // ... more properties
    ) {
        $this->validate();
    }

    private function validate(): void
    {
        // Domain-level validation
        if (empty(trim($this->name))) {
            throw new InvalidArgumentException('Name cannot be empty');
        }
    }

    public static function fromValidated(array $validated): static
    {
        return new static(
            id: intval($validated['id']),
            name: strval($validated['name']),
        );
    }
}

// Output DTO
final class YourResult
{
    public function __construct(
        readonly public int $id,
        readonly public string $message,
    ) {
    }

    public function toArray(): array
    {
        return [
            'id' => $this->id,
            'message' => $this->message,
        ];
    }
}
```

### Step 4: Write Tests (AAA Pattern)

Use the test examples embedded in `PerfectAction.php`:

```php
// tests/Feature/Actions/YourActionTest.php

final class YourActionTest extends TestCase
{
    use DatabaseTransactions;

    #[Test]
    public function it_executes_with_valid_data(): void
    {
        // === ARRANGE ===
        $user = User::factory()->create();
        $request = new YourRequest(
            id: 1,
            name: 'Test',
        );
        $action = new YourAction();

        // === ACT ===
        $result = $action($request, $user);

        // === ASSERT ===
        $this->assertInstanceOf(YourResult::class, $result);
        $this->assertEquals(1, $result->id);
    }

    #[Test]
    public function it_throws_if_unauthorized(): void
    {
        // === ARRANGE ===
        $user = User::factory()->create();
        $request = new YourRequest(id: 1, name: 'Test');
        $action = new YourAction();

        // === ACT & ASSERT ===
        $this->expectException(AuthorizationException::class);
        $action($request, $user);
    }
}
```

---

## Key Patterns in PerfectAction.php

### 1. Guard Clauses (Early Returns)

```php
private function authorize(int $productId, User $user): void
{
    if (!$user->can('update', $product)) {
        throw new AuthorizationException('Not authorized');
    }
    // Early return; no nested if needed
}
```

**Why**: Reduces nesting, makes happy path clear, fail-fast on invalid input.

### 2. Database Transactions

```php
return DB::transaction(
    fn () => $this->createVariant($request, $user)
);
```

**Why**: Multi-step operations must be atomic. If variant creation succeeds but stock allocation fails, everything rolls back.

### 3. Policy-Based Authorization (Not Gates)

```php
if (!$user->can('update', $product)) {
    throw new AuthorizationException(...);
}
```

**Why**: Policies bind authorization to a specific model. Gates are global toggles; policies scale with your data.

### 4. Immutable DTOs

```php
final class CreateProductVariantRequest
{
    public function __construct(
        readonly public int $productId,
        readonly public string $sku,
        // ...
    ) {
        $this->validateInputs();
    }
}
```

**Why**: Type-safe, prevents mutation, validates at construction time.

### 5. Composed Private Methods

```php
public function __invoke(CreateProductVariantRequest $request, User $user): ProductVariantCreated
{
    $this->authorize($request->productId, $user);
    return DB::transaction(fn () => $this->createVariant($request, $user));
}

private function createVariant(CreateProductVariantRequest $request, User $user): ProductVariantCreated
{
    // Main logic
}

private function allocateInitialStock(ProductVariant $variant, int $quantity): void
{
    // Supporting logic
}
```

**Why**: Each method has a single responsibility. Easy to test. Easy to understand.

---

## Common Mistakes to Avoid

❌ **Too Much Logic in Controllers**

```php
// Bad
Route::post('/variants', function (Request $request) {
    // Validation, authorization, business logic, persistence all mixed
    ...
});
```

✅ **Delegate to Actions**

```php
// Good
Route::post('/variants', [VariantController::class, 'store']);

// In controller
public function store(CreateVariantRequest $validated, User $user)
{
    $request = CreateProductVariantRequest::fromValidated($validated->validated());
    $result = (new CreateProductVariantAction())($request, $user);
    return response()->json($result->toArray());
}
```

---

❌ **Mutable Model Returned Directly**

```php
// Bad
public function createVariant(CreateVariantRequest $request): ProductVariant
{
    $variant = new ProductVariant([...]);
    $variant->save();
    return $variant; // Caller can mutate!
}
```

✅ **Immutable DTO Output**

```php
// Good
public function createVariant(CreateVariantRequest $request): ProductVariantCreated
{
    $variant = new ProductVariant([...]);
    $variant->save();
    return new ProductVariantCreated(
        id: $variant->id,
        sku: $variant->sku,
        // Only what caller needs
    );
}
```

---

❌ **Global Gates for Data-Bound Authorization**

```php
// Bad
if (Gate::check('edit-variant')) { // Global gate
    ...
}
```

✅ **Model Policies**

```php
// Good
if ($user->can('update', $variant)) { // Bound to $variant model
    ...
}
```

---

## Audit Checklist: Reviewing Laravel Actions

Use this when reviewing action classes in your codebase:

- [ ] Has single responsibility (one use case)?
- [ ] Input is an immutable DTO?
- [ ] Output is an immutable DTO?
- [ ] Guard clauses at the top?
- [ ] Early returns instead of nesting?
- [ ] Database transactions for multi-step operations?
- [ ] Authorization with policies (not gates)?
- [ ] Type hints on all parameters and returns?
- [ ] Custom exceptions for domain rules?
- [ ] Tests use AAA pattern?
- [ ] Tests cover happy path and error cases?
- [ ] Tests verify authorization check?

---

## Documentation Files

This directory includes comprehensive documentation to help you understand and implement the patterns:

- **[PerfectAction.md](PerfectAction.md)** — Detailed guide explaining every class, method, and pattern in `PerfectAction.php`. **Start here** if you're learning the patterns.
- **[CreateProductVariantActionTest.php](CreateProductVariantActionTest.php)** — Complete test suite (13 tests) demonstrating AAA pattern. Copy and adapt for your own action tests.

---

## Related Documentation

- **Laravel Stack**: See `library/stacks/laravel/` for full Laravel guidance
- **PHP Standards**: See `library/stacks/laravel/php-standards.instructions.md`
- **Testing**: See `library/examples/common/PerfectTest.test.ts` for AAA pattern
- **Code Design**: See `library/standards/code-design-logic.md` for immutability rules

---

## Quick Validation Commands

Verify your implementation before committing:

```bash
# Syntax check
php -l app/Actions/YourDomain/YourAction.php

# Type checking (Psalm)
psalm app/Actions/YourDomain/YourAction.php --level 8

# Type checking (PHPStan)
phpstan analyse app/Actions/YourDomain/YourAction.php --level 9

# Run tests
php artisan test tests/Feature/Actions/YourActionTest.php
```

---

## Next Steps

1. Read [PerfectAction.md](PerfectAction.md) to understand all patterns
2. Copy the structure from `PerfectAction.php`
3. Adapt for your domain logic
4. Write tests using [CreateProductVariantActionTest.php](CreateProductVariantActionTest.php) as template
5. Run validation commands above
6. Use the audit checklist before merge

---

**Status**: Phase 1 Complete (PerfectAction.php implemented)  
**Components**: PerfectAction.php + PerfectAction.md + CreateProductVariantActionTest.php  
**Next**: PerfectMigration.php, PerfectTestCase.php (Phase 2)
