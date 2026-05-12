# Eval Case RSG-01 — Bad Input / Registry-Schema Violations

## Metadata

- **agent**: `registry-schema-governor`
- **case_id**: `RSG-01`
- **status**: `draft`
- **scenario_type**: `bad_input`
- **contract_version**: `1.2.0`

## Scenario

The input contains invalid or risky registry data:

- id casing violation
- weak semver format
- unresolved path
- malformed date
- compatibility risk

## Input (prompt payload)

```json
{
  "assets": [
    {
      "id": "LaravelExpert",
      "path": "agents/laravel-expert.agent.md",
      "version": "v1",
      "lastUpdated": "2026-13-99"
    },
    {
      "id": "laravel-expert",
      "path": "agents/missing-file.agent.md",
      "version": "1.0"
    }
  ]
}
```

## Required Output Contract

1. Contract change summary.
2. Validation results.
3. Compatibility note.
4. Follow-up tasks.
5. Sync findings summary (if sync requested).
6. Section-grouped snippet guidance.
7. Manual-review list for unknowns.

## PASS Criteria (all required)

1. Detects all mandatory violations with JSON-path evidence.
2. Marks blocking violations as critical blockers in the narrative.
3. Provides corrected examples for each violation class.
4. Includes compatibility note.
5. Distinguishes what can be auto-corrected vs manual-review.

## FAIL Conditions

- Misses any mandatory violation.
- No JSON-path evidence.
- No compatibility note.
- No remediation examples.

## Gate Decision

- `PASS` only if all PASS criteria are met.
- Otherwise `FAIL`.
