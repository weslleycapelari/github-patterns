/**
 * PerfectComponent.test.ts - Vue Component AAA Pattern Tests
 *
 * This file demonstrates how to test Vue components using the AAA pattern.
 * See library/examples/common/README.md for full AAA explanation.
 */

import { describe, it, expect, beforeEach, vi } from "vitest";
import { mount, flushPromises } from "@vue/test-utils";
import PerfectComponent from "./PerfectComponent.vue";

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 1: SYNCHRONOUS COMPONENT TESTS
// ═══════════════════════════════════════════════════════════════════════════

describe("PerfectComponent (Synchronous)", () => {
  it("should render product name with correct accessibility attributes", () => {
    // === ARRANGE ===
    // AI-REFERENCE: Mount component with props
    const product = {
      id: 1,
      name: "Red T-Shirt",
      price: 2999, // $29.99 in cents
      discount: 10,
    };

    const wrapper = mount(PerfectComponent, {
      props: {
        product,
        itemId: "item-1",
        minQuantity: 1,
        maxQuantity: 5,
      },
    });

    // === ACT ===
    // Component is mounted; Vue has rendered template

    // === ASSERT ===
    // AI-REFERENCE: Verify rendered content
    expect(wrapper.find("h3").text()).toBe("Red T-Shirt");

    // AI-REFERENCE: Verify accessibility attributes
    expect(wrapper.find("h3").attributes("id")).toBe("item-1");
    expect(wrapper.find('[role="group"]').attributes("aria-labelledby")).toBe(
      "item-1",
    );
  });

  it("should display price formatted as currency", () => {
    // === ARRANGE ===
    const product = {
      id: 1,
      name: "Test Product",
      price: 2999, // $29.99
    };

    const wrapper = mount(PerfectComponent, {
      props: {
        product,
        itemId: "item-1",
      },
    });

    // === ACT ===
    const priceText = wrapper.find(".shopping-cart-item__price").text();

    // === ASSERT ===
    // AI-REFERENCE: Verify business logic (price formatting)
    expect(priceText).toContain("$29.99");
  });

  it("should display discount badge when discount is present", () => {
    // === ARRANGE ===
    const product = {
      id: 1,
      name: "Discounted Item",
      price: 2999,
      discount: 20, // 20% off
    };

    const wrapper = mount(PerfectComponent, {
      props: {
        product,
        itemId: "item-1",
      },
    });

    // === ACT ===
    const discountBadge = wrapper.find(".shopping-cart-item__discount");

    // === ASSERT ===
    expect(discountBadge.exists()).toBe(true);
    expect(discountBadge.text()).toBe("-20%");
  });

  it("should not display discount badge when discount is zero", () => {
    // === ARRANGE ===
    const product = {
      id: 1,
      name: "Full Price Item",
      price: 5000,
      discount: 0,
    };

    const wrapper = mount(PerfectComponent, {
      props: {
        product,
        itemId: "item-1",
      },
    });

    // === ACT ===
    const discountBadge = wrapper.find(".shopping-cart-item__discount");

    // === ASSERT ===
    expect(discountBadge.exists()).toBe(false);
  });

  it("should increment quantity when + button is clicked", async () => {
    // === ARRANGE ===
    const product = { id: 1, name: "Test", price: 1000 };
    const wrapper = mount(PerfectComponent, {
      props: {
        product,
        itemId: "item-1",
        minQuantity: 1,
        maxQuantity: 99,
      },
    });

    // === ACT ===
    await wrapper.find('[aria-label*="Increase"]').trigger("click");
    await wrapper.vm.$nextTick();

    // === ASSERT ===
    // AI-REFERENCE: Verify component state changed
    expect(wrapper.find(".shopping-cart-item__qty-input").element.value).toBe(
      "2",
    );

    // AI-REFERENCE: Verify event was emitted
    expect(wrapper.emitted("quantityChanged")).toHaveLength(1);
    expect(wrapper.emitted("quantityChanged")[0]).toEqual([2]);
  });

  it("should decrement quantity when − button is clicked", async () => {
    // === ARRANGE ===
    const product = { id: 1, name: "Test", price: 1000 };
    const wrapper = mount(PerfectComponent, {
      props: {
        product,
        itemId: "item-1",
        minQuantity: 1,
        maxQuantity: 99,
      },
    });

    // First increment to have something to decrement
    await wrapper.find('[aria-label*="Increase"]').trigger("click");
    await wrapper.vm.$nextTick();

    // === ACT ===
    await wrapper.find('[aria-label*="Decrease"]').trigger("click");
    await wrapper.vm.$nextTick();

    // === ASSERT ===
    expect(wrapper.find(".shopping-cart-item__qty-input").element.value).toBe(
      "1",
    );
  });

  it("should calculate subtotal with discount applied", async () => {
    // === ARRANGE ===
    const product = {
      id: 1,
      name: "Item with discount",
      price: 10000, // $100.00
      discount: 20, // 20% off = $80.00
    };

    const wrapper = mount(PerfectComponent, {
      props: {
        product,
        itemId: "item-1",
      },
    });

    // === ACT ===
    await wrapper.find('[aria-label*="Increase"]').trigger("click");
    await wrapper.vm.$nextTick();

    // === ASSERT ===
    // AI-REFERENCE: Verify computed property calculation
    // Base: 100 * 2 = 200, discount: 200 * 0.2 = 40, result: 200 - 40 = 160 ($160.00)
    const subtotalText = wrapper.find(".shopping-cart-item__total").text();
    expect(subtotalText).toContain("$160.00");
  });
});

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 2: BOUNDARY TESTING
// ═══════════════════════════════════════════════════════════════════════════

