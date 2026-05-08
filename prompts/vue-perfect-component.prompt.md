# Prompt: Vue 3 Perfect Component — Excellence Patterns

## Objective

Generate a **production-ready Vue 3 Single File Component (SFC)** that exemplifies excellence in:

- Script Setup + TypeScript composition
- Type-safe props, emits, and store integration
- Reactive state ownership (Pinia with storeToRefs)
- Composable-driven logic separation
- Performance-first computed/watch patterns
- Accessibility and a11y foundations
- Testability and isolation

This prompt is the operational reference for generating components that serve as **learning blueprints** for the organization.

---

## Context

Vue 3 composition patterns can diverge significantly in quality:

- **Props & emits** often lack explicit TypeScript contracts
- **Reactive state** sometimes relies on direct mutations or prop drilling
- **Computed values** can trigger unnecessary re-renders when misused
- **Event handlers** are frequently untyped or overly coupled
- **Logic** is often mixed into presentation code instead of composables
- **Accessibility** is an afterthought, not a design-time commitment

This prompt ensures components adhere to **five immovable standards**:

1. **Type Safety**: All boundaries (props, emits, store access) are explicit and verified.
2. **Separation of Concerns**: UI presentation is decoupled from business logic (via composables).
3. **Reactive Integrity**: State is never mutated; mutations happen via store or composable abstractions.
4. **Performance Awareness**: Computed/watch/lazy patterns are used correctly for their intended purpose.
5. **Accessibility First**: Semantic HTML, ARIA attributes, and keyboard navigation are non-negotiable.

---

## Input Contract

### Required Inputs (from the agent or user initiating this prompt):

1. **Component Name** (e.g., `PerfectComponent`, `UserFormCard`):
   - Must be PascalCase.
   - Reflects single responsibility.

2. **Component Purpose** (e.g., "Form for user profile update", "Paginated data table with filters"):
   - 1-2 sentences explaining the primary interaction.
   - Identifies success criteria for accessibility and performance.

3. **Data Model** (JSON Schema or TypeScript interface):
   - Example: User { id, name, email, roles, createdAt }
   - Drive prop contracts, emit payloads, and store shape.

4. **Composables to Integrate** (optional):
   - If logic should delegate to custom composables, specify their names and signatures.
   - Example: `useFormSubmit({ initialValues, onSuccess, onError })`
   - Example: `usePagination({ pageSize, totalItems })`

5. **Store Integration** (optional):
   - Pinia store name and state schema.
   - Actions to call (read-only, no direct mutation in component).
   - Example: `useUserStore()` with `getUsers()`, `createUser(payload)`.

6. **Accessibility Scope** (optional, defaults to "WCAG 2.1 AA minimum"):
   - WCAG 2.1 AA (minimum)
   - WCAG 2.1 AAA (enhanced)
   - Custom requirements (e.g., "keyboard-only navigation required")

7. **Performance Constraints** (optional):
   - Bundle size ceiling (e.g., "< 15KB minified")
   - Render churn tolerance (e.g., "no re-renders on scroll within list")
   - Lazy loading hints (e.g., "images should be lazy-loaded", "modal content deferred")

---

## Output Contract

### Deliverable: Single SFC File

**File**: `[ComponentName].vue`

**Structure**:

```vue
<script setup lang="ts">
// ── TYPE DEFINITIONS (not importing, defining local types if not in shared model)
// ── IMPORTS: composables, stores, utilities (organized and explicitly typed)
// ── PROPS: TypeScript interface with JSDoc
// ── EMITS: explicit emit types with payloads
// ── STORE SETUP: storeToRefs + readonly where applicable
// ── COMPOSABLE SETUP: call custom composables with proper error handling
// ── STATE: ref(), computed(), watch() with explicit types
// ── COMPUTED: readonly, side-effect-free, lazy evaluation aware
// ── WATCH: debounce/throttle guards, clear side effects
// ── HANDLERS: event handlers with explicit TypeScript signatures
// ── LIFECYCLE: optional onMounted, onBeforeUnmount (if needed)
</script>

<template>
  <!-- ROOT: single logical container, semantic HTML -->
  <!-- GUARDS: v-if for conditional rendering (not v-show unless justified) -->
  <!-- A11Y: role, aria-label, aria-describedby, aria-live where needed -->
  <!-- EVENTS: @click, @submit, @input with typed handlers -->
</template>

<style scoped>
/* BEM naming if applicable; prefer Tailwind or CSS Modules in real projects */
/* Scoped styles only; no global pollution */
</style>
```

### Quality Gates (Non-Negotiable)

1. **Type Safety**:
   - [ ] Props typed via `interface` or `type`.
   - [ ] Emits have explicit payload types.
   - [ ] Store access uses `storeToRefs()` or `readonly()` (no direct mutations).
   - [ ] All event handlers have explicit TypeScript signatures.

