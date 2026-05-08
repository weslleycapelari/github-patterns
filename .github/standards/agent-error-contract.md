# Agent Error Contract

## Purpose

Define a standard error contract for all repository AI agents and subagents.

## Error Envelope

All agent failures should be reported using this structure:

```json
{
  "status": "error",
  "errorCode": "string",
  "message": "string",
  "stage": "discover|develop|review|improve|validate",
  "recoverable": true,
  "recommendedAction": "string",
  "evidence": ["optional references"]
}
```

## Rules

- Use deterministic error codes (kebab-case).
- Include pipeline stage where failure occurred.
- Mark recoverability explicitly.
- Include one recommended action.
- Do not hide validation failures.

## Escalation

- First failure: retry once with corrected scope.
- Second failure: escalate with full error envelope and blocked task summary.
- Never continue silently after unresolved critical errors.
