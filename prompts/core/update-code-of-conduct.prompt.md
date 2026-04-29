---
name: "update-code-of-conduct"
description: "Analyze and improve existing CODE_OF_CONDUCT.md using repository evidence, targeted questions, and iterative updates."
argument-hint: "Optional: focus area (reporting flow, moderation model, enforcement language, scope)"
agent: "code-of-conduct-community"
---

# /update-code-of-conduct

Use `code-of-conduct-community` to update and improve an existing `CODE_OF_CONDUCT.md`.

## Execution contract

1. Locate CODE_OF_CONDUCT by supported precedence: `.github/CODE_OF_CONDUCT.md`, then `CODE_OF_CONDUCT.md`, then `docs/CODE_OF_CONDUCT.md`, and read the first match.
2. Analyze repository files to verify and enrich conduct policy guidance.
3. Ask targeted questions only where uncertainty remains.
4. Apply incremental improvements (multiple passes allowed).
5. Return:
   - updated CODE_OF_CONDUCT content
   - what changed and why
   - unresolved questions

## File target

- `CODE_OF_CONDUCT.md`

## File discovery strategy (mandatory)

When updating, do not assume root location. Always search and operate on the first matching file in this order:

1. `.github/CODE_OF_CONDUCT.md`
2. `CODE_OF_CONDUCT.md`
3. `docs/CODE_OF_CONDUCT.md`

## Notes

- This prompt does not pin a specific model.
- This prompt is dedicated to `code-of-conduct-community`.

## Next command (mandatory — include at end of final message)

At the end of your final message, check whether `SECURITY.md` already exists in any supported location (`.github/SECURITY.md`, `SECURITY.md`, `docs/SECURITY.md`).

- If it exists: tell the user to run `/update-security`
- If it does not exist: tell the user to run `/generate-security`

Format the suggestion as a clear next step, not an inline note.