2. **Separation of Concerns**:
   - [ ] No business logic in `<template>`.
   - [ ] Logic delegated to composables or store actions.
   - [ ] Template contains only presentation and event binding.

3. **Reactivity Integrity**:
   - [ ] No direct mutation of props.
   - [ ] No direct mutation of store state (mutations via actions).
   - [ ] `computed()` returns readonly derived state.
   - [ ] `watch()` has cleanup handlers if side effects run.

4. **Performance**:
   - [ ] `computed()` used for derived state (memoized).
   - [ ] `watch()` only for expensive side effects (with guards: debounce, conditional).
   - [ ] No computed properties with side effects.
   - [ ] Lazy loading hints present for images or modal content.

5. **Accessibility**:
   - [ ] Semantic HTML tags (`<button>`, `<form>`, `<label>`, `<nav>` where applicable).
   - [ ] `<label for="id">` for all form inputs.
   - [ ] `aria-label` or `aria-describedby` for unlabeled controls.
   - [ ] `role`, `aria-live`, `aria-expanded` for dynamic/interactive regions.
   - [ ] Keyboard navigation support (`@keydown.enter`, `@keydown.escape`).
   - [ ] Focus management hints (e.g., autofocus on modal open, return focus on close).

6. **Comments & Documentation**:
   - [ ] `// AI-REFERENCE: [reason]` comments on critical patterns.
   - [ ] JSDoc for props interface and public composable signatures.
   - [ ] Inline comments only where intent is non-obvious.

7. **Testability**:
   - [ ] Composables are pure functions (no component context required).
   - [ ] Store integration uses only actions (no direct state access in component).
   - [ ] Event handlers can be verified independently.

---

## Workflow for Generation

### Phase 1: Define Boundaries

- Validate input contract is complete.
- Create prop interface with defaults and validators.
- Define emit payloads explicitly.

### Phase 2: State & Store Setup

- If using Pinia, initialize with `storeToRefs()`.
- Define local state (`ref()`, `computed()`) for ephemeral UI state.
- Separate concerns: store for domain data, local state for UI chrome.

### Phase 3: Composable Delegation

- Extract business logic into composables.
- Example: `useFormSubmit()` handles validation, API calls, and error state.
- Example: `usePagination()` handles page size, current page, and memoization.
- Pass composables as inputs; ensure they're pure (testable).

### Phase 4: Reactive Pattern Application

- Use `computed()` for memoized derived state.
- Use `watch()` for expensive side effects (with guards: debounce, throttle).
- Apply `readonly()` to prevent accidental mutations.
- Document why each `computed`/`watch` exists with `// AI-REFERENCE:`.

### Phase 5: Template & Accessibility

- Write semantic HTML first.
- Add `aria-*` attributes for interactive regions.
- Implement keyboard navigation (`@keydown`, focus traps).
- Use `v-if` for conditional rendering (test and hide), not `v-show`.

### Phase 6: Styling Strategy

- If **Tailwind CSS** is available: use utility classes in template (preferred for performance).
- If **CSS Modules** are required: use scoped `<style module>` with explicit class bindings.
- If **scoped styles only**: follow BEM naming convention (`block__element--modifier`).
- **Never** mix unscoped global styles with component styles.

### Phase 7: Comment Critical Patterns

- Mark each critical decision with `// AI-REFERENCE: [reason]`.
- Document why computed/watch patterns are used.
- Explain why certain state is local vs. store-managed.

### Phase 8: Error Handling Patterns

- **Composable errors**: return error state (not throw); component decides UI action.
- **API errors**: catch and emit with context (`emit('error', { code, message, context })`).
- **Validation errors**: store in reactive state; display inline with `aria-describedby`.
- **Recovery**: provide user-facing retry buttons with exponential backoff hints.

---

## Anti-Patterns to Avoid

- ❌ Direct mutation of props or store state in component.
- ❌ Business logic mixed into `<template>`.
- ❌ Untyped props or event handlers.
- ❌ `computed()` with side effects (use `watch()` instead).
- ❌ Unnecessary `watch()` watchers (overuse causes memory leaks).
- ❌ `v-show` for conditionally rendering large subtrees (use `v-if`).
- ❌ Prop drilling across deep trees (use composables or Pinia).
- ❌ Direct store state mutation without actions.
- ❌ Missing `aria-label`, `role`, or semantic HTML tags.
- ❌ Unhandled side effects in watch (memory leaks, dangling timers).

---

## Concrete Example

### Composable Pattern with TypeScript Generics

If your composable needs to be generic (reusable across multiple data types), pattern it like this:

