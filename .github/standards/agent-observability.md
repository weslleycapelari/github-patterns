# Agent Observability Standard

## Purpose

Define how agent workflows produce auditable evidence for decisions and quality.

## Required Signals

For each non-trivial task, capture:

- `taskId`
- `artifactType`
- `subagentsInvoked`
- `reviewFindingsCount` by severity
- `validationChecks`
- `finalDecision`

## Decision Log Format

```json
{
  "taskId": "string",
  "timestamp": "ISO-8601",
  "subagent": "string",
  "decision": "string",
  "rationale": "string",
  "evidence": ["optional references"]
}
```

## Rules

- Do not claim review completion without evidence.
- Keep a concise decision trail for major changes.
- Include unresolved risks in final report.
- Record when confirmation gates were triggered and approved.
