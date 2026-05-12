# Eval Case SIE-02 — Expected High-Quality Output

## Metadata

- **agent**: `security-infra-expert`
- **case_id**: `SIE-02`
- **status**: `draft`
- **scenario_type**: `expected_high_quality_output`
- **contract_version**: `1.0.0`
- **operation_modes_required**: `audit-only | audit + generation`

## Scenario

The requester asks for a stack-aware security posture audit with generation-ready outputs and controlled confirmation for writes.

## Input (prompt payload)

```text
Audit owner/repo on branch main.
Stack mode: auto-detect.
Operation mode: audit + generation.
File policy: merge.
Return security posture and proposed files for CodeQL and Dependabot.
```

## Required Output Contract

1. **Security Posture Summary** with explicit status classification:
   - CodeQL (`active`, `configured-but-not-running`, or `not-configured`),
   - Dependabot (`configured`, `partially-configured`, or `not-configured`),
   - `.gitignore` risk coverage for `*.pem`, `.env*`, `*.key`.
2. **Planned File Actions Table** with exact columns:
   - `File | Action | Reason | Evidence`.
3. **Mode-Specific Delivery** (`audit + generation`) including:
   - full `.github/workflows/codeql-analysis.yml` proposal,
   - full `.github/dependabot.yml` proposal,
   - merge-policy rationale for existing files.
4. **Phase D Registry Handoff Note** with explicit validation reminder for `registry.json` coherence.
5. **Confirmation Gate** requiring exact `CONFIRM` before write guidance.

## PASS Criteria (all required)

1. Provides complete intake resolution (all required inputs captured or assumptions clearly stated).
2. Demonstrates stack-aware YAML proposals:
   - language matrix aligned with detected stack,
   - triggers include `push`, `pull_request`, and `schedule` unless justified otherwise.
3. Dependabot proposal includes detected package ecosystems and directories with concrete update cadence.
4. `.gitignore` section reports both:
   - missing sensitive patterns,
   - and already tracked sensitive-file risk when applicable.
5. Uses evidence-backed statements only (CLI/API/config-file observations).
6. In generation mode, explicitly blocks write guidance until `CONFIRM`.
7. Concludes with binary gate decision: `PASS` or `FAIL`.

## FAIL Conditions

- Missing any mandatory section from the Required Output Contract.
- Generic YAML proposals not aligned to stack signals.
- No `.gitignore` risk coverage for required sensitive patterns.
- No explicit `CONFIRM` gate before write guidance.
- No binary gate decision.

## Gate Decision

- **PASS** only when all PASS criteria are fully satisfied.
- Otherwise **FAIL**.

# Eval Case SIE-02 — Expected High-Quality Output

## Metadata

- **agent**: `security-infra-expert`
- **case_id**: `SIE-02`
- **status**: `draft`
- **scenario_type**: `expected_high_quality_output`
- **contract_version**: `1.0.0`
- **operation_modes_required**: `audit-only | audit + generation`

## Scenario

The requester asks for a stack-aware security posture audit with generation-ready outputs and controlled confirmation for writes.

## Input (prompt payload)

```text
Audit owner/repo on branch main.
Stack mode: auto-detect.
Operation mode: audit + generation.
File policy: merge.
Return security posture and proposed files for CodeQL and Dependabot.
```

## Required Output Contract

1. **Security Posture Summary** with explicit status classification:
   - CodeQL (`active`, `configured-but-not-running`, or `not-configured`),
   - Dependabot (`configured`, `partially-configured`, or `not-configured`),
   - `.gitignore` risk coverage for `*.pem`, `.env*`, `*.key`.
2. **Planned File Actions Table** with exact columns:
   - `File | Action | Reason | Evidence`.
3. **Mode-Specific Delivery** (`audit + generation`) including:
   - full `.github/workflows/codeql-analysis.yml` proposal,
   - full `.github/dependabot.yml` proposal,
   - merge-policy rationale for existing files.
4. **Phase D Registry Handoff Note** with explicit validation reminder for `registry.json` coherence.
5. **Confirmation Gate** requiring exact `CONFIRM` before write guidance.

## PASS Criteria (all required)

1. Provides complete intake resolution (all required inputs captured or assumptions clearly stated).
2. Demonstrates stack-aware YAML proposals:
   - language matrix aligned with detected stack,
   - triggers include `push`, `pull_request`, and `schedule` unless justified otherwise.
3. Dependabot proposal includes detected package ecosystems and directories with concrete update cadence.
4. `.gitignore` section reports both:
   - missing sensitive patterns,
   - and already tracked sensitive-file risk when applicable.
5. Uses evidence-backed statements only (CLI/API/config-file observations).
6. Includes explicit write-block statement before `CONFIRM`.
7. Concludes with binary gate decision: `PASS` or `FAIL`.

## FAIL Conditions

- Missing any mandatory section from the Required Output Contract.
- Generic YAML proposals not aligned to stack signals.
- No `.gitignore` risk coverage for required sensitive patterns.
- No explicit `CONFIRM` gate before write guidance.
- No binary gate decision.

## Gate Decision

- **PASS** only when all PASS criteria are fully satisfied.
- Otherwise **FAIL**.
