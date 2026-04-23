---
name: "update-readme"
description: "Analyze and improve existing README.md using repository evidence, targeted questions, and iterative updates."
argument-hint: "Optional: focus area (setup, architecture, contributor docs, deployment, etc.)"
agent: "readme-community"
---

# /update-readme

Use `readme-community` to update and improve an existing `README.md`.

## Execution contract

1. Read current `README.md`.
2. Analyze repository files to verify and enrich documentation.
3. Ask targeted questions only where uncertainty remains.
4. Apply incremental improvements (multiple passes allowed).
5. Return:
   - updated README content
   - what changed and why
   - unresolved questions

## File target

- `README.md`

## Notes

- This prompt does not pin a specific model.
- This prompt is dedicated to `readme-community`.
