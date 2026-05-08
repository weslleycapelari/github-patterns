# Prompt: Create Stack Bundle

## Objective

Create or improve stack-specific assets (agents/instructions/prompts) and register them coherently.

## Instructions

1. Define stack scope and technology versions.
2. Delegate asset creation with explicit routing:
	- agent files -> Asset Factory
	- prompt files -> Prompt Studio
	- documentation/instructions -> Documentation Steward
	- registry/schema integration -> Registry Schema Governor
3. Delegate independent review for consistency and overclaim risks.
4. Register assets in `registry.json` and validate against schema.
5. Provide adoption checklist.

## Required Output

- Stack asset files created/updated
- Registry integration summary
- Validation results
- Next-step rollout plan

## Quality Bar

- [ ] Stack versions and constraints are explicit.
- [ ] Routed subagent outputs are present.
- [ ] Registry integration passes schema validation.
- [ ] Overclaim risks were reviewed.

## Confirmation Gate

If stack rollout introduces new registry categories or breaking contracts, request confirmation before finalizing.

## Example

"Create Laravel and Vue stack assets, register them, validate schema, and produce a rollout checklist."
