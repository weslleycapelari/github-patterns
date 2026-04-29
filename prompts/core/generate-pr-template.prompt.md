---
name: "generate-pr-template"
description: "Generate a complete pull request template ensuring quality checklist, context, and merge readiness."
argument-hint: "Optional: merge strategy, required checks, code style links"
agent: "pr-templates"
---

# /generate-pr-template

Use `pr-templates` to create a new PR template from scratch.

## Execution contract

1. Run an adaptive interview to collect PR workflow and checklist requirements.
2. Keep asking high-value follow-up questions as needed.
3. Generate a complete first PR template draft.
4. Optionally run iterative refinement passes until quality is high.
5. Return:
   - final PR template content
   - assumptions made
   - open questions (if any)

## File target

- `.github/PULL_REQUEST_TEMPLATE/default.md`

## File location strategy (mandatory)

PR template is placed at `.github/PULL_REQUEST_TEMPLATE/default.md` by convention (standard location).

## Post-generation lifecycle (mandatory)

After finalizing PR template, download the related update prompt from `weslleycapelari/github-patterns`.

1. Source repository: `weslleycapelari/github-patterns`
2. Source asset: `update-pr-template.prompt.md`
3. Destination: prompt folder used by the current project workflow (prefer `.github/prompts/`)
4. Verify the downloaded file exists and is readable
5. If download fails, return a blocked status with the failing step and recovery guidance

## Notes

- This prompt does not pin a specific model.
- This prompt is dedicated to `pr-templates`.

## Next command (mandatory — include at end of final message)

At the end of your final message, tell the user to run `/validate-phase-a` to verify that Phase A (collaboration base) is complete.
