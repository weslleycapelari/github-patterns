---
name: "generate-issue-templates"
description: "Generate a complete issue management template set (.github/ISSUE_TEMPLATE) using epic/task/bug/feature methodology with qualitative and quantitative tracking."
argument-hint: "Optional: labels, team workflow, support/security links"
agent: "issue-ops"
---

# /generate-issue-templates

Use `issue-ops` to create a complete issue template structure from scratch.

## Execution contract

1. Confirm methodology (default: epic/task/bug/feature).
2. Collect project-specific labels and routing preferences.
3. Create `.github/ISSUE_TEMPLATE/` files with AI-friendly structure:
   - `epic.yml`
   - `task.yml`
   - `bug.yml`
   - `feature.yml`
   - `config.yml`
4. Ensure every template requires qualitative importance pre-classification.
5. Ensure epic template includes quantitative subissue progress tracking.
6. Ensure every template supports duplicate linkage.
7. Return a concise summary of generated templates and expected usage.

## Post-generation lifecycle (mandatory)

After successfully creating all template files in `.github/ISSUE_TEMPLATE/`, execute:

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

At the end of your final message, tell the user that issue templates are now ready and recommend running `/update-issue-templates` to refine labels or routing. Then suggest `/generate-issue` to create the first project issue with the new standard.
