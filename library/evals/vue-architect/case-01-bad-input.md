# Eval Case VA-01 — Bad Input / Anti-Pattern Detection

## Metadata

- **agent**: `vue-architect`
- **case_id**: `VA-01`
- **status**: `draft`
- **scenario_type**: `bad_input`
- **contract_version**: `1.0.0`

## Scenario

A Vue component includes critical architecture anti-patterns:

- prop mutation
- side effects inside computed
- mixed responsibilities (UI + domain + API)
- weak async/error handling

## Input (prompt payload)

```text
Review this Vue component and identify critical architecture issues.

<script setup>
const props = defineProps({ user: Object })
const total = computed(() => {
  props.user.score += 1
  return props.user.orders.reduce((a, b) => a + b.price, 0)
})
function save() {
  fetch('/api/user/' + props.user.id, { method: 'POST', body: JSON.stringify(props.user) })
}
</script>
```

## Required Output Contract

1. Scope summary.
2. Findings table with evidence and severity.
3. Refactor roadmap.
4. Test and validation checklist.
5. Delegation trace.

## PASS Criteria (all required)

1. Detects all mandatory issues:
   - prop mutation
   - side effects in computed
   - weak async/error handling
   - poor separation of concerns
2. Uses contract-compatible severities (`CRITICAL`, `WARNING`, `INFO`).
3. Recommends at least 3 Vue-native remediations.
4. Includes intake compliance statement (asked intake or explicit eval assumptions).
5. If CRUD UI flow is implied, includes delegation trace to:
   - `@vue-reactivity-optimizer`
   - `@vue-security-guard`
     (or explicit blocker if unavailable).

## FAIL Conditions

- Misses prop mutation or computed side-effect.
- Uses non-contract severity taxonomy as final model.
- Provides generic advice without Vue-specific mapping.
- No intake handling statement.
- No CRUD UI delegation trace (or blocker rationale).

## Gate Decision

- `PASS` only if all PASS criteria are met.
- Otherwise `FAIL`.
