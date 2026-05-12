# Eval Case DS-02 — Expected High-Quality Output / Cross-Locale Documentation Sync

## Metadata

- **agent**: `documentation-steward`
- **case_id**: `DS-02`
- **status**: `draft`
- **scenario_type**: `expected_high_quality_output`
- **contract_version**: `1.1.0`

## Scenario

The requester asks to align docs with decision points, fix links, and include a sync note.

## Input (prompt payload)

```text
Align docs/en/zero-inertia-command.md, docs/pt-br/zero-inertia-command.md, and the links referenced in docs/en/registry.md / docs/pt-br/registry.md. Fix divergent decision points, validate links, and include a sync note.
```

## Required Output Contract

1. Differences found between the documents.
2. Decision points aligned.
3. Links corrected or validated.
4. Sync note with status.
5. Residual risks and pending work, if any.

## PASS Criteria (all required)

1. Explicitly compares `docs/en` and `docs/pt-br`.
2. Lists at least 2 verified or corrected links.
3. Identifies divergent decision points and how they were aligned.
4. Includes a sync note with objective status (`done` or `pending`).
5. Does not omit residual divergences, if any.
6. Keeps traceability for each proposed change.

## FAIL Conditions

- Does not reference both languages.
- Does not validate links.
- Does not mention decision points.
- Missing sync note or status.
- Declares completion without evidence.

## Gate Decision

- `PASS` only if all PASS criteria are met.
- Otherwise `FAIL`.
