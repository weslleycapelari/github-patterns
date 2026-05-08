# Prompt: Full AI Iteration Workflow

## Objective

Execute a complete AI-first cycle for any repository change using nested subagents.

## Workflow Contract

1. Discovery
2. Subagent Draft
3. Subagent Review
4. Subagent Improvement
5. Validation
6. Final Report

At least one independent review subagent is mandatory.

## Workflow Routing

- agent artifacts -> Asset Factory
- prompt artifacts -> Prompt Studio
- documentation/instructions -> Documentation Steward
- registry/schema updates -> Registry Schema Governor
- final hardening review -> Asset Review Board

## Required Output

- Plan and artifact scope
- Draft output
- Review findings
- Improvement diff summary
- Validation evidence
- Merge recommendation

## Guardrails

- No destructive actions without explicit confirmation.
- No claims without verification evidence.
- No skipping review phase.

## Quality Bar

- [ ] Routing to specialized subagents is explicit.
- [ ] Independent review was executed.
- [ ] Improvement loop was completed.
- [ ] Validation evidence is included.

## Example

"For a registry and docs update, route draft creation to Asset Factory, run final review with Asset Review Board, apply improvements, and provide validation evidence."
