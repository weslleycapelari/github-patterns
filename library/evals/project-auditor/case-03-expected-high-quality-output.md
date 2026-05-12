# Eval Case PA-03 — Expected High-Quality Output

## Metadata

- **agent**: `project-auditor`
- **case_id**: `PA-03`
- **status**: `draft`
- **scenario_type**: `expected_high_quality_output`
- **contract_version**: `1.0.0`
- **severity_model_required**: `SECURITY BREACH | CRITICAL | WARNING | INFO`

## Scenario

The requester expects a production-grade audit output for a small repository surface with clear evidence, severity discipline, and actionable remediation.

## Input (prompt payload)

```text
Audit the folder library/examples/ and evaluate architecture, test quality, security posture, and documentation coherence.
Return a detailed markdown report with remediation priorities and file evidence.
Severity threshold: all findings.
```

## Required Output Contract

1. **Audit Scope Summary** with audited paths and assumptions.
2. **Standards Applied** citing relevant files in `library/standards/`.
3. **Findings Table** with exact columns:
   - `ID | Severity | File | Standard | Finding | Recommended Action`
4. **Remediation Checklist** grouped by execution order:
   - immediate (0-2 days),
   - short-term (3-7 days),
   - medium-term (8-30 days).
5. **Optional Copilot Prompts** section only if asked.
6. **Reference Baseline Mapping**:
   - every non-INFO finding must include a baseline comparison to `library/examples/` when a pattern baseline is applicable,
   - or a concise “not applicable” justification when no baseline applies.

## PASS Criteria (all required)

1. Includes all mandatory output sections in the required order.
2. Uses only the required severity model.
3. Provides at least 4 findings with balanced coverage across:
   - architecture,
   - testing,
   - security,
   - documentation.
4. Includes at least 1 finding classified as `INFO` and at least 1 as `WARNING` or higher.
5. Includes at least 4 actionable remediation items with clear owner suggestion and expected outcome.
6. Explicitly states whether any standards-governance drift exists.
7. Produces a binary gate statement: `PASS` or `FAIL`.

## FAIL Conditions

- Missing one or more mandatory output sections.
- Missing file-level evidence in any finding.
- Missing standard reference in any finding.
- Missing baseline comparison to `library/examples/` patterns when applicable.
- Missing execution-priority remediation checklist.
- No explicit binary gate statement.

## Gate Decision

- **PASS** only if every PASS criterion is met.
- Otherwise **FAIL**.

# Eval Case PA-03 — Expected High-Quality Output

## Metadata

- **agent**: `project-auditor`
- **case_id**: `PA-03`
- **status**: `draft`
- **scenario_type**: `expected_high_quality_output`
- **contract_version**: `1.0.0`
- **severity_model_required**: `SECURITY BREACH | CRITICAL | WARNING | INFO`

## Scenario

The requester asks for a focused audit on quality-critical areas and expects a production-grade report suitable for direct triage.

## Input (prompt payload)

```text
Audit the folder library/examples/ and evaluate architecture, test quality, security posture, and documentation coherence.
Return a detailed markdown report with remediation priorities and file evidence.
Severity threshold: all findings.
```

## Required Output Contract

1. **Audit Scope Summary** with audited paths and assumptions.
2. **Standards Applied** citing relevant files in `library/standards/`.
3. **Findings Table** with exact columns:
   - `ID | Severity | File | Standard | Finding | Recommended Action`
4. **Remediation Checklist** grouped by execution order:
   - immediate (0-2 days),
   - short-term (3-7 days),
   - medium-term (8-30 days).
5. **Optional Copilot Prompts** section (only if user asked for prompts).
6. **Evidence Discipline**:
   - each finding linked to concrete file evidence,
   - each finding linked to one standard reference,
   - and at least one finding mapped to a `library/examples/` reference baseline.

## PASS Criteria (all required)

1. Includes all mandatory output sections in the required order.
2. Uses only the required severity model.
3. Provides at least 6 findings with balanced coverage across:
   - architecture,
   - testing,
   - security,
   - documentation.
4. Includes at least 1 finding classified as `INFO` and at least 1 as `WARNING` or higher.
5. Includes at least 4 actionable remediation items with clear owner suggestion and expected outcome.
6. Explicitly states whether any standards-governance drift exists.
7. Produces a binary gate statement: `PASS` or `FAIL`.

## FAIL Conditions

- Missing one or more mandatory output sections.
- Missing file-level evidence in any finding.
- Missing standard reference in any finding.
- Missing baseline comparison to `library/examples/` patterns.
- Missing execution-priority remediation checklist.
- No explicit binary gate statement.

## Gate Decision

- **PASS** only if every PASS criterion is met.
- Otherwise **FAIL**.
