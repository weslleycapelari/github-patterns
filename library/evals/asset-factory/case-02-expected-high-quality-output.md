# Eval Case AF-02 — Expected High-Quality Output

## Metadata

- **agent**: `asset-factory`
- **case_id**: `AF-02`
- **status**: `draft`
- **scenario_type**: `expected_high_quality_output`
- **contract_version**: `1.1.0`

## Scenario

The requester asks to create a new prompt asset and update docs while preserving repository governance quality gates.

## Input (prompt payload)

```text
Create one new prompt artifact and update related docs. Keep repository conventions and mandatory quality gates.
```

## Required Output Contract

1. Changed files.
2. Key rationale.
3. Validation evidence.
4. Residual risks.
5. Decision log.

## PASS Criteria (all required)

1. Returns all 5 sections explicitly.
2. Includes measurable validation evidence with outcome.
3. Includes evidence of independent review step.
4. Uses objective language (no unverifiable claims).
5. Includes at least 1 residual risk and 1 follow-up action.
6. Decision log entries include actor, decision, and ISO-8601 timestamp.

## FAIL Conditions

- Missing any required section.
- No validation evidence.
- No independent review evidence.
- Ambiguous overclaims.
- No decision log.

## Gate Decision

- `PASS` only if all PASS criteria are satisfied.
- Else `FAIL`.
