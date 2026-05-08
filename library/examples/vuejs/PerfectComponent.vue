<template>
  <div
    class="shopping-cart-item"
    role="group"
    :aria-labelledby="`item-${itemId}`"
  >
    <!-- Header with product name -->
    <div class="shopping-cart-item__header">
      <h3 :id="`item-${itemId}`" class="shopping-cart-item__title">
        {{ product.name }}
      </h3>
      <button
        class="shopping-cart-item__remove"
        @click="handleRemove"
        :aria-label="`Remove ${product.name} from cart`"
      >
        ✕
      </button>
    </div>

    <!-- Product details -->
    <div class="shopping-cart-item__details">
      <span class="shopping-cart-item__price">
        {{ formatPrice(product.price) }}
      </span>
      <span
        v-if="product.discount"
        class="shopping-cart-item__discount"
        :aria-label="`Discount: ${product.discount}%`"
      >
        -{{ product.discount }}%
      </span>
    </div>

    <!-- Quantity controls (AAA: Arrange, Act, Assert behavior) -->
    <div class="shopping-cart-item__quantity">
      <label :for="`qty-${itemId}`" class="shopping-cart-item__label">
        Quantity:
      </label>
      <button
        :id="`qty-dec-${itemId}`"
        class="shopping-cart-item__qty-btn"
        @click="decrementQuantity"
        :disabled="quantity <= minQuantity"
        :aria-label="`Decrease quantity (minimum: ${minQuantity})`"
      >
        −
      </button>
      <input
        :id="`qty-${itemId}`"
        type="number"
        class="shopping-cart-item__qty-input"
        :value="quantity"
        :min="minQuantity"
        :max="maxQuantity"
        @input="updateQuantity"
        :aria-describedby="`qty-help-${itemId}`"
      />
      <button
        :id="`qty-inc-${itemId}`"
        class="shopping-cart-item__qty-btn"
        @click="incrementQuantity"
        :disabled="quantity >= maxQuantity"
        :aria-label="`Increase quantity (maximum: ${maxQuantity})`"
      >
        +
      </button>
      <span :id="`qty-help-${itemId}`" class="shopping-cart-item__qty-help">
        {{ quantityInfo }}
      </span>
    </div>

    <!-- Total for this item -->
    <div class="shopping-cart-item__total">
      Subtotal: {{ formatPrice(subtotal) }}
    </div>

    <!-- Error message (if any) -->
    <div
      v-if="errorMessage"
      class="shopping-cart-item__error"
      role="alert"
      aria-live="polite"
    >
      {{ errorMessage }}
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from "vue";

// ═══════════════════════════════════════════════════════════════════════════
// TYPE DEFINITIONS
// ═══════════════════════════════════════════════════════════════════════════

/**
 * Product interface with readonly properties.
 * Ensures immutability at type level.
 */
interface Product {
  readonly id: number;
  readonly name: string;
  readonly price: number; // Price in cents
  readonly discount?: number; // Discount percentage (0-100)
}

/**
 * Props interface for component.
 * All props are readonly by Vue convention.
 */
interface Props {
  product: Product;
  itemId: string;
  minQuantity?: number;
  maxQuantity?: number;
}

// ═══════════════════════════════════════════════════════════════════════════
// COMPONENT SETUP
// ═══════════════════════════════════════════════════════════════════════════

// AI-REFERENCE: Props with defaults and type validation
const props = withDefaults(defineProps<Props>(), {
  minQuantity: 1,
  maxQuantity: 99,
});

// AI-REFERENCE: Emits with type safety
const emit = defineEmits<{
  quantityChanged: [quantity: number];
  removed: [];
}>();

// AI-REFERENCE: Reactive state using ref (single values)
const quantity = ref(1);
const errorMessage = ref("");

// ═══════════════════════════════════════════════════════════════════════════
// COMPUTED PROPERTIES (Memoized, reactive)
// ═══════════════════════════════════════════════════════════════════════════

