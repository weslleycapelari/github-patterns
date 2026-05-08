# Prompt: Create or Improve Documentation

## Objective

Create or improve repository documentation with source-of-truth consistency.

## Instructions

1. Read source files and related docs.
2. Delegate first draft to a subagent.
3. Delegate factual consistency review to a second subagent.
4. Apply improvements and keep procedures actionable.
5. Output updated documentation and sync notes.

## Required Output

- Final documentation draft
- Source references checked
- Follow-up sync list (en/pt-br if needed)

## Quality Bar

- [ ] Procedures are actionable.
- [ ] Source-of-truth references are verified.
- [ ] Terminology is consistent with repository standards.
- [ ] en/pt-br sync status is declared.

## Confirmation Gate

If documentation changes alter behavior contracts, request confirmation before finalizing.

## Example

"Update README and docs/en/registry.md after registry contract changes, then return en/pt-br sync notes and pending translation tasks."