```typescript
// composables/useFormSubmit.ts
import { ref, computed } from "vue";

interface FormSubmitOptions<T> {
  initialValues: T;
  onSuccess: (values: T) => Promise<void>;
  onError: (error: Error) => void;
}

interface FormSubmitReturn<T> {
  formValues: Ref<T>;
  errors: Ref<Partial<Record<keyof T, string>>>;
  isLoading: Ref<boolean>;
  submit: () => Promise<void>;
}

/**
 * AI-REFERENCE: Generic composable for type-safe form submission
 * Ensures type safety across all components that use this composable
 */
export function useFormSubmit<T extends Record<string, any>>(
  options: FormSubmitOptions<T>,
): FormSubmitReturn<T> {
  const formValues = ref<T>({ ...options.initialValues });
  const errors = ref<Partial<Record<keyof T, string>>>({});
  const isLoading = ref(false);

  const submit = async () => {
    isLoading.value = true;
    try {
      await options.onSuccess(formValues.value);
    } catch (error) {
      options.onError(error as Error);
      errors.value = {
        [Object.keys(formValues.value)[0]]: (error as Error).message,
      };
    } finally {
      isLoading.value = false;
    }
  };

  return {
    formValues,
    errors,
    isLoading,
    submit,
  };
}
```

### Input

### Input

```
Component Name: UserProfileForm
Purpose: Edit user profile (name, email, roles). Submit via API. Show validation errors inline. Disable submit while loading.
Data Model: { id: string; name: string; email: string; roles: Role[] }
Composables: useFormSubmit({ initialValues, onSuccess, onError })
Store: useUserStore() with createUser(user), updateUser(id, user)
A11y: WCAG 2.1 AA, keyboard-required
Styling: Tailwind CSS (preferred), fallback to scoped BEM
Performance: < 10KB minified, no re-renders on store updates outside form scope
```

### Output Skeleton

```vue
<script setup lang="ts">
// AI-REFERENCE: Props are explicitly typed; no implicit `any` types
interface Props {
  userId?: string;
  readonly: boolean;
}

const props = withDefaults(defineProps<Props>(), {
  readonly: false,
});

// AI-REFERENCE: Emits are explicitly typed with payload contract
const emit = defineEmits<{
  "profile-updated": [user: User];
  error: [error: Error];
}>();

// AI-REFERENCE: Store access uses storeToRefs to prevent direct mutations
const userStore = useUserStore();
const { users } = storeToRefs(userStore);

// AI-REFERENCE: Composable encapsulates form state and submission logic
const { formValues, errors, isLoading, submit } = useFormSubmit({
  initialValues: { name: "", email: "", roles: [] },
  onSuccess: async (user) => {
    await userStore.updateUser(props.userId, user);
    emit("profile-updated", user);
  },
  onError: (err) => {
    emit("error", err);
  },
});

// AI-REFERENCE: computed() provides memoized derived state; prevents render churn
const isFormValid = computed(
  () => formValues.value.email.length > 0 && !errors.value.email,
);
const isSubmitDisabled = computed(
  () => isLoading.value || !isFormValid.value || props.readonly,
);

// AI-REFERENCE: watch() is guarded and handles cleanup to avoid side effects
watch(
  () => formValues.value.email,
  (newEmail) => {
    // Validate email after 500ms debounce (to avoid excessive API calls)
    // Implementation includes cleanup
  },
  { debounce: 500 },
);
</script>

<template>
  <form
    @submit.prevent="submit"
    class="user-profile-form"
    role="form"
    aria-label="Edit User Profile"
  >
    <!-- AI-REFERENCE: Semantic form with label + aria-describedby for accessible error messaging -->
    <div class="form-group">
      <label for="name-input">Full Name</label>
      <input
        id="name-input"
        v-model="formValues.name"
        type="text"
        required
        :disabled="props.readonly"
        aria-describedby="name-error"
      />
      <!-- AI-REFERENCE: v-if guards conditional rendering of error (not v-show) -->
      <span v-if="errors.name" id="name-error" class="error" role="alert">{{
        errors.name
      }}</span>
    </div>

    <div class="form-group">
      <label for="email-input">Email</label>
      <input
        id="email-input"
        v-model="formValues.email"
        type="email"
        required
        :disabled="props.readonly"
        aria-describedby="email-error"
      />
      <span v-if="errors.email" id="email-error" class="error" role="alert">{{
        errors.email
      }}</span>
    </div>

    <!-- AI-REFERENCE: Submit button is disabled based on computed state; no inline logic -->
    <button
      type="submit"
      :disabled="isSubmitDisabled"
      :aria-busy="isLoading"
      aria-label="Save profile changes"
    >
      {{ isLoading ? "Saving..." : "Save" }}
    </button>
  </form>
</template>

<style scoped>
.user-profile-form {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.form-group {
  display: flex;
  flex-direction: column;
}

label {
  margin-bottom: 0.5rem;
  font-weight: 600;
}

input {
  padding: 0.5rem;
  border: 1px solid #ccc;
  border-radius: 4px;
}

input:disabled {
  background-color: #f0f0f0;
  cursor: not-allowed;
}

.error {
  color: red;
  font-size: 0.875rem;
  margin-top: 0.25rem;
}

button {
  padding: 0.75rem 1rem;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-weight: 600;
}

button:disabled {
  background-color: #ccc;
  cursor: not-allowed;
}
</style>
```

