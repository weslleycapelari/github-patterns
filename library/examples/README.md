# Library Examples

Reference implementations demonstrating how to write production-quality code following the standards in `library/standards/`.

Use these examples as:

1. **Learning guides** for new team members
2. **Audit templates** to compare project code against known-good patterns
3. **Code review checklists** to verify standards compliance
4. **Reference patterns** when implementing new features

---

## Structure

```
library/examples/
├── README.md (this file)
├── common/                    # Universal testing patterns
│   ├── PerfectTest.test.ts   # AAA pattern reference (sync, async, mocks, stubs, spies)
│   └── README.md             # Detailed AAA explanation + audit checklist
│
├── laravel/                   # PHP/Laravel stack examples
│   ├── PerfectAction.php     # Action classes following command pattern + TDD
│   └── (future) PerfectMigration.php, PerfectTestCase.php
│
└── vuejs/                     # JavaScript/Vue stack examples
    ├── PerfectComponent.vue  # Component lifecycle, reactivity, testing patterns
    └── (future) PerfectComposable.ts, PerfectStore.ts
```

---

## Examples Overview

### 1. Common: PerfectTest.test.ts

**Purpose**: Reference implementation of AAA (Arrange-Act-Assert) pattern.

**Demonstrates**:

- ✅ Arrange phase: Data preparation, mocks, fixtures
- ✅ Act phase: Isolated code execution
- ✅ Assert phase: Behavior verification
- ✅ Synchronous pure functions
- ✅ Async operations and promises
- ✅ Mocking side effects (behavior verification)
- ✅ Stubs for fixed return values
- ✅ Spies for real behavior + verification
- ✅ Boundary testing (edge cases)
- ✅ Error path testing

**Implementation Standards Addressed**:

- [testing-excellence.md](../standards/testing-excellence.md) — TDD, AAA, test doubles
- [code-design-logic.md](../standards/code-design-logic.md) — Immutability, guard clauses

**How to Use in Audits**:

1. Review your test file structure
2. Compare against each section of `PerfectTest.test.ts`
3. Check: Does your code follow the same AAA boundaries?
4. Add missing boundary cases
5. Use the checklist in `common/README.md` for sign-off

**Example Audit Finding**:

```markdown
# Audit: Order Discount Tests

## Test: calculateDiscount.test.ts

| Pattern           | Status     | Gap                              |
| ----------------- | ---------- | -------------------------------- |
| AAA structure     | ✅ Clear   | —                                |
| Boundary tests    | ❌ Missing | Need: zero%, 100%, NaN, negative |
| Async handling    | N/A        | —                                |
| Mock verification | ✅ Correct | Verifies logger called           |

**Action**: Add 3 boundary tests before merge.
```

---

### 2. Laravel: PerfectAction.php (Future)

**Purpose**: Reference implementation of a domain action class following TDD.

**Will Demonstrate**:

- Action pattern (single responsibility)
- Guard clauses and early returns
- Immutable inputs, new outputs
- Test structure for PHP/Pest
- Database transaction handling
- Authorization checks
- Input validation

**Implementation Standards**:

- [code-design-logic.md](../standards/code-design-logic.md)
- [testing-excellence.md](../standards/testing-excellence.md)
- Laravel stack standards in `library/stacks/laravel/`

---

### 3. Vue.js: PerfectComponent.vue (Future)

**Purpose**: Reference implementation of a Vue component with proper reactivity and testing.

**Will Demonstrate**:

- Component lifecycle hooks
- Reactive state management
- Prop validation
- Event handling
- Testing with Vue Test Utils
- Composition API patterns
- Accessibility (a11y)

**Implementation Standards**:

- [code-design-logic.md](../standards/code-design-logic.md)
- Vue.js stack standards in `library/stacks/vuejs/`

---

## How to Use These Examples

### Scenario 1: Learning a New Pattern

**Goal**: Write your first action class in Laravel.

**Steps**:

1. Read `laravel/PerfectAction.php` (future file)
2. Copy the structure
3. Replace the business logic with your own
4. Follow the test pattern from `common/PerfectTest.test.ts`
5. Run tests and verify AAA structure

---

### Scenario 2: Code Review Checklist

**Goal**: Verify a pull request follows standards.

**Steps**:

1. Identify the code type (test, action, component)
2. Open the corresponding example file
3. Compare:
   - [ ] Structure matches
   - [ ] Naming conventions match
   - [ ] Error handling patterns match
   - [ ] Test coverage matches
4. Add comments referencing the example

**Example Comment**:

```markdown
@author Thanks for the PR! Please review against `library/examples/common/PerfectTest.test.ts`:

- ✅ AAA structure is clear
- ❌ Missing boundary test for zero discount
- See the "Boundary Testing" section for what's expected.
```

