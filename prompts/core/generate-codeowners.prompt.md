---
name: "generate-codeowners"
description: "Generate a complete CODEOWNERS file using team structure discovery and code area mapping."
argument-hint: "Optional: team structure, code areas, ownership model (distributed/centralized)"
agent: "codeowners-governance"
---

# /generate-codeowners

Use `codeowners-governance` to create a new `CODEOWNERS` file from scratch.

## Execution contract

1. Run an adaptive interview to collect team and code area details.
2. Keep asking high-value follow-up questions as needed.
3. Generate a complete first CODEOWNERS draft.
4. Optionally run iterative refinement passes until quality is high.
5. Return:
   - final CODEOWNERS content
   - assumptions made
   - open questions (if any)

## File target

- `.github/CODEOWNERS`

## File location strategy (mandatory)

CODEOWNERS is placed at `.github/CODEOWNERS` by convention (standard location).

## Post-generation lifecycle (mandatory)

After finalizing `CODEOWNERS`, download the related update prompt from `weslleycapelari/github-patterns`.

1. Source repository: `weslleycapelari/github-patterns`
2. Source asset: `update-codeowners.prompt.md`
3. Destination: prompt folder used by the current project workflow (prefer `.github/prompts/`)
4. Verify the downloaded file exists and is readable
5. If download fails, return a blocked status with the failing step and recovery guidance

## Notes

- This prompt does not pin a specific model.
- This prompt is dedicated to `codeowners-governance`.

## Next command (mandatory — include at end of final message)

At the end of your final message, tell the user to run `/generate-pr-template` to standardize pull request structure next.
