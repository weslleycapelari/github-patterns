---
name: "update-contributing"
description: "Analyze and improve existing CONTRIBUTING.md using repository evidence, targeted questions, and iterative updates."
argument-hint: "Optional: focus area (PR flow, code standards, tests, review policy, onboarding)"
agent: "contributing-community"
---

# /update-contributing

Use `contributing-community` to update and improve an existing `CONTRIBUTING.md`.

## Execution contract

1. Locate CONTRIBUTING by supported precedence: `.github/CONTRIBUTING.md`, then `CONTRIBUTING.md`, then `docs/CONTRIBUTING.md`, and read the first match.
2. Analyze repository files to verify and enrich contribution instructions.
3. Ask targeted questions only where uncertainty remains.
4. Apply incremental improvements (multiple passes allowed).
5. Return:
   - updated CONTRIBUTING content
   - what changed and why
   - unresolved questions

## File target

- `CONTRIBUTING.md`

## File discovery strategy (mandatory)

When updating, do not assume root location. Always search and operate on the first matching file in this order:

1. `.github/CONTRIBUTING.md`
2. `CONTRIBUTING.md`
3. `docs/CONTRIBUTING.md`

## Notes

- This prompt does not pin a specific model.
- This prompt is dedicated to `contributing-community`.

## Next command (mandatory — include at end of final message)

At the end of your final message, check whether `CODE_OF_CONDUCT.md` already exists in any supported location (`.github/CODE_OF_CONDUCT.md`, `CODE_OF_CONDUCT.md`, `docs/CODE_OF_CONDUCT.md`).

- If it exists: tell the user to run `/update-code-of-conduct`
- If it does not exist: tell the user to run `/generate-code-of-conduct`

Format the suggestion as a clear next step, not an inline note.
