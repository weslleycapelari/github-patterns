# Common Test Patterns

This folder contains reference implementations for universal testing patterns that apply across all technology stacks.

## AAA Pattern (Arrange-Act-Assert)

The AAA pattern is the **minimum readability standard** for all tests in this organization. It makes test intent explicit and helps catch errors early.

### Structure

Every test must follow this three-phase structure:

```text
┌─────────────────────────────────────────┐
│ ARRANGE: Prepare data and dependencies  │
│ (setup, mocks, fixtures, preconditions) │
├─────────────────────────────────────────┤
│ ACT: Execute the code under test        │
│ (call function, trigger action)         │
├─────────────────────────────────────────┤
│ ASSERT: Verify observable behavior      │
│ (check return value, side effects)      │
└─────────────────────────────────────────┘
```

### Why AAA Matters

- **Readability**: A test is self-documenting. Anyone reading it understands what is being tested.
- **Debugging**: When a test fails, it's clear which phase broke.
- **Testability**: Forces the code under test to have clear contracts.

## PerfectTest.test.ts

This file demonstrates AAA in practice with five real scenarios:

### 1. Synchronous Pure Function (Sections 1)

Tests a simple function with no dependencies or side effects.

**Pattern**: Input → Pure Logic → Output

```text
Test: should return discounted total when percentage is valid
├─ ARRANGE: orderTotal = 100, discountPercentage = 0.1
├─ ACT: result = calculateOrderDiscount(100, 0.1)
└─ ASSERT: expect(result).toBe(90)
```

**Lessons**:

- Keep data preparation minimal
- Assert only what matters (behavior, not implementation)
- Test boundary cases (edge cases)

### 2. Mocking Side Effects (Section 2)

Tests a function that has side effects (logging, API calls).

**Pattern**: Input → Business Logic + Side Effect → Output

```text
Test: should apply discount and log the transaction
├─ ARRANGE: mockLogger = vi.fn()
├─ ACT: applyDiscountWithLogging(order, 0.2, mockLogger)
├─ ASSERT (Return): expect(discountedTotal).toBe(80)
└─ ASSERT (Mock): expect(mockLogger).toHaveBeenCalledWith({...})
```

**Lessons**:

- Use mocks to verify side effects happened
- Mock only what is necessary (the dependency being tested)
- Always verify both return value AND side effect
- Never rely on mock assertions alone

### 3. Asynchronous Operations (Section 3)

Tests functions that return promises or use async/await.

**Pattern**: Input → Async Dependency → Business Logic → Output

```text
Test: should fetch user and apply premium discount for gold members
├─ ARRANGE: mockUserService.getUserById.mockResolvedValue({...})
├─ ACT: await fetchUserAndApplyDiscount(userId, 100, mockUserService)
└─ ASSERT: expect(result.discount).toBe(0.15)
```

**Lessons**:

- Always `await` or `return` the promise
- Mock async dependencies with `mockResolvedValue` or `mockRejectedValue`
- Test error paths (`rejects.toThrow`)
- Never forget `await`; the test will pass even if the promise rejects

### 4. Stubs for Fixed Returns (Section 4)

Tests where a dependency returns a fixed value and we don't care about verification.

**Pattern**: Input + Fixed Dependency → Logic → Output

```text
Test: should generate invoice with correct timestamp
├─ ARRANGE: stubTimeProvider.now = () => new Date('2026-05-08T10:00:00Z')
├─ ACT: invoice = generateInvoice(order, stubTimeProvider)
└─ ASSERT: expect(invoice.timestamp).toBe('2026-05-08T10:00:00Z')
```

**Lessons**:

- Stubs provide fixed return values
- Unlike mocks, stubs don't record calls
- Use stubs when you need a dependency value but not verification
- Stubs are simpler than mocks; choose the right tool

### 5. Spies for Real Behavior + Verification (Section 5)

Tests where you want the real implementation but also need to verify interactions.

**Pattern**: Input + Real Dependency + Spy Wrapper → Logic → Output

```text
Test: should call date formatter on invoice generation
├─ ARRANGE: spyFormatter = vi.spyOn(realDateProvider, 'format')
├─ ACT: invoice = generateInvoiceWithSpy(order, realDateProvider)
└─ ASSERT: expect(spyFormatter).toHaveBeenCalledTimes(1)
```

**Lessons**:

- Spies wrap real functions and record calls
- Use spies when you want real behavior + verification
- Spies are more complex; only use when necessary
- Always clean up spies with `vi.restoreAllMocks()` in afterEach

## Test Doubles: Choosing the Right Tool

| Tool     | Purpose                        | Use When                                 | Record Calls?  |
| -------- | ------------------------------ | ---------------------------------------- | -------------- |
| **Stub** | Return fixed value             | You only care about the value, not calls | No             |
| **Mock** | Verify side effects            | You need to verify function was called   | Yes            |
| **Spy**  | Wrap real + record calls       | You want real behavior + verification    | Yes            |
| **Fake** | Simplified real implementation | You need lightweight real behavior       | Yes (optional) |