---

### Scenario 3: Architectural Audit

**Goal**: Assess overall code quality in a module.

**Steps**:

1. List all code files in the module (tests, actions, components)
2. Open the corresponding examples for each file type
3. Create an audit matrix:

```markdown
# Code Quality Audit Report

## Module: Orders

| File                  | Type      | AAA Compliance | Standards Alignment | Action                          |
| --------------------- | --------- | -------------- | ------------------- | ------------------------------- |
| OrderTest.ts          | Test      | 90%            | ✅                  | Minor: Add boundary tests       |
| CreateOrderAction.php | Action    | ✅             | ✅                  | Approved                        |
| OrderForm.vue         | Component | 70%            | ⚠️                  | Review: Prop validation missing |

**Summary**: 5 files reviewed. 3 approved, 2 need revision.
```

---

### Scenario 4: Writing New Code

**Goal**: Implement a new feature with quality standards.

**Steps**:

1. **Understand the pattern**: Read the relevant example and its README
2. **Write a failing test**: Use AAA structure from `PerfectTest.test.ts`
3. **Implement the feature**: Follow the pattern in the corresponding example
4. **Verify boundary cases**: Check the boundary testing section
5. **Self-review**: Run through the audit checklist before posting PR

---

## Standards Quick Reference

| Standard                    | File                       | Example That Demonstrates                                         |
| --------------------------- | -------------------------- | ----------------------------------------------------------------- |
| **Testing Excellence**      | testing-excellence.md      | `common/PerfectTest.test.ts` (all sections)                       |
| **Code Design Logic**       | code-design-logic.md       | `common/PerfectTest.test.ts` + future `laravel/PerfectAction.php` |
| **Documentation ADR**       | documentation-adr.md       | N/A (framework-independent)                                       |
| **Architecture Patterns**   | architecture-patterns.md   | Future: multi-layer examples                                      |
| **Security Hardening**      | security-hardening.md      | Future: auth, input validation examples                           |
| **Performance Scalability** | performance-scalability.md | Future: caching, query optimization                               |

---

## Example Files Roadmap

### Phase 1 (Current)

- ✅ `common/PerfectTest.test.ts` — AAA pattern with Vitest/Jest
- ✅ `common/README.md` — Audit checklist and learning guide

### Phase 2 (Planned)

- ⏳ `laravel/PerfectAction.php` — Domain action pattern
- ⏳ `laravel/PerfectMigration.php` — Database design pattern
- ⏳ `laravel/PerfectTestCase.php` — Laravel-specific test setup

### Phase 3 (Planned)

- ⏳ `vuejs/PerfectComponent.vue` — Component lifecycle + reactivity
- ⏳ `vuejs/PerfectComposable.ts` — Composition API pattern
- ⏳ `vuejs/PerfectStore.ts` — State management pattern

### Phase 4 (Planned)

- ⏳ Multi-layer examples: API request → Business Logic → Database
- ⏳ Security examples: Authentication, authorization, input validation
- ⏳ Performance examples: Caching, query optimization, lazy loading

---

## Contributing New Examples

When adding a new example:

1. **Match the standard**: Pick one standard or decision from `library/standards/` or `library/stacks/`
2. **Keep it focused**: One file, one clear pattern
3. **Write a README**: Explain every section with `// AI-REFERENCE:` comments
4. **Add audit checklist**: Include a self-check matrix
5. **Link to standards**: Reference the source standard documents
6. **Make it executable**: Example code should be runnable (with mocks if needed)

---

## Quick Audit Checklist

Use this when reviewing any code against these examples:

### For Tests

- [ ] Uses AAA structure (Arrange, Act, Assert)?
- [ ] One reason to fail per test?
- [ ] Boundary cases included?
- [ ] Async properly awaited?
- [ ] Mocks verify behavior, not implementation?

### For Business Logic (Actions/Functions)

- [ ] Guard clauses at the top?
- [ ] Early returns instead of nesting?
- [ ] Immutable inputs, new outputs?
- [ ] Clear error messages?
- [ ] No mutation of arguments?

### For Components (Vue/React)

- [ ] Props validated?
- [ ] Event handlers named clearly?
- [ ] Lifecycle hooks focused?
- [ ] Reactive state managed correctly?
- [ ] Testable sections separated?

---

## Need Help?

- **Understanding AAA**: See `common/README.md`
- **Learning a stack**: See `library/stacks/laravel/` or `library/stacks/vuejs/`
- **Detailed standards**: See `library/standards/` for full documentation
- **Project examples**: See `docs/en/examples/` or `docs/pt-br/examples/` for full end-to-end scenarios

---

**Last Updated**: 2026-05-08  
**Status**: Phase 1 Complete (Common patterns)  
**Next Review**: After Phase 2 examples are added
