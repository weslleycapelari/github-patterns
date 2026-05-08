/**
 * PerfectTest.test.ts - AAA Pattern Reference
 *
 * This file demonstrates the Arrange-Act-Assert (AAA) pattern as defined
 * in library/standards/testing-excellence.md
 *
 * Each test follows these principles:
 * 1. Single observable objective - one reason to fail
 * 2. Explicit AAA structure - arrange, act, assert marked clearly
 * 3. Boundary testing - valid, invalid, and edge cases
 * 4. Test doubles chosen based on technical need, not preference
 * 5. Behavior-driven assertions - external observable state, not implementation
 */

import { describe, it, expect, beforeEach, vi } from "vitest";

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 1: SYNCHRONOUS TESTS WITH AAA PATTERN
// ═══════════════════════════════════════════════════════════════════════════

/**
 * Example: Calculate discount on valid order
 *
 * This demonstrates a pure function test with clear Arrange-Act-Assert boundaries.
 */
describe("calculateOrderDiscount (Synchronous Pure Function)", () => {
  it("should return discounted total when percentage is valid", () => {
    // AI-REFERENCE: ARRANGE
    // Prepare immutable input data with no side effects.
    // Each test should be independent and not rely on shared state.
    const orderTotal = 100;
    const discountPercentage = 0.1; // 10%
    const expectedResult = 90;

    // AI-REFERENCE: ACT
    // Execute the function under test in isolation.
    // Pass only what is needed; avoid unnecessary context.
    const result = calculateOrderDiscount(orderTotal, discountPercentage);

    // AI-REFERENCE: ASSERT
    // Verify the observable behavior (return value) matches expectation.
    // Assert only what matters for the business rule, not implementation details.
    expect(result).toBe(expectedResult);
  });

  it("should return original total when discount is zero", () => {
    // AI-REFERENCE: BOUNDARY TEST
    // Test the edge case where discount has no effect.
    // Boundary tests catch off-by-one errors and default behavior assumptions.
    const orderTotal = 150;
    const discountPercentage = 0;

    const result = calculateOrderDiscount(orderTotal, discountPercentage);

    expect(result).toBe(orderTotal);
  });

  it("should throw error when discount percentage is negative", () => {
    // AI-REFERENCE: ERROR PATH
    // Verify the function fails fast with clear intent for invalid input.
    // Guard clauses in production code should prevent invalid state from progressing.
    const orderTotal = 100;
    const invalidDiscount = -0.1;

    expect(() => {
      calculateOrderDiscount(orderTotal, invalidDiscount);
    }).toThrow("Discount percentage must be between 0 and 1");
  });

  it("should throw error when discount percentage exceeds 100%", () => {
    // AI-REFERENCE: BOUNDARY + ERROR PATH
    // Combine boundary analysis with error handling.
    const orderTotal = 100;
    const invalidDiscount = 1.5;

    expect(() => {
      calculateOrderDiscount(orderTotal, invalidDiscount);
    }).toThrow("Discount percentage must be between 0 and 1");
  });
});

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 2: TESTS WITH MOCKS (BEHAVIOR VERIFICATION)
// ═══════════════════════════════════════════════════════════════════════════

/**
 * Example: Apply discount and log the transaction
 *
 * When a function has side effects (e.g., logging, API calls), use mocks
 * to verify the side effect occurred without executing the real dependency.
 */

describe("applyDiscountWithLogging (Mocking Side Effects)", () => {
  let mockLogger: any;

  beforeEach(() => {
    // AI-REFERENCE: MOCK SETUP
    // Create a test double that records calls without side effects.
    // Mocks verify that code interacted with a dependency in expected ways.
    mockLogger = {
      logDiscount: vi.fn(),
    };
  });

  it("should apply discount and log the transaction", () => {
    // AI-REFERENCE: ARRANGE WITH MOCK
    // Set up the mock logger and expected data together.
    const order = { id: "ORD-001", total: 100 };
    const discountPercentage = 0.2;
    const expectedDiscountAmount = 20;

    // AI-REFERENCE: ACT
    // Call the function that will trigger the logging side effect.
    const discountedTotal = applyDiscountWithLogging(
      order,
      discountPercentage,
      mockLogger,
    );

    // AI-REFERENCE: ASSERT - BEHAVIOR
    // Verify the mock was called with expected arguments.
    // This proves the side effect happened as designed.
    expect(mockLogger.logDiscount).toHaveBeenCalledWith({
      orderId: order.id,
      originalTotal: order.total,
      discountAmount: expectedDiscountAmount,
      finalTotal: 80,
    });

    // AI-REFERENCE: ASSERT - RETURN VALUE
    // Also verify the main observable behavior (return value).
    // Never rely only on mock assertions; verify business logic too.
    expect(discountedTotal).toBe(80);
  });

  it("should not log if discount is zero", () => {
    // AI-REFERENCE: GUARD CLAUSE TEST
    // Test that logging is skipped when conditions don't warrant it.
    const order = { id: "ORD-002", total: 100 };
    const discountPercentage = 0;

    applyDiscountWithLogging(order, discountPercentage, mockLogger);

    // AI-REFERENCE: ASSERT MOCK NOT CALLED
    // Verify the side effect was avoided for an edge case.
    expect(mockLogger.logDiscount).not.toHaveBeenCalled();
  });
});

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 3: ASYNCHRONOUS TESTS
// ═══════════════════════════════════════════════════════════════════════════

