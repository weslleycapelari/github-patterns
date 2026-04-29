---
name: "update-codeowners"
description: "Update and improve an existing CODEOWNERS file to reflect team or code structure changes."
argument-hint: "Optional: new team members, code area changes, ownership model adjustments"
agent: "codeowners-governance"
---

# /update-codeowners

Use `codeowners-governance` to improve an existing `CODEOWNERS` file.

## Execution contract

1. Locate the existing CODEOWNERS at `.github/CODEOWNERS`.
2. Read the current content and understand existing rules.
3. Ask targeted questions to resolve gaps or outdated information.
4. Update incrementally, preserving valid existing rules.
5. Return:
   - final updated CODEOWNERS content
   - explicit diff summary (what changed and why)

## File discovery strategy (mandatory)

Location: `.github/CODEOWNERS` (standard location).

If no file is found, report clearly and suggest running `/generate-codeowners` instead.

## Notes

- This prompt does not pin a specific model.
- This prompt is dedicated to `codeowners-governance`.

## Next command (mandatory — include at end of final message)

At the end of your final message, tell the user to run `/generate-pr-template` to standardize pull request structure next.
