# Eval Case CS-02 — Expected High-Quality Output / Evidence-Based Memory Update

## Metadata

- **agent**: `context-steward`
- **case_id**: `CS-02`
- **status**: `draft`
- **scenario_type**: `expected_high_quality_output`
- **contract_version**: `1.1.0`

## Scenario

The requester asks to update memory notes using only observable facts from the workspace, with evidence, impact, and status.

## Input (prompt payload)

```text
Update the memory notes using only observable facts from the workspace. Record evidence, impact, and status for each note. If there is not enough evidence, mark it as pending and do not invent details.
```

## Required Output Contract

1. List of proposed or updated notes.
2. For each note: observable fact, evidence, impact, and status.
3. Memory scope: `session` or `repo`.
4. Duplicate/conflict check with existing notes.
5. Residual risks and pending items.

## PASS Criteria (all required)

1. Each note includes `fact`, `evidence`, `impact`, and `status`.
2. Specifies the memory scope for each item.
3. Does not create notes based on unsupported assumptions.
4. Explicitly checks for duplicates or conflicts.
5. Marks uncertain items as `pending` instead of inventing details.
6. Keeps notes short and actionable.

## FAIL Conditions

- Missing one of the required fields per note.
- Uses non-observable facts.
- Omits memory scope.
- Ignores duplication/conflict.
- Marks something complete without evidence.

## Gate Decision

- `PASS` only if all PASS criteria are met.
- Otherwise `FAIL`.