/**
 * Example: Fetch user from API and apply membership discount
 *
 * Async tests require careful handling of promises.
 * Use await or return to ensure the test waits for completion.
 */

describe("fetchUserAndApplyDiscount (Async/Await)", () => {
  let mockUserService: any;

  beforeEach(() => {
    // AI-REFERENCE: MOCK ASYNC DEPENDENCY
    // Create a mock that returns a resolved promise.
    // This avoids real network calls during testing.
    mockUserService = {
      getUserById: vi.fn().mockResolvedValue({
        id: "USER-123",
        name: "Alice",
        membershipTier: "gold",
      }),
    };
  });

  it("should fetch user and apply premium discount for gold members", async () => {
    // AI-REFERENCE: ARRANGE ASYNC
    // Set up async dependencies before the act phase.
    const userId = "USER-123";
    const orderTotal = 100;

    // AI-REFERENCE: ACT - ASYNC
    // Use await to wait for the promise to resolve.
    // Never forget await; the test will pass even if the promise rejects.
    const result = await fetchUserAndApplyDiscount(
      userId,
      orderTotal,
      mockUserService,
    );

    // AI-REFERENCE: ASSERT ASYNC RESULT
    // Verify the business logic applied the correct discount based on membership.
    expect(result.discount).toBe(0.15); // Gold tier = 15% discount
    expect(result.finalTotal).toBe(85);
    expect(result.membershipTier).toBe("gold");
  });

  it("should apply standard discount for regular members", async () => {
    // AI-REFERENCE: MOCK OVERRIDE FOR DIFFERENT SCENARIO
    // Override the default mock for a different membership tier.
    mockUserService.getUserById.mockResolvedValueOnce({
      id: "USER-456",
      name: "Bob",
      membershipTier: "standard",
    });

    const userId = "USER-456";
    const orderTotal = 100;

    const result = await fetchUserAndApplyDiscount(
      userId,
      orderTotal,
      mockUserService,
    );

    expect(result.discount).toBe(0.05); // Standard tier = 5% discount
    expect(result.finalTotal).toBe(95);
  });

  it("should throw error if user is not found", async () => {
    // AI-REFERENCE: ASYNC ERROR HANDLING
    // Mock a rejected promise to simulate API failure.
    mockUserService.getUserById.mockRejectedValueOnce(
      new Error("User not found"),
    );

    const userId = "USER-INVALID";
    const orderTotal = 100;

    // AI-REFERENCE: ASSERT ASYNC REJECTION
    // Use rejects matcher to verify promise rejection.
    await expect(
      fetchUserAndApplyDiscount(userId, orderTotal, mockUserService),
    ).rejects.toThrow("User not found");
  });
});

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 4: STUB (FIXED RETURN VALUE WITHOUT BEHAVIOR VERIFICATION)
// ═══════════════════════════════════════════════════════════════════════════

/**
 * Example: Generate invoice with fixed timestamp
 *
 * Stubs provide fixed return values but don't verify calls.
 * Use stubs when you need a dependency value but don't care if it was called.
 */

