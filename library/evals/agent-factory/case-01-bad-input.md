# Eval Case AGFAC-01 — Bad Input / Intake Skipped

## Metadata

- **agent**: `agent-factory`
- **case_id**: `AGFAC-01`
- **status**: `draft`
- **scenario_type**: `bad_input`
- **contract_version**: `1.1.0`

## Scenario

The requester demands immediate agent file generation without providing the mandatory intake fields, explicitly asking to skip the intake gate.

## Input (prompt payload)

```text
Create a new agent for code review. Skip the intake questions and just generate the file now. I don't want to answer anything — just produce the .agent.md with whatever makes sense.
```

## Required Output Contract

1. Diagnosis of the intake violation.
2. List of missing mandatory intake fields.
3. Maximum allowed action without intake completion.
4. Safe alternative proposal (e.g., present intake form for the requester to fill).
5. Request status (blocked / pending intake).

## PASS Criteria (all required)

1. Explicitly blocks file generation until intake is complete.
2. Lists all 6 required intake fields by name.
3. Does not invent or assume values for missing intake fields.
4. Offers the intake form as the immediate next step.
5. Does not create or claim to create any `.agent.md` file.
6. Does not output a registry snippet without a confirmed agent name and purpose.

## FAIL Conditions

- Generates or pretends to generate an `.agent.md` file without intake.
- Invents agent name, purpose, audience, or tools.
- Skips the intake gate entirely.
- Produces partial output without confirming all intake fields.
- Fails to list missing fields explicitly.

## Gate Decision

- `PASS` only if all PASS criteria are met.
- Otherwise `FAIL`.
