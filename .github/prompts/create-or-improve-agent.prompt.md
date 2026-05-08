# Prompt: Create or Improve Agent

## Objective

Create or improve an `.agent.md` artifact using mandatory subagent cycles.

## Instructions

1. Read similar agents in `agents/` and `.github/agents/`.
2. Delegate draft generation to a subagent.
3. Delegate independent review to a second subagent.
4. Apply findings and produce final version.
5. Return a merge-readiness summary.

## Required Output

- Final agent markdown
- Findings resolved list
- Open risks

## Quality Bar

- [ ] Subagent draft was produced.
- [ ] Independent subagent review was completed.
- [ ] Critical findings are resolved.
- [ ] Output contract is explicit.

## Confirmation Gate

If structural changes alter behavior scope, ask for confirmation before finalizing.

## Example

"Create a new review-focused agent for documentation consistency and return a merge-readiness checklist."
