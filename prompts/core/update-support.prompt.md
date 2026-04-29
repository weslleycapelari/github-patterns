---
name: "update-support"
description: "Analyze and improve existing SUPPORT.md using repository evidence, targeted questions, and iterative updates."
argument-hint: "Optional: focus area (channel routing, SLA policy, escalation, out-of-scope requests)"
agent: "support-community"
---

# /update-support

Use `support-community` to update and improve an existing `SUPPORT.md`.

## Execution contract

1. Locate SUPPORT by supported precedence: `.github/SUPPORT.md`, then `SUPPORT.md`, then `docs/SUPPORT.md`, and read the first match.
2. Analyze repository files to verify and enrich support instructions.
3. Ask targeted questions only where uncertainty remains.
4. Apply incremental improvements (multiple passes allowed).
5. Return:
   - updated SUPPORT content
   - what changed and why
   - unresolved questions

## File target

- `SUPPORT.md`

## File discovery strategy (mandatory)

When updating, do not assume root location. Always search and operate on the first matching file in this order:

1. `.github/SUPPORT.md`
2. `SUPPORT.md`
3. `docs/SUPPORT.md`

## Notes

- This prompt does not pin a specific model.
- This prompt is dedicated to `support-community`.

## Next command (mandatory — include at end of final message)

At the end of your final message, check whether `GOVERNANCE.md` already exists at the repository root.

- If it exists: tell the user to run `/update-governance`
- If it does not exist: tell the user to run `/generate-governance`

Format the suggestion as a clear next step, not an inline note.
