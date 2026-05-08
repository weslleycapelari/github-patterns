# Testing Excellence

## Objective

Equip the @tdd-enforcer agent and developers with a disciplined, verifiable test standard oriented toward real regression protection.

This standard defines:

- how to execute TDD without shortcuts;
- how to structure tests with AAA in a readable way;
- how to correctly choose between fake, stub, spy, and mock;
- how to enforce Boundary Testing as the minimum quality requirement.

## Non-Negotiable Principles

1. No new implementation may be born without a failing test first.
2. Every test must have a single observable objective.
3. Every test must make Arrange, Act, and Assert explicit.
4. Every quality test must include boundary analysis and error paths.
5. Every test double must be chosen based on technical need, not aesthetic preference.
6. Tests must protect external behavior, not freeze incidental implementation details.

## TDD Workflow

TDD is a feedback-driven design cycle. The goal is not only to validate code; it is to force contract clarity, reduce over-design, and produce safe refactoring.

### Red

In the Red stage, the developer defines a desired behavior and writes the smallest possible test that fails for the correct reason.

### Green

In the Green stage, the developer implements the smallest possible code to make the test pass, without anticipating scenarios not yet required.

### Refactor

In the Refactor stage, the developer improves names, duplications, structure, and internal design under the safety of the green suite.

### Always: TDD

- Always start with the business rule, behavior, or bug reproduced in a test.
- Always verify that the test fails for the expected reason before implementing.
- Always write the smallest correct implementation to get out of Red.
- Always refactor with the green suite immediately after Green.
- Always repeat the cycle in small increments.

### Never: TDD

- Never write production code before the first test fails.
- Never write several red tests and implement everything in batch.
- Never use the Green stage to add features not covered by the current test.
- Never skip the Refactor when there is duplication, noise, or degraded design.
- Never accept a green test that previously failed for the wrong reason.

### Bad vs Good: TDD

```ts
// Bad
function applyDiscount(total: number, percentage: number): number {
  if (percentage < 0) {
    throw new Error('Invalid percentage');
  }

  return total - total * percentage;
}

test('should apply discount', () => {
  expect(applyDiscount(100, 0.1)).toBe(90);
});
```

```ts
// Good
test('should return the discounted total when percentage is valid', () => {
  expect(applyDiscount(100, 0.1)).toBe(90);
});

function applyDiscount(total: number, percentage: number): number {
  return total - total * percentage;
}
```

```ts
// Refactor after Green
function applyDiscount(total: number, percentage: number): number {
  const discountAmount = total * percentage;
  return total - discountAmount;
}
```

## AAA Pattern

AAA is the minimum readability structure for tests. Without it, a test degrades into a confusing script.

### Arrange

Arrange prepares data, doubles, and initial state. It does not execute the rule under test.

### Act

Act triggers exactly the operation under test. In well-designed tests, there is one dominant Act.

### Assert

Assert validates the observable behavior: state, return value, error, or relevant interaction.

### Always: AAA

- Always separate Arrange, Act, and Assert visually.
- Always keep only one main Act per test.
- Always name setup data with clear intention.
- Always make assertions specific, observable, and aligned with the behavior described in the test name.

### Never: AAA

- Never mix setup with assertion.
- Never execute multiple independent acts in the same test.
- Never hide assertions inside complex loops, callbacks, or opaque helpers.
- Never use vague assertions like truthy, falsy, or not null when the expected value can be expressed directly.

### Bad vs Good: AAA

```ts
// Bad
test('should create user', async () => {
  const repository = new InMemoryUserRepository();
  const service = new CreateUserService(repository);

  await service.execute({ email: 'ana@example.com', displayName: 'Ana' });
  await service.execute({ email: 'bia@example.com', displayName: 'Bia' });

  const users = repository.list();
  expect(users.length).toBeTruthy();
});
```

```ts
// Good
test('should persist a new user when email is unique', async () => {
  // Arrange
  const repository = new InMemoryUserRepository();
  const service = new CreateUserService(repository);
  const input = { email: 'ana@example.com', displayName: 'Ana' };

  // Act
  await service.execute(input);

  // Assert
  expect(repository.list()).toEqual([
    { id: 'user-1', email: 'ana@example.com', displayName: 'Ana' },
  ]);
});
```

## Test Doubles

Every double is a test substitute. They are not synonyms.

### Definitions

- Dummy: object passed only to fill a signature, with no real participation in the test.
- Fake: simplified functional implementation, suitable for tests but not for production.
- Stub: object that returns pre-programmed responses to enable the flow.
- Spy: stub that also records calls for later inspection.
- Mock: object with explicit interaction expectations, used for behavior verification.

### State Verification Vs Behavior Verification

State verification validates the observable result in state or return value.

Behavior verification validates that the SUT interacted with a collaborator in the expected way.

Operational rule:

