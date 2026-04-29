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

## File location strategy (mandatory)

GitHub supports `README` in `.github/`, repository root, or `docs/`.

1. Ask the user where to place the file: `.github/README.md`, `README.md`, or `docs/README.md`
2. If the user does not choose, default to `.github/README.md`
3. If multiple README files exist, note that GitHub surfaces them by precedence: `.github/`, then root, then `docs/`

## Post-generation lifecycle (mandatory)

After finalizing `README.md`, download the related update prompt from `weslleycapelari/github-patterns`.

1. Source repository: `weslleycapelari/github-patterns`
2. Source asset: `update-readme.prompt.md`
3. Destination: prompt folder used by the current project workflow (prefer `.github/prompts/`)
4. Verify the downloaded file exists and is readable
5. If download fails, return a blocked status with the failing step and recovery guidance

## Notes

- This prompt does not pin a specific model.
- This prompt is dedicated to `readme-community`.

## Next command (mandatory — include at end of final message)

At the end of your final message, check whether `CONTRIBUTING.md` already exists in any supported location (`.github/CONTRIBUTING.md`, `CONTRIBUTING.md`, `docs/CONTRIBUTING.md`).

- If it exists: tell the user to run `/update-contributing`
- If it does not exist: tell the user to run `/generate-contributing`

Format the suggestion as a clear next step, not an inline note.
