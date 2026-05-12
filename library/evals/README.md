# Agent Evals — Final Quality Gate

## Objective

Provide a deterministic, auditable evaluation gate for agent updates.

This folder contains intentionally flawed artifacts used to measure whether an agent can detect critical violations with correct severity and evidence.

For `project-auditor`, the goal is simple: detect all critical findings in `case-01-bad-code.php` before any agent update is accepted.

---

## Structure

```text
library/evals/
├── README.md
├── agent-factory/
├── repo-architect/
├── issue-ops-architect/
├── project-auditor/
│   └── case-01-bad-code.php
├── security-infra-expert/
├── laravel-expert/
├── vue-architect/
├── asset-factory/
├── asset-review-board/
├── registry-schema-governor/
├── documentation-steward/
├── prompt-studio/
├── rule-distiller/
└── context-steward/
```

- `README.md`: gate protocol and scoring.
- `project-auditor/case-01-bad-code.php`: controlled test case with 5 known critical violations.
- Other agent folders: gradually moving from reserved slots to active fixtures.

---

## Coverage Matrix

| agent                    | case_count | enforced_case_count | draft_case_count | status |
| ------------------------ | ---------- | ------------------- | ---------------- | ------ |
| project-auditor          | 3          | 1                   | 2                | draft  |
| security-infra-expert    | 2          | 0                   | 2                | draft  |
| laravel-expert           | 2          | 0                   | 2                | draft  |
| vue-architect            | 2          | 0                   | 2                | draft  |
| registry-schema-governor | 2          | 0                   | 2                | draft  |
| asset-factory            | 2          | 0                   | 2                | draft  |

Status policy:

- `draft`: case exists and is ready for trial runs, but not yet enforced as release gate.
- `active`: case is enforced as mandatory gate for related agent updates.
- `mixed`: not used as a table value; captured via `enforced_case_count` vs `draft_case_count`.

---

## Quick Start

1. Open Copilot Chat and choose the **Project Auditor** agent mode.
2. Run an audit targeting:
   - Scope: `library/evals/project-auditor/case-01-bad-code.php`
   - Priority focus: `security, architecture, code design, performance`
   - Output: `detailed markdown report`
   - Severity threshold: `critical only`
   - Copilot-ready prompts: `yes` (optional)
3. Compare the findings against the expected table below.
4. Apply the scoring rubric.
5. Record the result in your release note / PR checklist.

Recommended evaluation command style in chat:

> "Audit `library/evals/project-auditor/case-01-bad-code.php` and return only critical findings with file evidence and remediation guidance."

---

## Expected Findings — case-01

| ID    | Expected Severity | Violation Type                                     | Evidence Hint                                                             |
| ----- | ----------------- | -------------------------------------------------- | ------------------------------------------------------------------------- |
| PA-01 | CRITICAL          | Hardcoded secret in source code                    | `FAKE_PAYMENT_GATEWAY_KEY`                                                |
| PA-02 | CRITICAL          | SQL injection via raw concatenated query           | `FakeDB::selectRaw("SELECT * FROM users WHERE email = '" . $email . "'")` |
| PA-03 | CRITICAL          | N+1 query pattern                                  | `FakeOrderRepo::all()` + loop calling `FakeDB::selectRaw(...)` per order  |
| PA-04 | CRITICAL          | Business logic inside controller                   | `if ($subtotal > 1000) { $discountRate = 0.20; }`                         |
| PA-05 | CRITICAL          | Missing authorization check on sensitive operation | No authorization/policy/gate check before admin action                    |

Expected total: **5 / 5 critical findings**.

---

## Scoring Rubric (Pass/Fail)

Compute:

- `detected = number of expected findings correctly identified`
- `score = (detected / 5) * 100`

### Pass

- `score = 100` (all 5 findings detected), and
- no expected critical/security finding is downgraded below `CRITICAL`.

### Fail

- any missed expected finding (`score < 100`), or
- any severity downgrade below required level, or
- findings without file-level evidence.

Gate decision is binary: **PASS** or **FAIL**.

---

## Governance Note

This eval is a mandatory final gate for marketplace quality.

**Every marketplace agent update must pass its corresponding eval gate before merge/release.**

If this gate fails, the update is blocked until detection quality is restored.

---

## Quality Gate Policy for Agent Updates

For any agent update in the marketplace:

1. Add or update at least one eval case in `library/evals/<agent-id>/`.
2. Run the target agent against its eval cases.
3. Capture output evidence in the PR (findings summary and score).
4. Mark gate result explicitly as `PASS` or `FAIL`.
5. Block merge when gate result is `FAIL`.

### Minimum evidence per run

Every eval execution should include at least:

- `case_id`
- `agent`
- `runner`
- `timestamp_utc` (ISO 8601)
- `gate_result` (`PASS` or `FAIL`)
- raw output or equivalent evidence snippet

---

## Safety Note

All secrets in eval artifacts are intentionally fake placeholders for testing only.
Never replace them with real credentials.
