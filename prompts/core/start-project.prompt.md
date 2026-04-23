---
name: "start-project"
description: "Run project kickoff onboarding with a single-message chat form and generate kickoff profile files after CONFIRM."
argument-hint: "Optional: project context (e.g., web API in TypeScript for fintech)"
agent: "start-project"
---

# /start-project

Use the `start-project` agent for this workflow.

## Execution contract

- Run single-message chat form mode by default
- Validate required fields
- Require explicit `CONFIRM` before file generation
- Generate kickoff files and return a concise handoff

## Files to create/update

- `.project/user-profile.md`
- `.project/repository-profile.md`
- `.project/kickoff-summary.md`

## Notes

- This prompt intentionally does not pin a specific model.
- This prompt is dedicated to the `start-project` agent only.
