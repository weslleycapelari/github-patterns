# Code Design Logic

## Objective

Define implacable rules for writing business logic with low accidental complexity, high predictability, and immediate readability.

This standard adopts as its operational foundation:

- simplicity and readability over cleverness;
- systematic reduction of mutation, nesting, and ambiguity;
- naming that makes intention, state, and business rules explicit;
- alignment with the ECC immutability baseline and structural discipline.

## Non-Negotiable Principles

1. Every function must be straightforward to read in linear flow.
2. Every mutation must be treated as an exception, never as a default.
3. Every invalid condition must fail fast.
4. Every name must explain the role of the information without relying on a comment.
5. Every abstraction must reduce real complexity; if it only moves complexity around, it must be removed.

## Immutability

Immutability is the default. Input data must be treated as read-only. Code must produce new values instead of modifying existing ones.

### Always: Immutability

- Always declare references with `const` when there is no real need for reassignment.
- Always return new objects and arrays when applying transformations.
- Always prefer map, filter, reduce, spread, and destructuring over mutable operations.
- Always treat function parameters as immutable.
- Always isolate unavoidable mutation in explicit, small, and documented boundaries.

### Never: Immutability

- Never mutate arguments received by a function.
- Never use push, pop, shift, unshift, splice, sort, or reverse on shared collections without a defensive copy.
- Never reassign variables to represent multiple conceptual states in the same function.
- Never update objects in an implicit chain when returning a new structure is possible.

### Bad vs Good: Immutability

```ts
// Bad
function addRole(user: User, role: string): User {
  user.roles.push(role);
  user.updatedAt = new Date().toISOString();
  return user;
}

// Good
function addRole(user: User, role: string): User {
  return {
    ...user,
    roles: [...user.roles, role],
    updatedAt: new Date().toISOString(),
  };
}
```

```ts
// Bad
function sortTicketsByPriority(tickets: Ticket[]): Ticket[] {
  return tickets.sort((left, right) => right.priority - left.priority);
}

// Good
function sortTicketsByPriority(tickets: Ticket[]): Ticket[] {
  return [...tickets].sort((left, right) => right.priority - left.priority);
}
```

## Early Returns And Guard Clauses

Guard clauses exist to remove unnecessary nesting, shorten the cognitive path, and keep the main flow visible.

### Always: Early Returns

- Always validate preconditions at the top of the function.
- Always return early for invalid, empty, null, or unauthorized cases.
- Always keep the happy path as the shortest and most visible main flow.
- Always use if with an immediate return instead of wrapping the entire function in conditional blocks.

### Never: Early Returns

- Never wrap the main logic in successive ifs when guard clauses resolve the flow.
- Never use else after a return, throw, continue, or break.
- Never deepen nesting to handle exceptional cases.
- Never mix input validation with the main transformation in the same conditional block.

### Bad vs Good: Early Returns

```ts
// Bad
function calculateRefund(order?: Order): number {
  if (order) {
    if (order.isPaid) {
      if (!order.isExpired) {
        return order.totalAmount;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  } else {
    return 0;
  }
}

// Good
function calculateRefund(order?: Order): number {
  if (!order) return 0;
  if (!order.isPaid) return 0;
  if (order.isExpired) return 0;

  return order.totalAmount;
}
```

```ts
// Bad
function createSession(user: User | null): Session {
  if (!user) {
    throw new Error('User is required');
  } else {
    return sessionFactory.create(user.id);
  }
}

// Good
function createSession(user: User | null): Session {

  if (!user) {
    throw new Error('User is required');
  }

  return sessionFactory.create(user.id);
}
```

## KISS

KISS means choosing the smallest correct, comprehensible, and sustainable solution. Simple code is not short code; it is code with low surprise.

### Always: KISS

- Always prefer a function with a single clear responsibility.
- Always decompose complex logic into small steps with explicit names.
- Always choose familiar control structures before sophisticated abstractions.
- Always favor pure functions when business rules allow.
- Always remove branches, parameters, and abstraction layers that add no real behavior.

