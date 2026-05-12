# Eval Case RSG-02 — Expected High-Quality Output

## Metadata

- **agent**: `registry-schema-governor`
- **case_id**: `RSG-02`
- **status**: `draft`
- **scenario_type**: `expected_high_quality_output`
- **contract_version**: `1.2.0`

## Scenario

The requester needs an operational governance flow for `registry.json` and `registry.schema.json`, including sync and path drift handling.

## Input (prompt payload)

```text
Provide an operational protocol for updating registry and schema with validation, sync parsing, and grouped JSON snippets.
```

## Required Output Contract

1. Contract changes summary.
2. Validation results.
3. Compatibility note.
4. Follow-up tasks.
5. Sync findings summary (`registered_count`, `scanned_count`, `unregistered_count`).
6. Ready-to-paste snippets grouped by section.
7. Manual-review list for unknown assets.

## PASS Criteria (all required)

1. Defines at least 5 sequential validation steps including syntax, schema validation, path checks, and compatibility impact.
2. Includes `--sync` deterministic parsing guidance for `UNREGISTERED|...` records.
3. Groups snippet output by valid section targets.
4. Sends unknown classifications to manual-review bucket.
5. Produces explicit binary gate outcome (`PASS`/`FAIL`).
6. Includes rollback/safe-revert note.

## FAIL Conditions

- Missing `--sync` parse guidance.
- Missing grouped snippet strategy.
- Missing manual-review handling for unknown.
- No binary gate decision.
- No rollback/safety note.

## Gate Decision

- `PASS` only if all PASS criteria are present.
- Else `FAIL`.
