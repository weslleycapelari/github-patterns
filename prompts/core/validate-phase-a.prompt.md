---
name: "validate-phase-a"
description: "Validate Phase A completion (community files, issue templates, CODEOWNERS, PR templates) and provide Phase B readiness summary."
argument-hint: "Provide list of files that exist in your repository or request full validation scan"
agent: "phase-validation"
---

# /validate-phase-a

Use `phase-validation` to check Phase A completion and get Phase B readiness guidance.

## Execution contract

1. Ask the user to list which Phase A files they have completed, or offer to scan the repository.
2. Validate presence of:
   - Community files (README, CONTRIBUTING, CODE_OF_CONDUCT, SECURITY, SUPPORT, GOVERNANCE, CHANGELOG)
   - Issue templates (.github/ISSUE_TEMPLATE/)
   - CODEOWNERS (.github/CODEOWNERS)
   - PR template (.github/PULL_REQUEST_TEMPLATE/default.md)
   - (Optional) kickoff profile (docs/project/)
3. For each item, note location (.github/ vs root vs docs/).
4. Calculate Phase A completion percentage.
5. List missing critical items.
6. List missing optional items.
7. Provide Phase B readiness recommendation.
8. Suggest next steps.

## Validation checklist

**Critical (Phase A base)**:
- [ ] README (any location)
- [ ] CONTRIBUTING (any location)
- [ ] CODE_OF_CONDUCT (any location)
- [ ] SECURITY (any location)
- [ ] SUPPORT (any location)
- [ ] GOVERNANCE (root)
- [ ] CHANGELOG (root)
- [ ] `.github/ISSUE_TEMPLATE/` with all 5 files
- [ ] `.github/CODEOWNERS`
- [ ] `.github/PULL_REQUEST_TEMPLATE/default.md`

**Optional (enhanced)**:
- [ ] kickoff profile in `docs/project/`

## Notes

- This prompt does not pin a specific model.
- This prompt is dedicated to `phase-validation`.

## Next command (mandatory — include at end of final message)

At the end of your final message:

- If Phase A is complete (100%), tell the user that Phase A is ready and recommend moving to Phase B: "Run `/start-phase-b` to configure merge governance (rulesets, branch protection, required checks)."
- If Phase A is incomplete, tell the user which items to prioritize completing first, and suggest running the relevant `/generate-*` command for the highest-priority missing item.