### Never: KISS

- Never generalize early for scenarios that do not yet exist.
- Never introduce patterns, helpers, or layers just to appear more architected.
- Never compress multiple business decisions into an opaque expression.
- Never hide important rules behind generic names like handle, process, execute, or data.

### Bad vs Good: KISS

```ts
// Bad
function resolvePrice(input: CheckoutInput): number {
  return input.items
    .map((item) => item.price * item.quantity)
    .reduce((total, value) => total + value, 0) * (input.coupon?.discount ?? 1)
    + (input.isPriority ? 40 : 0)
    - (input.customer?.isVip ? 15 : 0);
}

// Good
function resolvePrice(input: CheckoutInput): number {
  const subtotal = calculateSubtotal(input.items);
  const discountedSubtotal = applyCouponDiscount(subtotal, input.coupon);
  const priorityFee = getPriorityFee(input.isPriority);
  const vipDiscount = getVipDiscount(input.customer);

  return discountedSubtotal + priorityFee - vipDiscount;
}
```

```ts
// Bad
function processReport(report: Report): Result {
  const normalizedReport = normalizeReport(validateReport(enrichReport(report)));
  return saveReport(normalizedReport);
}

// Good
function processReport(report: Report): Result {
  const enrichedReport = enrichReport(report);
  const validatedReport = validateReport(enrichedReport);
  const normalizedReport = normalizeReport(validatedReport);

  return saveReport(normalizedReport);
}
```

## Semantic Naming

Semantic naming is a design requirement, not aesthetic finishing. A bad name transfers cognitive cost to every future read.

### Always: Semantic Naming

- Always use names that reveal intention, context, and decision unit.
- Always name booleans as questions or verifiable states: is, has, can, should.
- Always name collections in the plural and single values in the singular.
- Always name functions with a verb plus the expected result.
- Always make the business domain explicit instead of using generic names.

### Never: Semantic Naming

- Never use empty names like value, item, thing, handler, helper, manager, or data without additional context.
- Never use obscure abbreviations unless they are an unambiguous domain standard.
- Never use the same name for different concepts in the same module.
- Never rely on a comment to explain what a variable actually represents.

### Bad vs Good: Semantic Naming

```ts
// Bad
const value = orders.filter((item) => item.ok);
const flag = value.length > 0;

// Good
const paidOrders = orders.filter((order) => order.isPaid);
const hasPaidOrders = paidOrders.length > 0;
```

```ts
// Bad
function handle(data: UserInput): UserProfile {
  return mapper(data);
}

// Good
function mapUserInputToProfile(userInput: UserInput): UserProfile {
  return mapper(userInput);
}
```

## Decision Rules: Always vs Never

### Always: Global Rules

- Always write code that makes the happy path visually dominant.
- Always transform data without mutating the source.
- Always reduce nesting before adding explanatory comments.
- Always extract functions when it makes the business rule more explicit.
- Always choose names that eliminate the need for mental translation.

### Never: Global Rules

- Never keep else after an explicit return.
- Never mutate inputs to save a trivial allocation.
- Never hide complexity in compact, hard-to-debug chains.
- Never introduce generic abstractions without real pressure from repetition or variation.
- Never accept names that require a comment to make sense.

## Review Checklist

Before approving any logic, validate:

1. Is there avoidable mutation of an object, array, or argument?
2. Is there an unnecessary else after return, throw, continue, or break?
3. Can the main flow become more linear with guard clauses?
4. Is the solution the simplest one that solves the current problem?
5. Do variables, functions, and booleans reveal intention without an auxiliary comment?
6. Is there too much abstraction for a small problem?
7. Is there too much transformation compressed into a single expression?

## Enforcement

If there is a conflict between conciseness and clarity, clarity wins.

If there is a conflict between marginal performance and predictability, predictability wins, unless profiling demonstrates a real bottleneck.

If there is a conflict between convenient mutation and flow integrity, flow integrity wins.