- prefer state verification when the behavior can be proven by the final result;
- use behavior verification when the interaction with the collaborator is itself the important rule to prove.

### Mocks Vs Fakes

Based on Martin Fowler:

- fake is a lightweight, functional implementation and generally more stable for state-oriented tests;
- mock is a specification of expected calls and tends to couple the test more tightly to the implementation;
- stub provides ready-made responses but must not become the primary mechanism for behavioral verification;
- spy is useful when calls need to be inspected without imposing a rigid upfront expectation.

### Always: Test Doubles

- Always use fake when a simple, functional implementation makes the test more readable.
- Always use stub when the test only needs a controlled response to advance the flow.
- Always use mock only when the interaction is an essential part of the behavior to prove.
- Always prefer small, specific doubles that adhere to the dependency contract.

### Never: Test Doubles

- Never mock everything by default.
- Never use mock to test a return value that could be validated by state.
- Never create doubles that are too generic and hide the test domain.
- Never couple the test to irrelevant details of call order or count when that is not part of the requirement.

### Bad vs Good: Doubles

```ts
// Bad
test('should send welcome email', async () => {
  const repository = mock<UserRepository>();
  const mailer = mock<MailerGateway>();

  repository.expects('create').once().with({ email: 'ana@example.com' });
  mailer.expects('sendWelcomeEmail').once().with('ana@example.com');

  const service = new RegisterUserService(repository, mailer);
  await service.execute({ email: 'ana@example.com' });
});
```

```ts
// Good
test('should send welcome email after user registration', async () => {
  const repository = new InMemoryUserRepository();
  const mailerSpy = new MailerSpy();
  const service = new RegisterUserService(repository, mailerSpy);

  await service.execute({ email: 'ana@example.com' });

  expect(repository.list()).toHaveLength(1);
  expect(mailerSpy.sentEmails).toEqual(['ana@example.com']);
});
```

## Boundary Testing

Boundary Testing is mandatory because most critical defects live at the edges, not on the happy path.

### Mandatory Boundaries

- null and undefined;
- empty string, whitespace only, and empty collections;
- lower and upper bounds;
- zero, negative, maximum, and minimum supported values;
- duplicates, missing data, and unexpected cardinality;
- dependency errors, timeouts, conflicts, and exceptions.

### Always: Boundary Testing

- Always test the smallest valid value.
- Always test the first invalid value below the boundary.
- Always test the largest valid value.
- Always test the first invalid value above the boundary.
- Always test empty collections and missing data when the contract accepts optional input.
- Always test error paths and relevant dependency failures.

### Never: Boundary Testing

- Never assume the happy path covers the boundaries.
- Never test only average values and call that sufficient coverage.
- Never ignore empty, null, or duplicate cases because they seem obvious.
- Never treat exceptions as a secondary detail when they are part of the contract.

### Bad vs Good: Boundary Testing

```ts
// Bad
test('should create coupon', () => {
  const coupon = createCoupon({ code: 'SAVE10', percentage: 10 });
  expect(coupon.percentage).toBe(10);
});
```

```ts
// Good
test('should reject coupon when percentage is below the minimum allowed', () => {
  expect(() => createCoupon({ code: 'SAVE10', percentage: -1 })).toThrow(
    'Invalid percentage',
  );
});

test('should accept coupon when percentage is at the minimum allowed', () => {
  expect(createCoupon({ code: 'SAVE10', percentage: 0 }).percentage).toBe(0);
});

test('should accept coupon when percentage is at the maximum allowed', () => {
  expect(createCoupon({ code: 'SAVE10', percentage: 100 }).percentage).toBe(100);
});

test('should reject coupon when percentage is above the maximum allowed', () => {
  expect(() => createCoupon({ code: 'SAVE10', percentage: 101 })).toThrow(
    'Invalid percentage',
  );
});
```

## High Quality Test Checklist

Before approving any test, validate:

1. Was the test written before the implementation or behavior adjustment?
2. Did the test initially fail for the correct reason?
3. Does the test name describe behavior and condition precisely?
4. Is there a single observable objective in the test?
5. Are Arrange, Act, and Assert visually clear?
6. Does the test use the smallest necessary double: fake, stub, spy, or mock?
7. Does the test verify external behavior rather than incidental implementation details?
8. Is there explicit coverage of the lower boundary, upper boundary, and invalid path?
9. Were null, empty, duplicate, and error path cases considered?
10. Are the assertions specific enough to explain the failure without extra investigation?
11. Would the test remain valid after an internal refactoring without a behavior change?
12. Does the test fail deterministically and without depending on time, network, or a real database?

## Enforcement

A test that only covers the happy path is insufficient.

A test that depends on excessive mocking is fragile until proven otherwise.

A test that does not reveal the validated boundary is poor documentation and weak protection.

If the developer cannot explain why they chose mock over fake, the double is probably wrong.
