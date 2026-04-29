---
name: "update-issue"
description: "Refine an existing project issue to improve clarity, completeness, classification, and progress tracking."
argument-hint: "Provide issue URL or issue body and what changed"
agent: "issue-ops"
---

# /update-issue

Use `issue-ops` to improve an existing issue.

## Execution contract

1. Read the current issue content.
2. Validate structure: beginning, middle, end.
3. Validate presence and correctness of qualitative importance.
4. Validate technical references and duplicate linkage.
5. If issue type is epic, update quantitative subissue progress.
6. Add or refine AI-readable structured block.
7. Return updated issue body and change summary.

## Template reference

Refer to the templates in `issue-ops` agent for the standard structure of each issue type (epic/task/bug/feature). Maintain the AI-readable block in every update.

## Notes

- This prompt does not pin a specific model.
- This prompt is dedicated to `issue-ops`.

## Next command (mandatory — include at end of final message)

At the end of your final message:

- If this issue still has open subissues, tell the user to run `/update-issue` again after status changes.
- If this issue is complete, tell the user to run `/generate-issue` for the next backlog item.
