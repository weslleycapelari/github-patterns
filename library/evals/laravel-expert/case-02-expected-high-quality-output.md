# Eval Case LE-02 — Expected High-Quality Output

## Metadata

- **agent**: `laravel-expert`
- **case_id**: `LE-02`
- **status**: `draft`
- **scenario_type**: `expected_high_quality_output`
- **contract_version**: `1.0.0`

## Scenario

The requester needs a production-ready Laravel flow for order creation with validation, authorization, transactional writes, layered design, and tests.

## Input (prompt payload)

```text
Design a production-ready Laravel flow for creating an order with items and discount rules. Return architecture, phased remediation, and test strategy.
Risk level: safe-only.
```

## Required Output Contract

1. Scope summary.
2. Findings/remediation table.
3. Prioritized checklist.
4. Subagent handoff plan.
5. Delegation trace.

## PASS Criteria (all required)

1. Enforces controller as orchestration only; business rules moved to action/service.
2. Includes concrete validation boundary (`FormRequest` rules or equivalent).
3. Includes authorization boundary (`Policy/Gate` or equivalent).
4. Includes transaction boundary for aggregate writes.
5. Includes test strategy with at least:
   - 1 happy path
   - 1 validation failure
   - 1 authorization failure
6. Includes at least 2 non-functional controls (e.g., idempotency, race conditions, observability, indexing).
7. Includes intake compliance statement (asked intake or explicit eval assumptions).
8. Uses confirmation gate for controlled-breaking changes (even if current risk is `safe-only`).

## FAIL Conditions

- Missing validation, authorization, or transaction.
- Keeps business rules in controller layer.
- No actionable test plan.
- No intake handling statement.
- No mention of confirmation gate for controlled-breaking scenarios.

## Gate Decision

- `PASS` if all PASS criteria are present.
- Else `FAIL`.
