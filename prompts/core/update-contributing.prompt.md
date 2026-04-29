---
name: "update-contributing"
description: "Analyze and improve existing CONTRIBUTING.md using repository evidence, targeted questions, and iterative updates."
argument-hint: "Optional: focus area (PR flow, code standards, tests, review policy, onboarding)"
agent: "contributing-community"
---

# /update-contributing

Use `contributing-community` to update and improve an existing `CONTRIBUTING.md`.

## Execution contract

1. Read current `CONTRIBUTING.md`.
2. Analyze repository files to verify and enrich contribution instructions.
3. Ask targeted questions only where uncertainty remains.
4. Apply incremental improvements (multiple passes allowed).
5. Return:
   - updated CONTRIBUTING content
   - what changed and why
   - unresolved questions

## File target

- `CONTRIBUTING.md`

## Notes

- This prompt does not pin a specific model.
- This prompt is dedicated to `contributing-community`.
