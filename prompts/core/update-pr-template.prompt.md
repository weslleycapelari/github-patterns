---
name: "update-pr-template"
description: "Update and improve an existing PR template based on team feedback or workflow changes."
argument-hint: "Optional: new checklist items, improved sections, checklist refinement"
agent: "pr-templates"
---

# /update-pr-template

Use `pr-templates` to improve an existing PR template.

## Execution contract

1. Locate the existing PR template at `.github/PULL_REQUEST_TEMPLATE/default.md`.
2. Read the current content and understand existing sections.
3. Ask targeted questions to resolve gaps or outdated checklist items.
4. Update incrementally, preserving useful existing content.
5. Return:
   - final updated PR template content
   - explicit diff summary (what changed and why)

## File discovery strategy (mandatory)

Location: `.github/PULL_REQUEST_TEMPLATE/default.md` (standard location).

If no file is found, report clearly and suggest running `/generate-pr-template` instead.

## Notes

- This prompt does not pin a specific model.
- This prompt is dedicated to `pr-templates`.

## Next command (mandatory — include at end of final message)

At the end of your final message, tell the user to run `/validate-phase-a` to verify that Phase A (collaboration base) is complete.
