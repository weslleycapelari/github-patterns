---
name: "generate-support"
description: "Generate a complete SUPPORT.md using adaptive interview + optional iterative refinement passes."
argument-hint: "Optional: support channels, triage model, SLA expectations, escalation path"
agent: "support-community"
---

# /generate-support

Use `support-community` to create a new `SUPPORT.md` from scratch.

## Execution contract

1. Run an adaptive interview to collect support operation details.
2. Keep asking high-value follow-up questions as needed.
3. Generate a complete first SUPPORT draft.
4. Optionally run iterative refinement passes until quality is high.
5. Return:
   - final SUPPORT content
   - assumptions made
   - open questions (if any)

## File target

- `SUPPORT.md`

## File location strategy (mandatory)

GitHub supports `SUPPORT` in `.github/`, repository root, or `docs/`.

1. Ask the user where to place the file: `.github/SUPPORT.md`, `SUPPORT.md`, or `docs/SUPPORT.md`
2. If the user does not choose, default to `.github/SUPPORT.md`
3. If multiple SUPPORT files exist, note that GitHub surfaces them by precedence: `.github/`, then root, then `docs/`

## Post-generation lifecycle (mandatory)

After finalizing `SUPPORT.md`, download the related update prompt from `weslleycapelari/github-patterns`.

1. Source repository: `weslleycapelari/github-patterns`
2. Source asset: `update-support.prompt.md`
3. Destination: prompt folder used by the current project workflow (prefer `.github/prompts/`)
4. Verify the downloaded file exists and is readable
5. If download fails, return a blocked status with the failing step and recovery guidance

## Notes

- This prompt does not pin a specific model.
- This prompt is dedicated to `support-community`.

## Next command (mandatory — include at end of final message)

At the end of your final message, check whether `GOVERNANCE.md` already exists at the repository root.

- If it exists: tell the user to run `/update-governance`
- If it does not exist: tell the user to run `/generate-governance`

Format the suggestion as a clear next step, not an inline note.
