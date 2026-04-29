---
name: "generate-security"
description: "Generate a complete SECURITY.md using adaptive interview + optional iterative refinement passes."
argument-hint: "Optional: supported versions, reporting channel, SLA expectations, disclosure policy"
agent: "security-community"
---

# /generate-security

Use `security-community` to create a new `SECURITY.md` from scratch.

## Execution contract

1. Run an adaptive interview to collect vulnerability reporting details.
2. Keep asking high-value follow-up questions as needed.
3. Generate a complete first SECURITY draft.
4. Optionally run iterative refinement passes until quality is high.
5. Return:
   - final SECURITY content
   - assumptions made
   - open questions (if any)

## File target

- `SECURITY.md`

## File location strategy (mandatory)

GitHub supports `SECURITY` in `.github/`, repository root, or `docs/`.

1. Ask the user where to place the file: `.github/SECURITY.md`, `SECURITY.md`, or `docs/SECURITY.md`
2. If the user does not choose, default to `.github/SECURITY.md`
3. If multiple SECURITY files exist, note that GitHub surfaces them by precedence: `.github/`, then root, then `docs/`

## Post-generation lifecycle (mandatory)

After finalizing `SECURITY.md`, download the related update prompt from `weslleycapelari/github-patterns`.

1. Source repository: `weslleycapelari/github-patterns`
2. Source asset: `update-security.prompt.md`
3. Destination: prompt folder used by the current project workflow (prefer `.github/prompts/`)
4. Verify the downloaded file exists and is readable
5. If download fails, return a blocked status with the failing step and recovery guidance

## Notes

- This prompt does not pin a specific model.
- This prompt is dedicated to `security-community`.

## Next command (mandatory — include at end of final message)

At the end of your final message, check whether `SUPPORT.md` already exists in any supported location (`.github/SUPPORT.md`, `SUPPORT.md`, `docs/SUPPORT.md`).

- If it exists: tell the user to run `/update-support`
- If it does not exist: tell the user to run `/generate-support`

Format the suggestion as a clear next step, not an inline note.
