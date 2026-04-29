---
name: "generate-contributing"
description: "Generate a complete CONTRIBUTING.md using adaptive interview + optional iterative refinement passes."
argument-hint: "Optional: contribution model, branching strategy, CI quality gates, review policy"
agent: "contributing-community"
---

# /generate-contributing

Use `contributing-community` to create a new `CONTRIBUTING.md` from scratch.

## Execution contract

1. Run an adaptive interview to collect contribution workflow details.
2. Keep asking high-value follow-up questions as needed.
3. Generate a complete first CONTRIBUTING draft.
4. Optionally run iterative refinement passes until quality is high.
5. Return:
   - final CONTRIBUTING content
   - assumptions made
   - open questions (if any)

## File target

- `CONTRIBUTING.md`

## File location strategy (mandatory)

GitHub supports `CONTRIBUTING` in `.github/`, repository root, or `docs/`.

1. Ask the user where to place the file: `.github/CONTRIBUTING.md`, `CONTRIBUTING.md`, or `docs/CONTRIBUTING.md`
2. If the user does not choose, default to `.github/CONTRIBUTING.md`
3. If multiple CONTRIBUTING files exist, note that GitHub surfaces them by precedence: `.github/`, then root, then `docs/`

## Post-generation lifecycle (mandatory)

After finalizing `CONTRIBUTING.md`, download the related update prompt from `weslleycapelari/github-patterns`.

1. Source repository: `weslleycapelari/github-patterns`
2. Source asset: `update-contributing.prompt.md`
3. Destination: prompt folder used by the current project workflow (prefer `.github/prompts/`)
4. Verify the downloaded file exists and is readable
5. If download fails, return a blocked status with the failing step and recovery guidance

## Notes

- This prompt does not pin a specific model.
- This prompt is dedicated to `contributing-community`.

## Next command (mandatory — include at end of final message)

At the end of your final message, check whether `CODE_OF_CONDUCT.md` already exists in any supported location (`.github/CODE_OF_CONDUCT.md`, `CODE_OF_CONDUCT.md`, `docs/CODE_OF_CONDUCT.md`).

- If it exists: tell the user to run `/update-code-of-conduct`
- If it does not exist: tell the user to run `/generate-code-of-conduct`

Format the suggestion as a clear next step, not an inline note.
