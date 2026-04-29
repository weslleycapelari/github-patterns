---
name: "generate-governance"
description: "Generate a complete GOVERNANCE.md using adaptive interview + optional iterative refinement passes."
argument-hint: "Optional: project type, team size, decision model, existing roles"
agent: "governance-community"
---

# /generate-governance

Use `governance-community` to create a new `GOVERNANCE.md` from scratch.

## Execution contract

1. Run an adaptive interview to collect project governance details.
2. Keep asking high-value follow-up questions as needed.
3. Generate a complete first GOVERNANCE draft.
4. Optionally run iterative refinement passes until quality is high.
5. Return:
   - final GOVERNANCE content
   - assumptions made
   - open questions (if any)

## File target

- `GOVERNANCE.md`

## File location strategy (mandatory)

`GOVERNANCE.md` is placed at the repository root by convention.

1. Default file path: `GOVERNANCE.md` (repository root)
2. If the user explicitly requests a different location, respect their choice
3. Note that this file is not surfaced by GitHub Community Profile checklist but is widely recognized by open-source tooling

## Post-generation lifecycle (mandatory)

After finalizing `GOVERNANCE.md`, download the related update prompt from `weslleycapelari/github-patterns`.

1. Source repository: `weslleycapelari/github-patterns`
2. Source asset: `update-governance.prompt.md`
3. Destination: prompt folder used by the current project workflow (prefer `.github/prompts/`)
4. Verify the downloaded file exists and is readable
5. If download fails, return a blocked status with the failing step and recovery guidance

## Notes

- This prompt does not pin a specific model.
- This prompt is dedicated to `governance-community`.

## Next command (mandatory — include at end of final message)

At the end of your final message, check whether `CHANGELOG.md` already exists at the repository root.

- If it exists: tell the user to run `/update-changelog`
- If it does not exist: tell the user to run `/generate-changelog`

Format the suggestion as a clear next step, not an inline note.
