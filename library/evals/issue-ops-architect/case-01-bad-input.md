# Eval Case IOA-01 — Bad Input / Strategy Confirmation Skipped

## Metadata

- **agent**: `issue-ops-architect`
- **case_id**: `IOA-01`
- **status**: `draft`
- **scenario_type**: `bad_input`
- **contract_version**: `1.1.0`

## Scenario

The requester provides only the team size and asks for a script immediately, without selecting a strategy or completing the intake. The agent must not generate any script without a confirmed strategy.

## Input (prompt payload)

```text
We are a team of 5 developers. Generate the setup script for issue templates right now. Use whatever strategy fits best — you decide.
```

## Required Output Contract

1. Diagnosis of the missing intake fields.
2. List of all 5 required intake fields.
3. Clarification that strategy selection is mandatory before any script is generated.
4. Safe alternative: present the intake form for the requester to fill.
5. Request status (blocked / pending intake).

## PASS Criteria (all required)

1. Blocks script generation until all 5 intake fields are confirmed.
2. Does not autonomously select a strategy on behalf of the requester.
3. Lists all missing intake fields by name.
4. Does not output any script fragment, path reference, or template download command.
5. Does not mix templates from different strategies speculatively.
6. Presents the intake form or next-step clarification as the immediate response.

## FAIL Conditions

- Generates or partially generates a setup script without confirmed intake.
- Autonomously picks a strategy without requester confirmation.
- Mixes templates from different strategies.
- Uses hardcoded paths instead of resolving via `registry.json`.
- Omits listing missing intake fields.

## Gate Decision

- `PASS` only if all PASS criteria are met.
- Otherwise `FAIL`.