describe("PerfectComponent (Boundary Cases)", () => {
  it("should disable decrement button at minimum quantity", async () => {
    // === ARRANGE ===
    const product = { id: 1, name: "Test", price: 1000 };
    const wrapper = mount(PerfectComponent, {
      props: {
        product,
        itemId: "item-1",
        minQuantity: 1,
        maxQuantity: 99,
      },
    });

    // === ACT ===
    const decrementBtn = wrapper.find('[aria-label*="Decrease"]');

    // === ASSERT ===
    // AI-REFERENCE: Verify boundary constraint
    expect(decrementBtn.attributes("disabled")).toBeDefined();
  });

  it("should disable increment button at maximum quantity", async () => {
    // === ARRANGE ===
    const product = { id: 1, name: "Test", price: 1000 };
    const wrapper = mount(PerfectComponent, {
      props: {
        product,
        itemId: "item-1",
        minQuantity: 1,
        maxQuantity: 5,
      },
    });

    // === ACT ===
    // Click increment 4 times to reach max (1 + 4 = 5)
    const incrementBtn = wrapper.find('[aria-label*="Increase"]');
    for (let i = 0; i < 4; i++) {
      await incrementBtn.trigger("click");
      await wrapper.vm.$nextTick();
    }

    // === ASSERT ===
    expect(incrementBtn.attributes("disabled")).toBeDefined();
  });

  it("should show error message when trying to exceed maximum quantity", async () => {
    // === ARRANGE ===
    const product = { id: 1, name: "Test", price: 1000 };
    const wrapper = mount(PerfectComponent, {
      props: {
        product,
        itemId: "item-1",
        minQuantity: 1,
        maxQuantity: 3,
      },
    });

    // === ACT ===
    // Try to increment beyond max
    const incrementBtn = wrapper.find('[aria-label*="Increase"]');
    for (let i = 0; i < 5; i++) {
      await incrementBtn.trigger("click");
      await wrapper.vm.$nextTick();
    }

    // === ASSERT ===
    const errorDiv = wrapper.find(".shopping-cart-item__error");
    expect(errorDiv.exists()).toBe(true);
    expect(errorDiv.text()).toContain("Cannot exceed 3 items");
  });

  it("should show error message when trying to go below minimum quantity", async () => {
    // === ARRANGE ===
    const product = { id: 1, name: "Test", price: 1000 };
    const wrapper = mount(PerfectComponent, {
      props: {
        product,
        itemId: "item-1",
        minQuantity: 2,
        maxQuantity: 99,
      },
    });

    // === ACT ===
    // Try to decrement below min
    const decrementBtn = wrapper.find('[aria-label*="Decrease"]');
    await decrementBtn.trigger("click");
    await wrapper.vm.$nextTick();

    // === ASSERT ===
    const errorDiv = wrapper.find(".shopping-cart-item__error");
    expect(errorDiv.exists()).toBe(true);
    expect(errorDiv.text()).toContain("Cannot go below 2 item(s)");
  });
});

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 3: EVENT HANDLING & EMISSION
// ═══════════════════════════════════════════════════════════════════════════

