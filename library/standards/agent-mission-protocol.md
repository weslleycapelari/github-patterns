# Agent Mission Protocol

## Objective

Enforce a deterministic delegation protocol where every nested delegation creates a mission artifact before invoking a child agent.

This standard defines:

- mandatory Mission File creation for every delegation hop;
- required mission contract fields and completion rules;
- delegation gate conditions (what must exist before handoff);
- verification and traceability requirements for parent agents.

## Non-Negotiable Principles

1. No parent agent may delegate work without first creating a Mission File at `.github/MISSIONS/task-id.md`.
2. Every Mission File must include all required fields with non-empty values.
3. Nested delegations must create new Mission Files; reusing parent files is forbidden.
4. The parent agent remains accountable for validation, merge quality, and final output.
5. Delegation without mission traceability is a governance violation.
6. Missing Mission File blocks delegation until corrected.

## Mandatory Mission File Fields

Every mission file MUST include these exact field names:

- `Parent_Agent`
- `Child_Agent`
- `Mission_Objective`
- `Context_Links`
- `Success_Criteria`
- `Result_Payload`

If any field is missing or empty, the mission is invalid.

## Mission File Path and Naming

- Path: `.github/MISSIONS/task-id.md`
- `task-id` must be kebab-case, unique per delegation event, and meaningful to scope.
- Recommended pattern: `<parent-agent>-to-<child-agent>-<scope>-<timestamp-or-seq>`

Examples:

- `.github/MISSIONS/laravel-expert-to-laravel-security-order-update-001.md`
- `.github/MISSIONS/repo-architect-to-issue-ops-templates-20260511.md`

## Required Workflow Gate

Before any delegation, the parent agent must execute this gate:

1. Create the Mission File at `.github/MISSIONS/task-id.md`.
2. Populate all mandatory fields.
3. Validate fields are non-empty and scope-specific.
4. Include mission file path in the handoff payload.
5. Only then invoke the child agent.

If gate validation fails, delegation must stop and return a blocker report.

## Mission File Template

```text
# Mission File: <task-id>

Parent_Agent: <agent-name>
Child_Agent: <agent-name>
Mission_Objective: <single objective statement>
Context_Links:
  - <file/path/or/url>
  - <file/path/or/url>
Success_Criteria:
  - <testable criterion 1>
  - <testable criterion 2>
Result_Payload:
  - <expected output artifact or structure>
  - <required evidence/log format>
```

## Parent Agent Responsibilities

The parent agent must:

- define constrained, testable mission objective;
- provide minimal and sufficient context links;
- define measurable success criteria;
- validate child payload against `Result_Payload`;
- keep a decision trace for acceptance, correction, or escalation.

## Child Agent Responsibilities

The child agent must:

- operate only within mission scope;
- return payload that matches `Result_Payload`;
- explicitly report blockers and unresolved ambiguities;
- avoid silent scope expansion.

## Verification Checklist

Before final response, verify:

1. Did every delegation create `.github/MISSIONS/task-id.md` first?
2. Do all Mission Files contain all mandatory fields?
3. Are success criteria testable and objective?
4. Does child output satisfy `Result_Payload` contract?
5. Are nested delegations individually documented with new mission files?
6. Is the parent decision trail complete and auditable?

## Enforcement

- Delegation without Mission File is invalid delegation.
- Mission files missing required fields are invalid artifacts.
- Repeated violations require escalation to repository governance review.
