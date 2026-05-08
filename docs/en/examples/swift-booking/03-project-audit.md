# Example 03 — Project Audit Focused on Transactions and Race Conditions

## Goal

Audit the existing project code with emphasis on concurrency, security, and performance in reservation transactions.

## Audit context

In reservation systems, small concurrency flaws can cause severe outcomes: double confirmations, wrong availability, broken transactional integrity, and inconsistent payment flows. The audit should therefore aim for evidence, severity, and remediation — not just a generic bug list.

## Prompt

```text
Call @project-auditor.
Scan the app/database/ folder and verify that reservation transactions follow
the Security and Performance standards from the marketplace.
If a Race Condition risk is found, classify it as CRITICAL and provide a
corrective prompt.
```

## Standards mapping note

In the marketplace repository, the most relevant source standards for this step are:

- `library/standards/security-hardening.md`
- `library/standards/performance-scalability.md`

In the target project, these materials can be materialized as `docs/standards/security.md` and `docs/standards/performance.md` during setup.

## Expected inputs

Before running the audit, it is worth clarifying:

- actual code scope to audit (`app/`, `src/`, `database/`, `services/`, etc.);
- analysis priority (`security`, `performance`, or both);
- need for formal severity classification;
- expectation of corrective prompts or remediation checklist.

## Expected generated artifacts

- summary of audited scope;
- applied standards;
- findings table with severity;
- technical evidence by area or file;
- remediation checklist and, when requested, corrective prompt.

## Expected result

- Audit of `app/database/` focused on critical transactions.
- Explicit identification of concurrency risks.
- Severity classification, including `CRITICAL` for race conditions when applicable.
- Corrective prompt or actionable remediation plan.

## Execution checklist

- [ ] Confirm whether `app/database/` matches the real project layout.
- [ ] Require explicit evaluation of both security and performance.
- [ ] Request evidence for every high-severity finding.
- [ ] Verify that race conditions were treated as first-class risk.

## Common mistakes

- Auditing without a realistic project scope.
- Marking every architectural problem as `CRITICAL` without evidence.
- Ignoring concurrent reservation, confirmation, and payment flows.
- Producing findings too generic to become concrete action.

## Acceptance criteria

- Security and performance evaluated explicitly.
- Race conditions treated as first-class risk.
- Clear and actionable severities.
- Final output includes a verifiable recommendation.

## Next step

Turn findings into a prioritized backlog, corrective prompts, or remediation PRs before moving into deeper domain implementation.