---

## Test Example (Post-Component)

After generating the component, provide a minimal **Vitest + @testing-library/vue** test:

```typescript
import { describe, it, expect, vi, beforeEach } from "vitest";
import { mount } from "@vue/test-utils";
import UserProfileForm from "./UserProfileForm.vue";
import { createPinia, setActivePinia } from "pinia";

describe("UserProfileForm", () => {
  beforeEach(() => {
    setActivePinia(createPinia());
  });

  it("renders form with all required inputs", () => {
    const wrapper = mount(UserProfileForm);
    expect(wrapper.find('input[type="text"]').exists()).toBe(true);
    expect(wrapper.find('input[type="email"]').exists()).toBe(true);
    expect(wrapper.find('button[type="submit"]').exists()).toBe(true);
  });

  it("emits profile-updated event on successful submit", async () => {
    const wrapper = mount(UserProfileForm, {
      props: { userId: "123" },
    });

    await wrapper.find('input[type="text"]').setValue("John Doe");
    await wrapper.find('input[type="email"]').setValue("john@example.com");
    await wrapper.find("form").trigger("submit");

    // Assert emit was called with correct payload
    expect(wrapper.emitted("profile-updated")).toBeTruthy();
  });

  it("disables submit button while loading", async () => {
    const wrapper = mount(UserProfileForm);
    const submitBtn = wrapper.find('button[type="submit"]');

    // Simulate loading state
    await wrapper.vm.$nextTick(); // wait for reactivity

    // Button should have disabled attribute when loading
    expect(submitBtn.attributes("disabled")).toBeDefined();
  });

  it("displays validation errors with aria-describedby", async () => {
    const wrapper = mount(UserProfileForm);
    const emailInput = wrapper.find('input[type="email"]');

    // Trigger validation (e.g., by unfocus or submit without value)
    await emailInput.trigger("blur");
    await wrapper.vm.$nextTick();

    const errorSpan = wrapper.find("#email-error");
    expect(errorSpan.exists()).toBe(true);
    expect(emailInput.attributes("aria-describedby")).toBe("email-error");
  });

  it("respects readonly prop", () => {
    const wrapper = mount(UserProfileForm, {
      props: { readonly: true },
    });

    expect(
      wrapper.find('input[type="text"]').attributes("disabled"),
    ).toBeDefined();
    expect(
      wrapper.find('button[type="submit"]').attributes("disabled"),
    ).toBeDefined();
  });
});
```

---

## Validation Checklist (Post-Generation)

Before finalizing the component:

1. **Syntax & Parsing**:
   - [ ] Vue SFC parses without errors (`@vitejs/plugin-vue`).
   - [ ] TypeScript types compile without errors (`tsc --noEmit`).

2. **Type Safety**:
   - [ ] Run `tsc` and verify no implicit `any` warnings.
   - [ ] Props and emits have explicit TypeScript contracts.

3. **Performance**:
   - [ ] No console warnings about redundant re-renders.
   - [ ] Computed properties are truly memoized (accessed multiple times in template).
   - [ ] Watch handlers have cleanup (no dangling subscriptions).

4. **Accessibility**:
   - [ ] All inputs have associated `<label>` tags.
   - [ ] Interactive regions have `role`, `aria-label`, or `aria-describedby`.
   - [ ] Keyboard navigation verified (Tab, Enter, Escape).

5. **Testability**:
   - [ ] Composables can be tested independently (pure functions).
   - [ ] Store actions are mockable (no component-context dependencies).
   - [ ] Event handlers are verifiable via `vi.fn()` spies.

---

## Known Limitations

- This prompt assumes **Pinia** for store management. If using Vuex or custom state, adjust store access patterns.
- Accessibility scope defaults to **WCAG 2.1 AA**; AAA requires additional inputs.
- **Bundle size** is measured post-minification; actual impact depends on tree-shaking and vendor bundles.
- **Performance constraints** assume Vue 3 Composition API with modern tooling (Vite, esbuild); legacy builds may differ.

---

## Usage

Invoke this prompt when:

- Creating a component blueprint for organizational patterns.
- Teaching Vue 3 excellence to a team.
- Auditing existing components against these standards.
- Generating test fixtures or learning examples.

**Do NOT use this prompt** for:

- One-off utility components or micro-fragments.
- Highly specialized domain logic that deviates significantly from standard patterns.
- Legacy Vue 2 or complex Options API migration scenarios (use domain-specific prompts instead).