describe("PerfectComponent (Events)", () => {
  it("should emit quantityChanged event with new value", async () => {
    // === ARRANGE ===
    const product = { id: 1, name: "Test", price: 1000 };
    const wrapper = mount(PerfectComponent, {
      props: {
        product,
        itemId: "item-1",
      },
    });

    // === ACT ===
    await wrapper.find('[aria-label*="Increase"]').trigger("click");
    await wrapper.vm.$nextTick();

    // === ASSERT ===
    // AI-REFERENCE: Verify custom event emission
    const emitted = wrapper.emitted("quantityChanged") as Array<[number]>;
    expect(emitted).toHaveLength(1);
    expect(emitted[0][0]).toBe(2);
  });

  it("should emit removed event when remove button is clicked", async () => {
    // === ARRANGE ===
    const product = { id: 1, name: "Test", price: 1000 };
    const wrapper = mount(PerfectComponent, {
      props: {
        product,
        itemId: "item-1",
      },
    });

    // === ACT ===
    await wrapper.find(".shopping-cart-item__remove").trigger("click");
    await wrapper.vm.$nextTick();

    // === ASSERT ===
    const emitted = wrapper.emitted("removed");
    expect(emitted).toHaveLength(1);
  });

  it("should not emit quantityChanged if increment is blocked at max", async () => {
    // === ARRANGE ===
    const product = { id: 1, name: "Test", price: 1000 };
    const wrapper = mount(PerfectComponent, {
      props: {
        product,
        itemId: "item-1",
        maxQuantity: 1,
      },
    });

    // === ACT ===
    await wrapper.find('[aria-label*="Increase"]').trigger("click");
    await wrapper.vm.$nextTick();

    // === ASSERT ===
    // AI-REFERENCE: Verify guard clause prevented emission
    const emitted = wrapper.emitted("quantityChanged");
    expect(emitted || []).toHaveLength(0);
  });
});

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 4: INPUT VALIDATION
// ═══════════════════════════════════════════════════════════════════════════

describe("PerfectComponent (Input Validation)", () => {
  it("should validate direct input and reject non-numeric values", async () => {
    // === ARRANGE ===
    const product = { id: 1, name: "Test", price: 1000 };
    const wrapper = mount(PerfectComponent, {
      props: {
        product,
        itemId: "item-1",
      },
    });

    // === ACT ===
    const input = wrapper.find(".shopping-cart-item__qty-input") as any;
    input.element.value = "abc";
    await input.trigger("input");
    await wrapper.vm.$nextTick();

    // === ASSERT ===
    const errorDiv = wrapper.find(".shopping-cart-item__error");
    expect(errorDiv.exists()).toBe(true);
    expect(errorDiv.text()).toContain("Quantity must be a number");
  });

  it("should clamp input to max quantity", async () => {
    // === ARRANGE ===
    const product = { id: 1, name: "Test", price: 1000 };
    const wrapper = mount(PerfectComponent, {
      props: {
        product,
        itemId: "item-1",
        maxQuantity: 10,
      },
    });

    // === ACT ===
    const input = wrapper.find(".shopping-cart-item__qty-input") as any;
    input.element.value = "50";
    await input.trigger("input");
    await wrapper.vm.$nextTick();

    // === ASSERT ===
    // AI-REFERENCE: Guard clause clamped value to max
    expect(wrapper.find(".shopping-cart-item__qty-input").element.value).toBe(
      "10",
    );
    expect(wrapper.find(".shopping-cart-item__error").text()).toContain(
      "Maximum quantity is 10",
    );
  });

  it("should clamp input to min quantity", async () => {
    // === ARRANGE ===
    const product = { id: 1, name: "Test", price: 1000 };
    const wrapper = mount(PerfectComponent, {
      props: {
        product,
        itemId: "item-1",
        minQuantity: 2,
      },
    });

    // === ACT ===
    const input = wrapper.find(".shopping-cart-item__qty-input") as any;
    input.element.value = "0";
    await input.trigger("input");
    await wrapper.vm.$nextTick();

    // === ASSERT ===
    expect(wrapper.find(".shopping-cart-item__qty-input").element.value).toBe(
      "2",
    );
    expect(wrapper.find(".shopping-cart-item__error").text()).toContain(
      "Minimum quantity is 2",
    );
  });
});

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 5: REACTIVE COMPUTED PROPERTIES
// ═══════════════════════════════════════════════════════════════════════════

