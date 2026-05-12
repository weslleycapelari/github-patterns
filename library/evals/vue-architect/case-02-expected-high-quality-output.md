# Eval Case VA-02 — Expected High-Quality Output

## Metadata

- **agent**: `vue-architect`
- **case_id**: `VA-02`
- **status**: `draft`
- **scenario_type**: `expected_high_quality_output`
- **contract_version**: `1.0.0`

## Scenario

The requester needs a scalable Vue 3 architecture for a dashboard with reusable widgets, shared filters, optimistic UX, and resilient async behavior.

## Input (prompt payload)

```text
Propose a Vue 3 Composition API architecture for a dashboard with reusable widgets, shared filters, and robust async handling.
Risk level: safe-only.
```

## Required Output Contract

1. Scope summary.
2. Findings/action table.
3. Refactor roadmap.
4. Test checklist.
5. Delegation trace.

## PASS Criteria (all required)

1. Defines architecture with container/page, presentational widgets, and composables.
2. Distinguishes local UI state from shared domain state.
3. Includes async resilience (retry/backoff or cancellation/cleanup).
4. Includes at least 2 performance controls.
5. Includes testing guidance (composable + component interaction tests).
6. Includes intake compliance statement.
7. Includes delegation trace and merge decision for parallel findings when CRUD UI exists.
8. States security precedence on conflicts unless requester overrides.

## FAIL Conditions

- No composable strategy.
- No state boundary explanation.
- No async failure handling.
- No testing/performance plan.
- No intake handling statement.
- No delegation/merge trace for CRUD UI flow.

## Gate Decision

- `PASS` when all PASS criteria are satisfied.
- Else `FAIL`.
