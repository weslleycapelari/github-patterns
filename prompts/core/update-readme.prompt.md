---
name: "update-readme"
description: "Analyze and improve existing README.md using repository evidence, targeted questions, and iterative updates."
argument-hint: "Optional: focus area (setup, architecture, contributor docs, deployment, etc.)"
agent: "readme-community"
---

# /update-readme

Use `readme-community` to update and improve an existing `README.md`.

## Execution contract

1. Locate README by supported precedence: `.github/README.md`, then `README.md`, then `docs/README.md`, and read the first match.
2. Analyze repository files to verify and enrich documentation.
3. Ask targeted questions only where uncertainty remains.
4. Apply incremental improvements (multiple passes allowed).
5. Return:
   - updated README content
   - what changed and why
   - unresolved questions

## File target

- `README.md`

## File discovery strategy (mandatory)

When updating, do not assume root location. Always search and operate on the first matching file in this order:

1. `.github/README.md`
2. `README.md`
3. `docs/README.md`

## Notes

- This prompt does not pin a specific model.
- This prompt is dedicated to `readme-community`.

## Next command (mandatory — include at end of final message)

At the end of your final message, check whether `CONTRIBUTING.md` already exists in any supported location (`.github/CONTRIBUTING.md`, `CONTRIBUTING.md`, `docs/CONTRIBUTING.md`).

- If it exists: tell the user to run `/update-contributing`
- If it does not exist: tell the user to run `/generate-contributing`

Format the suggestion as a clear next step, not an inline note.
