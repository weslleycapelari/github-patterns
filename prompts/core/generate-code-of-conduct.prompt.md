---
name: "generate-code-of-conduct"
description: "Generate a complete CODE_OF_CONDUCT.md using adaptive interview + optional iterative refinement passes."
argument-hint: "Optional: moderation policy, reporting channel, enforcement model, response expectations"
agent: "code-of-conduct-community"
---

# /generate-code-of-conduct

Use `code-of-conduct-community` to create a new `CODE_OF_CONDUCT.md` from scratch.

## Execution contract

1. Run an adaptive interview to collect policy and enforcement details.
2. Keep asking high-value follow-up questions as needed.
3. Generate a complete first CODE_OF_CONDUCT draft.
4. Optionally run iterative refinement passes until quality is high.
5. Return:
   - final CODE_OF_CONDUCT content
   - assumptions made
   - open questions (if any)

## File target

- `CODE_OF_CONDUCT.md`

## File location strategy (mandatory)

GitHub supports `CODE_OF_CONDUCT` in `.github/`, repository root, or `docs/`.

1. Ask the user where to place the file: `.github/CODE_OF_CONDUCT.md`, `CODE_OF_CONDUCT.md`, or `docs/CODE_OF_CONDUCT.md`
2. If the user does not choose, default to `.github/CODE_OF_CONDUCT.md`
3. If multiple code of conduct files exist, note that GitHub surfaces them by precedence: `.github/`, then root, then `docs/`

## Post-generation lifecycle (mandatory)

After finalizing `CODE_OF_CONDUCT.md`, download the related update prompt from `weslleycapelari/github-patterns`.

1. Source repository: `weslleycapelari/github-patterns`
2. Source asset: `update-code-of-conduct.prompt.md`
3. Destination: prompt folder used by the current project workflow (prefer `.github/prompts/`)
4. Verify the downloaded file exists and is readable
5. If download fails, return a blocked status with the failing step and recovery guidance

## Notes

- This prompt does not pin a specific model.
- This prompt is dedicated to `code-of-conduct-community`.

## Next command (mandatory — include at end of final message)

At the end of your final message, check whether `SECURITY.md` already exists in any supported location (`.github/SECURITY.md`, `SECURITY.md`, `docs/SECURITY.md`).

- If it exists: tell the user to run `/update-security`
- If it does not exist: tell the user to run `/generate-security`

Format the suggestion as a clear next step, not an inline note.
