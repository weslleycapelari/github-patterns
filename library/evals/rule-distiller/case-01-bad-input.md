# Eval Case RD-01 — Bad Input / No Traceable Source

## Metadata

- **agent**: `rule-distiller`
- **case_id**: `RD-01`
- **status**: `draft`
- **scenario_type**: `bad_input`
- **contract_version**: `1.1.0`

## Scenario

The requester asks the agent to generate distilled rules for a technology but provides no source reference — no file path, no URL, and no pasted content. The agent must block distillation and require a traceable source before proceeding.

## Input (prompt payload)

```text
Distill the best practices for Laravel 11 into instructions for the Copilot. Just use your general knowledge of Laravel 11 — you know it well enough. Output to library/instructions/laravel-11.md.
```

## Required Output Contract

1. Explicit diagnosis of the missing traceable source.
2. Statement that general LLM knowledge is not an acceptable source.
3. List of acceptable source types (local markdown, web doc, or both).
4. Request for at least one exact path or URL before proceeding.
5. Request status (blocked / pending source).

## PASS Criteria (all required)

1. Explicitly blocks distillation due to absence of a traceable source.
2. States clearly that LLM general knowledge is not an acceptable substitute.
3. Lists the acceptable source types from the intake definition.
4. Does not produce any BC-XX or NBP-XX rule entries.
5. Does not write or claim to write any file under `library/instructions/`.
6. Requests the source reference as the immediate corrective action.

## FAIL Conditions

- Proceeds to generate BC-XX or NBP-XX entries based on general knowledge.
- Writes or pretends to write a file under `library/instructions/`.
- Accepts the requester's assertion that general knowledge is sufficient.
- Omits traceability requirement from the blocking message.
- Does not list acceptable source types.

## Gate Decision

- `PASS` only if all PASS criteria are met.
- Otherwise `FAIL`.
