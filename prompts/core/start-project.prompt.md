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
	- project-specific identity/preferences belong to `docs/project/`
- Generate kickoff files and return a concise handoff
- After kickoff, check whether `README`, `CONTRIBUTING`, `CODE_OF_CONDUCT`, `SUPPORT`, `SECURITY`, `GOVERNANCE`, and `CHANGELOG` already exist in supported locations (`.github/`, root, `docs/`)
- Bootstrap community assets from `weslleycapelari/github-patterns` using conditional selection:
	- if README exists in `.github/README.md`, `README.md`, or `docs/README.md`, download `update-readme.prompt.md`; otherwise download `generate-readme.prompt.md`
	- if CONTRIBUTING exists in `.github/CONTRIBUTING.md`, `CONTRIBUTING.md`, or `docs/CONTRIBUTING.md`, download `update-contributing.prompt.md`; otherwise download `generate-contributing.prompt.md`
	- if CODE_OF_CONDUCT exists in `.github/CODE_OF_CONDUCT.md`, `CODE_OF_CONDUCT.md`, or `docs/CODE_OF_CONDUCT.md`, download `update-code-of-conduct.prompt.md`; otherwise download `generate-code-of-conduct.prompt.md`
	- if SUPPORT exists in `.github/SUPPORT.md`, `SUPPORT.md`, or `docs/SUPPORT.md`, download `update-support.prompt.md`; otherwise download `generate-support.prompt.md`
	- if SECURITY exists in `.github/SECURITY.md`, `SECURITY.md`, or `docs/SECURITY.md`, download `update-security.prompt.md`; otherwise download `generate-security.prompt.md`
	- if GOVERNANCE exists as `GOVERNANCE.md`, download `update-governance.prompt.md`; otherwise download `generate-governance.prompt.md`
	- if CHANGELOG exists as `CHANGELOG.md`, download `update-changelog.prompt.md`; otherwise download `generate-changelog.prompt.md`

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

- `docs/project/user-profile.md`
- `docs/project/repository-profile.md`
- `docs/project/kickoff-summary.md`

## File content expectations

- Use deterministic section order and explicit labels.
- Use `Not provided` for missing optional values.
- Include ISO-8601 timestamp in `Last updated` fields.
- In kickoff summary, include policy boundary notes and recommended next steps.

## Notes

- This prompt intentionally does not pin a specific model.
- This prompt is dedicated to the `start-project` agent only.
- Do not auto-edit `.github/copilot-instructions.md` unless explicitly requested by the user.

## Next command (mandatory — include at end of final message)

At the end of your final message, based on the file existence check performed during the post-kickoff lifecycle, tell the user exactly which command to run next.

Use this priority order — suggest the first file that is missing or needs updating:

1. README → `/generate-readme` or `/update-readme`
2. CONTRIBUTING → `/generate-contributing` or `/update-contributing`
3. CODE_OF_CONDUCT → `/generate-code-of-conduct` or `/update-code-of-conduct`
4. SECURITY → `/generate-security` or `/update-security`
5. SUPPORT → `/generate-support` or `/update-support`
6. GOVERNANCE → `/generate-governance` or `/update-governance`
7. CHANGELOG → `/generate-changelog` or `/update-changelog`

If all 7 files already exist, tell the user all community files are present and suggest validating the GitHub Community Profile checklist.

Format the suggestion as a clear next step at the end of the kickoff handoff message.
