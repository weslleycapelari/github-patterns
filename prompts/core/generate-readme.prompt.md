---
name: "generate-readme"
description: "Generate a complete README.md using adaptive interview + optional iterative refinement passes."
argument-hint: "Optional: project context, target audience, deployment environment"
agent: "readme-community"
---

# /generate-readme

Use `readme-community` to create a new `README.md` from scratch.

## Execution contract

1. Run an adaptive interview to collect project details.
2. Keep asking high-value follow-up questions as needed.
3. Generate a complete first README draft.
4. Optionally run iterative refinement passes until quality is high.
5. Return:
   - final README content
   - assumptions made
   - open questions (if any)

## File target

- `README.md`

## Notes

- This prompt does not pin a specific model.
- This prompt is dedicated to `readme-community`.
