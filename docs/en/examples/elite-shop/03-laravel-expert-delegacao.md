# Example 03 — Nested Delegation with @laravel-expert

## Goal

Analyze product CRUD with stock variations, enforcing delegation to schema and security subagents.

## Prompt

```text
Act as @laravel-expert.
Analyze the requirement for a product CRUD with stock variations.
MUST invoke subagent @eloquent-optimizer to design the table schema
and subagent @laravel-security to ensure the checkout flow has no
authorization gaps, following docs/standards/architecture.md.
```

## Standards mapping note

In the marketplace repository, the architecture equivalent is:

- `library/standards/architecture-patterns.md`

In the target project, this standard can be materialized as `docs/standards/architecture.md` during setup.

## Expected result

- Evidence that both mandatory delegations were executed.
- List of critical and high risks (IDOR, mass assignment, payment validation, webhook).
- Incremental remediation plan by sprint.

## Acceptance criteria

- Delegations explicitly executed.
- Security decisions prevail in architectural conflicts.
- Final plan includes testable and prioritized actions.