describe("generateInvoice (Stub for Fixed Dependencies)", () => {
  let stubTimeProvider: any;

  beforeEach(() => {
    // AI-REFERENCE: STUB SETUP
    // A stub returns a fixed value. It does not record calls.
    // Use stubs when the return value matters, not the interaction.
    stubTimeProvider = {
      now: () => new Date("2026-05-08T10:00:00Z"),
    };
  });

  it("should generate invoice with correct timestamp", () => {
    // AI-REFERENCE: ARRANGE WITH STUB
    const order = { id: "ORD-001", items: ["Item1", "Item2"], total: 100 };
    const expectedTimestamp = "2026-05-08T10:00:00Z";

    // AI-REFERENCE: ACT
    const invoice = generateInvoice(order, stubTimeProvider);

    // AI-REFERENCE: ASSERT WITH STUB
    // Verify the return value uses the stub's provided data.
    // We don't care if generateInvoice called now(); we only care it worked.
    expect(invoice.timestamp).toBe(expectedTimestamp);
    expect(invoice.orderId).toBe(order.id);
  });
});

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 5: SPY (VERIFY REAL BEHAVIOR + SIDE EFFECTS)
// ═══════════════════════════════════════════════════════════════════════════

/**
 * Example: SPY on existing implementation
 *
 * Spies wrap real functions and record calls.
 * Use spies when you want the real behavior but also need to verify interactions.
 */

const realDateProvider = {
  now: () => new Date(),
  format: (date: Date) => date.toISOString(),
};

describe("Invoice with Spy (Verify Real + Record Calls)", () => {
  it("should call date formatter on invoice generation", () => {
    // AI-REFERENCE: SPY SETUP
    // Wrap the real function to record calls without changing behavior.
    const spyFormatter = vi.spyOn(realDateProvider, "format");

    const order = { id: "ORD-001", total: 50 };

    // AI-REFERENCE: ACT WITH SPY
    const invoice = generateInvoiceWithSpy(order, realDateProvider);

    // AI-REFERENCE: ASSERT SPY
    // Verify the real method was called and the return value is correct.
    expect(spyFormatter).toHaveBeenCalledTimes(1);
    expect(invoice.timestamp).toBeDefined();
  });
});

// ═══════════════════════════════════════════════════════════════════════════
// IMPLEMENTATION FUNCTIONS (for reference only)
// These would be in production code, not in test files.
// ═══════════════════════════════════════════════════════════════════════════

function calculateOrderDiscount(
  total: number,
  discountPercentage: number,
): number {
  // AI-REFERENCE: GUARD CLAUSE
  // Validate preconditions at the top to fail fast.
  if (discountPercentage < 0 || discountPercentage > 1) {
    throw new Error("Discount percentage must be between 0 and 1");
  }

  // AI-REFERENCE: IMMUTABILITY
  // Return a new value; never mutate input.
  const discountAmount = total * discountPercentage;
  return total - discountAmount;
}

function applyDiscountWithLogging(
  order: { id: string; total: number },
  discountPercentage: number,
  logger: any,
): number {
  // AI-REFERENCE: GUARD CLAUSE
  // Early return for zero discount avoids unnecessary side effects.
  if (discountPercentage === 0) {
    return order.total;
  }

  const discountAmount = order.total * discountPercentage;
  const finalTotal = order.total - discountAmount;

  // AI-REFERENCE: SIDE EFFECT
  // Log the transaction for audit purposes.
  logger.logDiscount({
    orderId: order.id,
    originalTotal: order.total,
    discountAmount,
    finalTotal,
  });

  return finalTotal;
}

async function fetchUserAndApplyDiscount(
  userId: string,
  orderTotal: number,
  userService: any,
): Promise<{ discount: number; finalTotal: number; membershipTier: string }> {
  // AI-REFERENCE: ASYNC OPERATION
  // Await external dependency before proceeding.
  const user = await userService.getUserById(userId);

  // AI-REFERENCE: MAPPING LOGIC
  // Convert membership tier to discount percentage.
  const discountMap: { [key: string]: number } = {
    gold: 0.15,
    silver: 0.1,
    standard: 0.05,
  };

  const discount = discountMap[user.membershipTier] || 0;
  const finalTotal = orderTotal - orderTotal * discount;

  return {
    discount,
    finalTotal,
    membershipTier: user.membershipTier,
  };
}

function generateInvoice(
  order: any,
  timeProvider: any,
): { timestamp: string; orderId: string } {
  return {
    orderId: order.id,
    timestamp: timeProvider.now().toISOString(),
  };
}

function generateInvoiceWithSpy(
  order: any,
  timeProvider: any,
): { timestamp: string; orderId: string } {
  const now = timeProvider.now();
  const formattedTime = timeProvider.format(now);

  return {
    orderId: order.id,
    timestamp: formattedTime,
  };
}
