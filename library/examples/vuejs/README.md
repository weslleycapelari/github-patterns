# Vue.js Examples

Reference implementations for Vue 3 projects following the standards in `library/standards/` and `library/stacks/vuejs/`.

## Files (Planned)

### PerfectComponent.vue (Placeholder - Phase 3)

**Purpose**: Reference implementation of a Vue 3 component with proper reactivity, testing, and accessibility.

**Will Demonstrate**:

- Component lifecycle hooks (onMounted, onUnmounted, watch)
- Reactive state management (ref, reactive, computed)
- Prop validation and type checking with TypeScript
- Event handling and custom events
- Accessibility (a11y) attributes (aria-\*, role, tabindex)
- Testing with Vue Test Utils following AAA pattern
- Composition API for logic reuse
- Immutable state updates
- Guard clauses and early returns

**Will Address Standards**:

- [code-design-logic.md](../standards/code-design-logic.md) — Immutability, guard clauses
- [testing-excellence.md](../standards/testing-excellence.md) — AAA pattern, test doubles
- [vue-architect.agent.md](../stacks/vuejs/vue-architect.agent.md) — Vue.js architecture

---

## How Vue Examples Will Be Structured

When PerfectComponent.vue is implemented, expect:

### 1. Template Structure

```vue
<!-- Clear semantic HTML -->
<template>
  <div class="component-root" role="...">
    <!-- No inline styles; use scoped styles -->
    <button
      @click="handleClick"
      :disabled="isLoading"
      aria-label="Description for accessibility"
    >
      {{ buttonText }}
    </button>
  </div>
</template>
```

### 2. Script Structure (Composition API)

```typescript
<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue';

// Props with type validation
interface Props {
  title: string;
  count?: number;
}

const props = withDefaults(defineProps<Props>(), {
  count: 0,
});

// Emits with type safety
const emit = defineEmits<{
  update: [value: string];
  submit: [formData: Record<string, unknown>];
}>();

// Reactive state
const isLoading = ref(false);
const items = ref<Item[]>([]);

// Computed properties (memoized)
const itemCount = computed(() => items.value.length);

// Lifecycle hooks
onMounted(() => {
  // Setup
});

onUnmounted(() => {
  // Cleanup
});

// Methods
const handleClick = async () => {
  isLoading.value = true;
  try {
    // Guard clauses
    if (!items.value.length) {
      return;
    }
    // Business logic
  } finally {
    isLoading.value = false;
  }
};
</script>
```

### 3. Style Structure

```vue
<style scoped>
/* BEM class naming */
.component-root {
}
.component-root__title {
}
.component-root__item {
}

/* No !important; no global styles in scoped block */
</style>
```

---

## Testing Pattern (Will Mirror Common/PerfectTest.test.ts)

When testing Vue components, follow AAA:

```typescript
// PerfectComponent.test.ts
import { describe, it, expect, beforeEach } from 'vitest';
import { mount } from '@vue/test-utils';
import PerfectComponent from './PerfectComponent.vue';

describe('PerfectComponent (Synchronous)', () => {
  it('should render with correct title', () => {
    // === ARRANGE ===
    const props = { title: 'Test Title' };

    // === ACT ===
    const wrapper = mount(PerfectComponent, { props });

    // === ASSERT ===
    expect(wrapper.find('h1').text()).toBe('Test Title');
  });

  it('should emit update event on button click', async () => {
    // === ARRANGE ===
    const wrapper = mount(PerfectComponent, {
      props: { title: 'Test' }
    });

    // === ACT ===
    await wrapper.find('button').trigger('click');

    // === ASSERT ===
    expect(wrapper.emitted('update')).toHaveLength(1);
  });

  it('should disable button when loading', async () => {
    // === ARRANGE ===
    const wrapper = mount(PerfectComponent, {
      props: { title: 'Test' }
    });

    // === ACT ===
    await wrapper.vm.$data.isLoading = true;
    await wrapper.vm.$nextTick();

    // === ASSERT ===
    expect(wrapper.find('button').attributes('disabled')).toBeDefined();
  });
});

describe('PerfectComponent (Async)', () => {
  it('should fetch data on mount', async () => {
    // === ARRANGE ===
    const mockFetch = vi.fn().mockResolvedValue([
      { id: 1, title: 'Item 1' }
    ]);

    const wrapper = mount(PerfectComponent, {
      props: { title: 'Test' },
      global: {
        provide: { fetchItems: mockFetch }
      }
    });

    // === ACT ===
    await wrapper.vm.$nextTick();

    // === ASSERT ===
    expect(mockFetch).toHaveBeenCalled();
    expect(wrapper.vm.items).toHaveLength(1);
  });

  it('should handle fetch error gracefully', async () => {
    // === ARRANGE ===
    const mockFetch = vi.fn()
      .mockRejectedValue(new Error('Network error'));

    const wrapper = mount(PerfectComponent, {
      props: { title: 'Test' },
      global: {
        provide: { fetchItems: mockFetch }
      }
    });

    // === ACT ===
    await wrapper.vm.$nextTick();

    // === ASSERT ===
    expect(wrapper.vm.errorMessage).toBe('Network error');
  });
});
```

