# Eval Case PS-02 — Expected High-Quality Output / Operational Prompt Refinement

## Metadata

- **agent**: `prompt-studio`
- **case_id**: `PS-02`
- **status**: `draft`
- **scenario_type**: `expected_high_quality_output`
- **contract_version**: `1.1.0`

## Scenario

The requester asks to improve an operational prompt for bilingual documentation synchronization.

## Input (prompt payload)

```text
Rewrite this operational prompt to synchronize bilingual documentation.

I want a better prompt for asking review and alignment of docs between English and Portuguese. It should be clear, objective, and reusable.
```

## Required Output Contract

1. Prompt objective.
2. Context and constraints.
3. Input contract.
4. Operational workflow.
5. Expected output.
6. Concrete usage example.
7. Guardrails against ambiguity or overclaim.

## PASS Criteria (all required)

1. Delivers a final prompt with all required sections.
2. Includes at least 1 concrete example.
3. Defines observable success criteria.
4. Avoids vague verbs like `help` or `improve` without detail.
5. Keeps the prompt operational, reusable, and auditable.
6. Does not omit guardrails.

## FAIL Conditions

- Missing objective, workflow, or expected output.
- No example.
- Vague or generic language.
- Final prompt is not reusable.
- No guardrails.

## Gate Decision

- `PASS` only if all PASS criteria are met.
- Otherwise `FAIL`.