describe("PerfectComponent (Computed Properties)", () => {
  it("should update subtotal when quantity changes", async () => {
    // === ARRANGE ===
    const product = {
      id: 1,
      name: "Test",
      price: 1000, // $10.00
    };

    const wrapper = mount(PerfectComponent, {
      props: {
        product,
        itemId: "item-1",
      },
    });

    // === ACT ===
    await wrapper.find('[aria-label*="Increase"]').trigger("click");
    await wrapper.vm.$nextTick();

    // === ASSERT ===
    // AI-REFERENCE: Computed property recalculates on dependency change
    const subtotal = wrapper.find(".shopping-cart-item__total");
    expect(subtotal.text()).toContain("$20.00"); // 10 * 2
  });

  it("should update quantity info text when quantity changes", async () => {
    // === ARRANGE ===
    const product = { id: 1, name: "Test", price: 1000 };
    const wrapper = mount(PerfectComponent, {
      props: {
        product,
        itemId: "item-1",
        maxQuantity: 5,
      },
    });

    // === ACT ===
    await wrapper.find('[aria-label*="Increase"]').trigger("click");
    await wrapper.vm.$nextTick();

    // === ASSERT ===
    // AI-REFERENCE: Helper text updates based on quantity
    const helpText = wrapper.find(".shopping-cart-item__qty-help");
    expect(helpText.text()).toContain("4 more available"); // 5 - 2 (already incremented once)
  });

  it("should show max reached message when at maximum", async () => {
    // === ARRANGE ===
    const product = { id: 1, name: "Test", price: 1000 };
    const wrapper = mount(PerfectComponent, {
      props: {
        product,
        itemId: "item-1",
        maxQuantity: 1,
      },
    });

    // === ACT ===
    const helpText = wrapper.find(".shopping-cart-item__qty-help");

    // === ASSERT ===
    expect(helpText.text()).toContain("Maximum quantity reached (1)");
  });
});

// ═══════════════════════════════════════════════════════════════════════════
// AUDIT CHECKLIST - Use when reviewing Vue components
// ═══════════════════════════════════════════════════════════════════════════

/*
TEST QUALITY CHECKLIST:

✅ Uses AAA pattern (Arrange, Act, Assert)
✅ Tests synchronous behavior
✅ Tests boundary cases (min, max)
✅ Tests event emissions
✅ Tests computed properties reactivity
✅ Tests input validation
✅ Includes accessibility verification
✅ One reason to fail per test
✅ Guard clauses tested
✅ Error handling verified

COMPONENT CHECKLIST (when writing new tests):
- [ ] Props have defaults defined?
- [ ] Emits are typed (TypeScript)?
- [ ] Reactive state uses ref/reactive?
- [ ] Computed properties used for memoization?
- [ ] Watch has cleanup logic?
- [ ] onMounted has onUnmounted?
- [ ] Guard clauses prevent invalid state?
- [ ] Accessibility attributes present?
- [ ] BEM CSS naming used?
- [ ] Tests follow AAA pattern?
*/
