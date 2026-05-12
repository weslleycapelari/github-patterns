# Eval Case PA-02 — Bad Input / Anti-Pattern Detection

## Metadata

- **agent**: `project-auditor`
- **case_id**: `PA-02`
- **status**: `draft`
- **scenario_type**: `bad_input`
- **contract_version**: `1.0.0`
- **severity_model_required**: `SECURITY BREACH | CRITICAL | WARNING | INFO`

## Scenario

The requester gives an underspecified audit brief. The correct response must block on intake or explicitly label the missing context as a limitation instead of pretending to have enough information.

## Input (prompt payload)

```text
Quickly check this repo and tell me if code quality is okay.
No need for too much detail.
```

## Required Output Contract

1. **Audit Scope Summary** including whether intake is complete.
2. **Standards Applied** listing at least 4 files from `library/standards/`.
3. **Findings Table** with exact columns:
   - `ID | Severity | File | Standard | Finding | Recommended Action`
4. **Remediation Checklist** ordered by severity and implementation priority.
5. **Optional Copilot Prompts** only if explicitly requested.
6. **Reference Baseline Mapping** comparing at least one file to a `library/examples/` baseline.

## PASS Criteria (all required)

1. Uses only the required severity taxonomy exactly:
   - `SECURITY BREACH`, `CRITICAL`, `WARNING`, `INFO`.
2. Either:
   - explicitly states that intake is incomplete and blocks on it, or
   - clearly states the assumption set and why the eval fixture permits it.
3. Includes at least 5 findings, each with file-level evidence and one matching standard reference.
4. Includes at least 1 reference-baseline comparison to `library/examples/`.
5. Findings are ordered from highest to lowest severity.
6. Contains no unverifiable claims (for example, no claim of test execution without evidence).

## FAIL Conditions

- Uses any severity outside the required taxonomy.
- Fails to address the incomplete intake condition.
- Provides findings without file-level evidence.
- Does not cite `library/standards/` for each finding.
- Does not reference any baseline from `library/examples/`.
- Returns fewer than 5 findings.
- Outputs generic advice without actionable remediation.

## Gate Decision

- **PASS** only if all PASS criteria are satisfied.
- Otherwise **FAIL**.

# Eval Case PA-02 — Bad Input / Anti-Pattern Detection

## Metadata

- **agent**: `project-auditor`
- **case_id**: `PA-02`
- **status**: `draft`
- **scenario_type**: `bad_input`
- **contract_version**: `1.0.0`
- **severity_model_required**: `SECURITY BREACH | CRITICAL | WARNING | INFO`

## Scenario

The requester asks for a repository audit but provides a weak and ambiguous brief that tends to produce shallow output, missing evidence, and non-actionable findings.

## Input (prompt payload)

```text
Quickly check this repo and tell me if code quality is okay.
No need for too much detail. Focus only on what you think matters.
```

## Required Output Contract

1. **Audit Scope Summary** with explicit assumptions because intake details are incomplete.
2. **Standards Applied** listing at least 4 files from `library/standards/`.
3. **Findings Table** with exact columns:
   - `ID | Severity | File | Standard | Finding | Recommended Action`
4. **Remediation Checklist** ordered by severity and implementation priority.
5. **Optional Copilot Prompts** section only if explicitly requested by input.
6. **Reference Baseline Mapping**:
   - At least 1 comparison to `library/examples/laravel/PerfectAction.php` or
   - At least 1 comparison to `library/examples/vuejs/PerfectComponent.vue` or
   - At least 1 comparison to `library/examples/common/PerfectTest.test.ts`.

## PASS Criteria (all required)

1. Uses the mandatory severity taxonomy exactly:
   - `SECURITY BREACH`, `CRITICAL`, `WARNING`, `INFO`.
2. Includes at least 5 findings, with:
   - at least 1 `CRITICAL` or `SECURITY BREACH`,
   - and at least 1 `WARNING`.
3. Every finding contains measurable file evidence:
   - concrete file path and
   - concrete code/config/documentation fragment reference.
4. Every finding cites one matching standard file in `library/standards/`.
5. Includes explicit comparison against `library/examples/` reference patterns.
6. Findings are ordered from highest to lowest severity.
7. Contains no unverifiable claims (for example, no claim of test execution without evidence).

## FAIL Conditions

- Uses any severity outside the required taxonomy.
- Provides findings without file-level evidence.
- Does not cite `library/standards/` for each finding.
- Does not reference any baseline from `library/examples/`.
- Returns fewer than 5 findings.
- Outputs generic advice without actionable remediation.

## Gate Decision

- **PASS** only if all PASS criteria are satisfied.
- Otherwise **FAIL**.
