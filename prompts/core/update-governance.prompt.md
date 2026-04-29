---
name: "update-governance"
description: "Update and improve an existing GOVERNANCE.md using repository inspection and targeted follow-up questions."
argument-hint: "Optional: focus area (roles, decision process, maintainer pathway, conflict resolution)"
agent: "governance-community"
---

# /update-governance

Use `governance-community` to improve an existing `GOVERNANCE.md`.

## Execution contract

1. Locate the existing GOVERNANCE file at repository root.
2. Read the current content and inspect repository state for evidence (maintainer list, team, contributors).
3. Ask targeted follow-up questions to resolve gaps or outdated information.
4. Update incrementally, preserving valid existing content.
5. Return:
   - final updated GOVERNANCE content
   - explicit diff summary (what changed and why)

## File discovery strategy (mandatory)

Search in this order and use the first match found:

1. `GOVERNANCE.md` (repository root)

If no file is found, report clearly and suggest running `/generate-governance` instead.

## Notes

- This prompt does not pin a specific model.
- This prompt is dedicated to `governance-community`.

## Next command (mandatory — include at end of final message)

At the end of your final message, check whether `CHANGELOG.md` already exists at the repository root.

- If it exists: tell the user to run `/update-changelog`
- If it does not exist: tell the user to run `/generate-changelog`

Format the suggestion as a clear next step, not an inline note.