**Decision Tree**:

```text
"Do I need to verify this dependency was called?"
├─ NO → Use STUB (simpler, faster)
└─ YES
    ├─ "Do I want real behavior?"
    │  ├─ NO → Use MOCK (isolated)
    │  └─ YES → Use SPY (real + verified)
    └─ (For complex real behavior → Consider FAKE)
```

## Boundary Testing

Every test suite must include boundary cases. These catch off-by-one errors and reveal assumptions.

### Categories

1. **Valid Edge Cases**: Min, max, zero, empty, null
2. **Invalid Edge Cases**: Negative, overflow, invalid types
3. **Transition Points**: Where behavior changes (e.g., discount < 0 → error)

### Example: Discount Function

```text
Valid Boundaries:
├─ Zero discount (0%) → Should return full total
├─ Full discount (100%) → Should return zero
├─ Normal discount (10-50%) → Should work

Invalid Boundaries:
├─ Negative discount (-10%) → Should throw error
├─ Over 100% (110%) → Should throw error
└─ Non-numeric → Should throw error (type guard)
```

## Common Mistakes to Avoid

❌ **Multiple Assertions for Different Behaviors**

```ts
// Bad: Two things being tested in one test
it("should validate and calculate", () => {
  expect(isValidDiscount(0.2)).toBe(true);
  expect(calculateDiscount(100, 0.2)).toBe(80);
});
```

✅ **One Assertion Per Objective**

```ts
// Good: Separate tests for separate behaviors
it("should recognize valid discount", () => {
  expect(isValidDiscount(0.2)).toBe(true);
});

it("should calculate correct discount", () => {
  expect(calculateDiscount(100, 0.2)).toBe(80);
});
```

---

❌ **Forgetting `await` on Async Tests**

```ts
// Bad: Promise rejection will be swallowed
it("should fetch user", () => {
  fetchUser(userId); // Missing await!
  expect(user).toBeDefined();
});
```

✅ **Always `await` or `return`**

```ts
// Good: Waits for promise to settle
it("should fetch user", async () => {
  const user = await fetchUser(userId);
  expect(user).toBeDefined();
});
```

---

❌ **Over-Mocking**

```ts
// Bad: Mocking too much makes test brittle
it("should calculate", () => {
  const mockMath = vi.fn(() => 90);
  expect(mockMath(100, 0.1)).toBe(90);
});
```

✅ **Mock Only External Dependencies**

```ts
// Good: Only mock what needs isolation
it("should calculate discount", () => {
  expect(calculateDiscount(100, 0.1)).toBe(90);
});
```

## Checklist: Using PerfectTest as a Reference

When writing tests in your project, verify:

- [ ] **Arrange is explicit**: Data setup is clear and isolated
- [ ] **Act is single**: One function call, one behavior tested
- [ ] **Assert is focused**: Verifies only what changed as a result
- [ ] **Boundary cases included**: Edge cases and error paths tested
- [ ] **Test doubles chosen correctly**: Stub, Mock, Spy used appropriately
- [ ] **Async is awaited**: No forgotten promises
- [ ] **One assertion per reason to fail**: Tests fails for one clear reason
- [ ] **Names are descriptive**: `should [verb] [condition]` format

## Related Standards

- [testing-excellence.md](../standards/testing-excellence.md) — TDD workflow, Red-Green-Refactor, test structure
- [code-design-logic.md](../standards/code-design-logic.md) — Immutability, guard clauses, early returns
- [documentation-adr.md](../standards/documentation-adr.md) — Decision records for testing strategy

## Using PerfectTest in Audits

### Audit Scenario: Verify code follows AAA pattern

1. **Extract** test suite from project
2. **Compare** against sections in `PerfectTest.test.ts`
3. **Verify**:
   - [ ] Arrange phase is clear
   - [ ] Act phase is isolated
   - [ ] Assert phase is focused
   - [ ] Boundary cases are tested
   - [ ] Test doubles are used correctly

### Audit Checklist

```markdown
# Test Quality Audit

## Code: src/orders/calculateDiscount.test.ts

| Criteria                | Status | Notes                                  |
| ----------------------- | ------ | -------------------------------------- |
| Uses AAA pattern        | ✅ Yes | Clear separation of arrange/act/assert |
| Tests happy path        | ✅ Yes | Valid discount percentage tested       |
| Tests boundary cases    | ❌ No  | Missing: zero discount, 100% discount  |
| Tests error cases       | ✅ Yes | Negative discount throws error         |
| Mocks only dependencies | ✅ Yes | No over-mocking of pure logic          |
| Async properly awaited  | N/A    | No async code                          |

**Findings**:

- Boundary cases missing. Add: zero (0%), full (100%), edge transitions.
- Consider: What if `orderTotal` is zero? What if `percentage` is NaN?
```

---

## Next Steps

1. Copy `PerfectTest.test.ts` structure to your test file
2. Reference the pattern that matches your code type (sync, async, mocks, etc.)
3. Add boundary cases specific to your business logic
4. Use this README as a checklist during code review