/**
 * Calculate subtotal with discount applied.
 *
 * AI-REFERENCE: Computed properties are memoized.
 * The result only recalculates when dependencies change (price, quantity, discount).
 */
const subtotal = computed(() => {
  const baseTotal = props.product.price * quantity.value;

  // AI-REFERENCE: Guard clause for discount
  if (!props.product.discount || props.product.discount <= 0) {
    return baseTotal;
  }

  const discountAmount = baseTotal * (props.product.discount / 100);
  return baseTotal - discountAmount;
});

/**
 * Friendly quantity information text.
 */
const quantityInfo = computed(() => {
  // AI-REFERENCE: Guard clause for max quantity
  if (quantity.value >= props.maxQuantity) {
    return `Maximum quantity reached (${props.maxQuantity})`;
  }

  const remaining = props.maxQuantity - quantity.value;
  return `${remaining} more available`;
});

// ═══════════════════════════════════════════════════════════════════════════
// LIFECYCLE HOOKS
// ═══════════════════════════════════════════════════════════════════════════

/**
 * Initialize component.
 *
 * AI-REFERENCE: onMounted for setup operations.
 * This is where you'd fetch additional data if needed.
 */
onMounted(() => {
  // AI-REFERENCE: Validate props at runtime
  validateProps();
});

// ═══════════════════════════════════════════════════════════════════════════
// EVENT HANDLERS WITH GUARD CLAUSES
// ═══════════════════════════════════════════════════════════════════════════

/**
 * Increment quantity with boundary checks.
 *
 * AI-REFERENCE: Guard clauses prevent invalid state.
 * Early return for boundary conditions.
 */
const incrementQuantity = (): void => {
  // Guard: Check if at maximum
  if (quantity.value >= props.maxQuantity) {
    errorMessage.value = `Cannot exceed ${props.maxQuantity} items`;
    return;
  }

  // AI-REFERENCE: Immutable state update
  // Create new value instead of mutating
  quantity.value += 1;
  errorMessage.value = ""; // Clear error on valid action

  // AI-REFERENCE: Emit event to parent
  emit("quantityChanged", quantity.value);
};

/**
 * Decrement quantity with boundary checks.
 */
const decrementQuantity = (): void => {
  // Guard: Check if at minimum
  if (quantity.value <= props.minQuantity) {
    errorMessage.value = `Cannot go below ${props.minQuantity} item(s)`;
    return;
  }

  // Immutable state update
  quantity.value -= 1;
  errorMessage.value = "";

  emit("quantityChanged", quantity.value);
};

/**
 * Update quantity from input field.
 *
 * AI-REFERENCE: Input validation for user-entered values.
 * Sanitize and validate before updating state.
 */
const updateQuantity = (event: Event): void => {
  const target = event.target as HTMLInputElement;
  const newQuantity = parseInt(target.value, 10);

  // Guard: Validate parsed value
  if (isNaN(newQuantity)) {
    errorMessage.value = "Quantity must be a number";
    return;
  }

  // Guard: Check boundaries
  if (newQuantity < props.minQuantity) {
    errorMessage.value = `Minimum quantity is ${props.minQuantity}`;
    quantity.value = props.minQuantity;
    return;
  }

  if (newQuantity > props.maxQuantity) {
    errorMessage.value = `Maximum quantity is ${props.maxQuantity}`;
    quantity.value = props.maxQuantity;
    return;
  }

  // Update to valid value
  quantity.value = newQuantity;
  errorMessage.value = "";

  emit("quantityChanged", quantity.value);
};

/**
 * Remove item from cart.
 *
 * AI-REFERENCE: Event emission for parent coordination.
 * Component doesn't delete itself; parent decides what to do.
 */
const handleRemove = (): void => {
  emit("removed");
};

// ═══════════════════════════════════════════════════════════════════════════
// HELPER FUNCTIONS
// ═══════════════════════════════════════════════════════════════════════════

