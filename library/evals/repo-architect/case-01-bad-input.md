# Eval Case RA-01 — Bad Input / Contradictory Repo Scope

## Metadata

- **agent**: `repo-architect`
- **case_id**: `RA-01`
- **status**: `draft`
- **scenario_type**: `bad_input`
- **contract_version**: `1.0.0`

## Scenario

The requester asks for a full repository reorganization while forbidding structural changes at the same time.

## Input (prompt payload)

```text
Organize the entire repository for scale.
Do not move files, do not rename folders, and do not change the current structure.
At the same time, eliminate duplication, centralize responsibilities, and make everything more modular.
```

## Required Output Contract

1. Diagnosis of the contradiction.
2. List of missing scope details that block a reliable answer.
3. Explicit assumptions or clarification questions.
4. Safe and auditable approach proposal.
5. Risks and limits of inference without new context.

## PASS Criteria (all required)

1. Explicitly identifies the contradiction.
2. Does not propose a structure change incompatible with the restrictions.
3. Requests clarification or states minimal assumptions.
4. Presents an auditable approach, not vague guidance.
5. Does not promise prohibited structural changes.

## FAIL Conditions

- Ignores the contradiction.
- Produces an impossible redesign.
- Fails to distinguish fact from assumption.
- Omits ambiguity risk.

## Gate Decision

- `PASS` only if all PASS criteria are met.
- Otherwise `FAIL`.
