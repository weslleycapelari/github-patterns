---
name: "update-security"
description: "Update and improve an existing SECURITY.md using repository inspection and targeted follow-up questions."
argument-hint: "Optional: focus area (versions table, reporting channel, SLA, disclosure policy)"
agent: "security-community"
---

# /update-security

Use `security-community` to improve an existing `SECURITY.md`.

## Execution contract

1. Locate the existing SECURITY file using supported location precedence.
2. Read the current content and inspect repository state for evidence.
3. Ask targeted follow-up questions to resolve gaps or outdated information.
4. Update incrementally, preserving valid existing content.
5. Return:
   - final updated SECURITY content
   - explicit diff summary (what changed and why)

## File discovery strategy (mandatory)

Search in this order and use the first match found:

1. `.github/SECURITY.md`
2. `SECURITY.md`
3. `docs/SECURITY.md`

If no file is found, report clearly and suggest running `/generate-security` instead.

## Notes

- This prompt does not pin a specific model.
- This prompt is dedicated to `security-community`.

## Next command (mandatory — include at end of final message)

At the end of your final message, check whether `SUPPORT.md` already exists in any supported location (`.github/SUPPORT.md`, `SUPPORT.md`, `docs/SUPPORT.md`).

- If it exists: tell the user to run `/update-support`
- If it does not exist: tell the user to run `/generate-support`

Format the suggestion as a clear next step, not an inline note.