/**
 * Format price from cents to currency string.
 *
 * AI-REFERENCE: Pure function for formatting.
 * No side effects; same input always gives same output.
 */
const formatPrice = (priceInCents: number): string => {
  const dollars = priceInCents / 100;
  return new Intl.NumberFormat("en-US", {
    style: "currency",
    currency: "USD",
  }).format(dollars);
};

/**
 * Validate props at runtime.
 *
 * AI-REFERENCE: Runtime validation beyond TypeScript.
 * TypeScript prevents type errors but can't validate values.
 */
const validateProps = (): void => {
  // Guard: Validate min/max relationship
  if (props.minQuantity > props.maxQuantity) {
    console.warn(
      `ShoppingCartItem: minQuantity (${props.minQuantity}) > maxQuantity (${props.maxQuantity})`,
    );
  }

  // Guard: Validate price
  if (props.product.price < 0) {
    console.warn(`ShoppingCartItem: negative price not allowed`);
  }
};
</script>

<style scoped>
/* ═══════════════════════════════════════════════════════════════════════════
   COMPONENT STYLES
   
   AI-REFERENCE: BEM (Block Element Modifier) naming convention.
   Scope: This style is scoped to this component only.
   No global pollution, no specificity wars.
   ═════════════════════════════════════════════════════════════════════════ */

.shopping-cart-item {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  padding: 1.5rem;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  background-color: #f9f9f9;
}

.shopping-cart-item__header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 1rem;
}

.shopping-cart-item__title {
  margin: 0;
  font-size: 1.125rem;
  font-weight: 600;
  color: #333;
}

.shopping-cart-item__remove {
  padding: 0.5rem;
  background-color: transparent;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 1.25rem;
  color: #999;
  transition: color 0.2s ease;
}

.shopping-cart-item__remove:hover {
  color: #d32f2f;
}

.shopping-cart-item__remove:disabled {
  cursor: not-allowed;
  opacity: 0.5;
}

.shopping-cart-item__details {
  display: flex;
  gap: 1rem;
  align-items: center;
}

.shopping-cart-item__price {
  font-size: 1rem;
  font-weight: 600;
  color: #2e7d32;
}

.shopping-cart-item__discount {
  display: inline-block;
  padding: 0.25rem 0.5rem;
  background-color: #fff3cd;
  border-radius: 4px;
  font-size: 0.875rem;
  color: #856404;
  font-weight: 500;
}

.shopping-cart-item__quantity {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.shopping-cart-item__label {
  font-size: 0.875rem;
  font-weight: 500;
  color: #666;
}

.shopping-cart-item__qty-btn {
  padding: 0.5rem 0.75rem;
  background-color: #f0f0f0;
  border: 1px solid #d0d0d0;
  border-radius: 4px;
  cursor: pointer;
  font-size: 1rem;
  color: #333;
  transition: background-color 0.2s ease;
}

.shopping-cart-item__qty-btn:hover:not(:disabled) {
  background-color: #e0e0e0;
}

.shopping-cart-item__qty-btn:disabled {
  cursor: not-allowed;
  opacity: 0.5;
}

.shopping-cart-item__qty-input {
  width: 60px;
  padding: 0.5rem;
  border: 1px solid #d0d0d0;
  border-radius: 4px;
  text-align: center;
  font-size: 1rem;
}

.shopping-cart-item__qty-input:focus {
  outline: none;
  border-color: #1976d2;
  box-shadow: 0 0 0 2px rgba(25, 118, 210, 0.1);
}

.shopping-cart-item__qty-help {
  font-size: 0.75rem;
  color: #999;
  margin-left: 0.5rem;
}

.shopping-cart-item__total {
  font-size: 1rem;
  font-weight: 600;
  color: #333;
  text-align: right;
}

.shopping-cart-item__error {
  padding: 0.75rem;
  background-color: #ffebee;
  border: 1px solid #ef5350;
  border-radius: 4px;
  color: #d32f2f;
  font-size: 0.875rem;
}
</style>