---

## Key Patterns (Will Be Demonstrated)

### 1. Reactive State with Immutability

```typescript
// Bad: Direct mutation
items.value.push(newItem);

// Good: Immutable update
items.value = [...items.value, newItem];
```

### 2. Guard Clauses in Event Handlers

```typescript
const handleSubmit = async (formData) => {
  // Guard: Early return
  if (!formData.email) {
    error.value = "Email is required";
    return;
  }

  if (!isValidEmail(formData.email)) {
    error.value = "Invalid email format";
    return;
  }

  // Main logic
  await submitForm(formData);
};
```

### 3. Computed Properties for Memoization

```typescript
// Bad: Recalculates every render
const displayText = () => items.value.map((i) => i.name).join(", ");

// Good: Memoized until dependencies change
const displayText = computed(() => items.value.map((i) => i.name).join(", "));
```

### 4. Proper Lifecycle Management

```typescript
onMounted(() => {
  // Fetch data
  // Start timers
  // Subscribe to events
});

onUnmounted(() => {
  // Cancel pending requests
  // Clear timers
  // Unsubscribe from events
});
```

### 5. Accessibility as First-Class Concern

```vue
<!-- Every interactive element needs accessibility -->
<button @click="toggle" :aria-expanded="isOpen" :aria-label="`Toggle ${title}`">
  {{ isOpen ? 'Close' : 'Open' }}
</button>

<div role="region" :aria-labelledby="titleId" :aria-hidden="!isOpen">
  <!-- Content -->
</div>
```

---

## Audit Checklist: Vue Components (Template)

Use this when reviewing Vue components in your codebase:

- [ ] Props have TypeScript types?
- [ ] Props have default values where needed?
- [ ] Emits are typed and documented?
- [ ] Reactive state uses `ref` or `reactive` appropriately?
- [ ] Computed properties used for memoization?
- [ ] Watch watchers have cleanup?
- [ ] onMounted has corresponding onUnmounted?
- [ ] No direct DOM manipulation (`querySelector`, `innerHTML`)?
- [ ] Event handlers use guard clauses?
- [ ] Accessibility attributes present (aria-\*, role)?
- [ ] No inline styles?
- [ ] CSS uses BEM naming convention?
- [ ] Tests use AAA pattern?
- [ ] Component props are immutable?

---

## Example Use Cases (When Implemented)

### Use Case 1: Shopping Cart Item Counter

Component with:

- Increment/Decrement buttons
- Validation for min/max
- Event emission to parent
- Accessibility for screen readers

### Use Case 2: Data Table with Sorting

Component with:

- Reactive table state
- Sort column selection
- Computed sorted items
- Lifecycle for data fetch

### Use Case 3: Form with Validation

Component with:

- Prop validation for rules
- Guard clauses for form submission
- Error state management
- Custom event for submit

---

## Related Documentation

- **Vue Stack**: See `library/stacks/vuejs/` for full Vue guidance
- **Testing**: See `library/examples/common/PerfectTest.test.ts` for AAA pattern
- **Code Design**: See `library/standards/code-design-logic.md` for immutability rules
- **Vue Test Utils**: https://test-utils.vuejs.org/

---

## Current Status

**Phase 1**: Common/PerfectTest.test.ts ✅ Complete  
**Phase 2**: Laravel/PerfectAction.php ✅ Complete  
**Phase 3**: Vue.js/PerfectComponent.vue ⏳ Planned

---

**Next Steps**: Check back for Phase 3 implementation of PerfectComponent.vue with full working example and tests.
