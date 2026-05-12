# Eval Case PS-01 — Bad Input / Vague Prompt Request

## Metadata

- **agent**: `prompt-studio`
- **case_id**: `PS-01`
- **status**: `draft`
- **scenario_type**: `bad_input`
- **contract_version**: `1.1.0`

## Scenario

The requester provides a vague prompt without objective, contract, or success criteria.

## Input (prompt payload)

```text
Improve this prompt for me. Make it good and ready to use without needing any more details.
```

## Required Output Contract

1. Diagnosis of what is missing from the prompt.
2. List of minimum missing fields.
3. Safe structure suggestion for the prompt.
4. Clarification questions or minimal assumptions.
5. Observable success criteria.

## PASS Criteria (all required)

1. Identifies missing objective, context, and success criteria.
2. Does not invent an objective not provided.
3. Does not deliver a final prompt without signaling critical gaps.
4. Proposes at least 1 clarification question or safe fallback.
5. Uses objective and auditable language.

## FAIL Conditions

- Rewrites the prompt as if the intent were clear.
- Assumes objective/context without basis.
- Omits success criteria.
- Fails to identify the main gaps.
- Responds generically and non-operationally.

## Gate Decision

- `PASS` only if all PASS criteria are met.
- Otherwise `FAIL`.
