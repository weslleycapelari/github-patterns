---
name: "generate-issue"
description: "Generate a new project issue with structured narrative, qualitative priority, optional technical references, duplicate linkage, and AI-friendly block."
argument-hint: "Provide issue type (epic/task/bug/feature), title idea, and context"
agent: "issue-ops"
---

# /generate-issue

Use `issue-ops` to draft a complete issue following repository standards.

## Execution contract

1. Ask for issue type: `epic`, `task`, `bug`, or `feature`.
2. Build issue content with mandatory structure:
   - beginning: title + summary/context
   - middle: detailed problem/scope + acceptance criteria
   - ending: improvements/suggestions
3. Add required qualitative importance classification.
4. Add optional technical references when relevant.
5. Add duplicate linkage field with related issue numbers when available.
6. For epics, include quantitative progress block for subissues.
7. Include AI-readable block: objective, scope, constraints, acceptance criteria, risks.

## Output format

Return a ready-to-paste issue body and a short checklist of missing values (if any).

## Template reference

Refer to the templates in `issue-ops` agent for the standard structure of each issue type (epic/task/bug/feature). Include the AI-readable block in every issue generated.

## Notes

- This prompt does not pin a specific model.
- This prompt is dedicated to `issue-ops`.

## Next command (mandatory — include at end of final message)

At the end of your final message, tell the user to run `/update-issue` after opening the issue in GitHub to refine details with real implementation feedback.
