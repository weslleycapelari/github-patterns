# Eval Case RD-02 — Expected High-Quality Output / Full Intake Provided

## Metadata

- **agent**: `rule-distiller`
- **case_id**: `RD-02`
- **status**: `draft`
- **scenario_type**: `expected_high_quality_output`
- **contract_version**: `1.1.0`

## Scenario

The requester provides all mandatory intake fields, including a traceable source and explicit CONFIRM gate. The agent must produce a structured preview with separated BC and NBP sections, operational checklist, and full source traceability, then write the file only after a separate explicit `CONFIRM` message.

## Input (prompt payload)

```text
Source type: web doc
Source reference: https://laravel.com/docs/11.x/releases
Target technology and version: Laravel 11
Output target: new file at library/instructions/laravel-11.md
Strictness level: strict
Migration checklist: yes
Output language preference: English
May I create/modify files after preview: only after explicit CONFIRM

Please distill the release notes into Copilot instructions.
```

## Required Output Contract

1. After an explicit `CONFIRM`, a complete instruction file at `library/instructions/laravel-11.md` containing:
   - **Purpose** section (one paragraph).
   - **Breaking Changes** section with at least 2 entries, each containing: `BC-XX` ID, Impact, Required Action (imperative verb), Verification step.
   - **New Best Practices** section with at least 2 entries, each containing: `NBP-XX` ID, Benefit, Adoption guidance (imperative verb), Verification step.
   - **Operational Checklist** (migration checklist, since requested).
   - **Source Traceability** section with exact URL(s) and retrieval date.
2. Preview shown first, and file creation blocked until a separate explicit `CONFIRM` message is received.
3. Decision log with actor, decision, and ISO-8601 timestamp.

## PASS Criteria (all required)

1. File is created at the exact path `library/instructions/laravel-11.md` only after explicit `CONFIRM`.
2. Breaking Changes and New Best Practices are in separate sections (not mixed). When output language preference is English, all section titles must be in English — section must be titled "New Best Practices" (not "Novas Boas Práticas").
3. Every BC-XX entry has: ID, Impact, Required Action with imperative verb, Verification.
4. Every NBP-XX entry has: ID, Benefit, Adoption guidance with imperative verb, Verification.
5. Operational Checklist is present (migration format) with at least 3 items.
6. Source Traceability includes the exact URL provided and a retrieval date.
7. No rule entry is generated from LLM general knowledge (all rules traceable to source).
8. Decision log has at least 1 entry with actor, decision, and ISO-8601 timestamp.
9. Preview is shown first and file write is executed only after a separate explicit `CONFIRM`.

## FAIL Conditions

- BC and NBP entries are mixed in the same section.
- Section titles do not match the requested output language (e.g., "Novas Boas Práticas" used when English output was requested).
- Any rule entry lacks an imperative verb in its action field.
- Source Traceability section is absent or omits the source URL.
- Operational Checklist is missing when migration checklist was requested.
- File written to a path other than `library/instructions/laravel-11.md`.
- No decision log.
- File created before preview, or created without a separate explicit `CONFIRM` after preview.

## Gate Decision

- `PASS` only if all PASS criteria are satisfied.
- Otherwise `FAIL`.
