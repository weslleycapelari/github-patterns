---
name: "update-issue-templates"
description: "Update and improve existing issue templates for better human readability and AI parsability."
argument-hint: "Optional: focus area (labels, triage flow, AI block fields, duplicate linking)"
agent: "issue-ops"
---

# /update-issue-templates

Use `issue-ops` to improve existing `.github/ISSUE_TEMPLATE` files.

## Execution contract

1. Read current templates in `.github/ISSUE_TEMPLATE/`.
2. Detect structural gaps against the required issue standard.
3. Update templates while preserving existing useful conventions.
4. Ensure all templates keep:
   - beginning/middle/end logical narrative
   - qualitative importance field
   - duplicate linkage field
5. Ensure epic template keeps quantitative progress calculation fields.
6. Return explicit diff-style summary of what changed and why.

## Post-update lifecycle (mandatory)

After successfully updating template files, execute:

1. **Download generate-issue prompt**
   - Source: `weslleycapelari/github-patterns`
   - Asset: `generate-issue.prompt.md`
   - Destination: `.github/prompts/`

2. **Download update-issue prompt**
   - Source: `weslleycapelari/github-patterns`
   - Asset: `update-issue.prompt.md`
   - Destination: `.github/prompts/`

3. **Download issue-ops agent**
   - Source: `weslleycapelari/github-patterns`
   - Asset: `issue-ops.agent.md`
   - Destination: `.github/agents/`

4. Verify all three files downloaded successfully.

## Notes

- This prompt does not pin a specific model.
- This prompt is dedicated to `issue-ops`.

## Next command (mandatory — include at end of final message)

At the end of your final message, tell the user to run `/generate-issue` to create the first project issue using the updated templates.
