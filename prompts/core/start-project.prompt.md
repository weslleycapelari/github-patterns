---
name: "start-project"
description: "Run strict kickoff onboarding: collect/validate identity and language settings, enforce CONFIRM, separate Copilot policy from project-local config, and generate normalized .project profiles."
argument-hint: "Optional context: project type, stack, goal, visibility, and owner"
agent: "start-project"
---

# /start-project

Use the `start-project` agent for this workflow.

## Execution contract

- Run single-message chat form mode by default
- Validate required fields
- Normalize values and surface corrections
- Require explicit `CONFIRM` before file generation
- Enforce policy boundary:
	- global behavior conventions belong to `copilot-instructions`
	- project-specific identity/preferences belong to `.project/*`
- Generate kickoff files and return a concise handoff
- After kickoff, check whether `README.md` and `CONTRIBUTING.md` already exist
- Bootstrap community assets from `weslleycapelari/github-patterns` using conditional selection:
	- if `README.md` exists, download `update-readme.prompt.md`; otherwise download `generate-readme.prompt.md`
	- if `CONTRIBUTING.md` exists, download `update-contributing.prompt.md`; otherwise download `generate-contributing.prompt.md`

## Required collection fields

- Full name
- Primary email (or explicit `N/A`)
- GitHub username (handle only)
- Repository name
- Repository visibility (`public`, `private`, `internal`)
- Chat conversation language
- Documentation/code writing language
- Project copy/UI text language

Optional:

- Repository owner (user/org)
- Project context (type, stack, goal)
- Optional links (docs, board, roadmap)

## Validation and privacy requirements

- Reject GitHub profile URLs; accept handle only.
- Enforce repository name without spaces; suggest `kebab-case` normalization.
- If user provides one language only, ask whether to apply to all three language fields.
- If repository is public and email appears personal, request explicit choice to keep, mask, or remove before confirmation.
- Do not proceed to generation while unresolved validation/privacy decisions remain.

## Confirmation protocol

Before requesting `CONFIRM`, show a normalized preview split into:

1. Global policy candidates for `copilot-instructions`
2. Project-local kickoff data to be stored in `.project/*`

Accept only:

- `CONFIRM` to generate files
- `EDIT` to revise inputs

## Files to create/update

- `.project/user-profile.md`
- `.project/repository-profile.md`
- `.project/kickoff-summary.md`

## File content expectations

- Use deterministic section order and explicit labels.
- Use `Not provided` for missing optional values.
- Include ISO-8601 timestamp in `Last updated` fields.
- In kickoff summary, include policy boundary notes and recommended next steps.

## Notes

- This prompt intentionally does not pin a specific model.
- This prompt is dedicated to the `start-project` agent only.
- Do not auto-edit `.github/copilot-instructions.md` unless explicitly requested by the user.
