---
name: "generate-changelog"
description: "Generate a complete CHANGELOG.md using Keep a Changelog conventions, guided interview, and optional git history inspection."
argument-hint: "Optional: version list, release dates, semver policy, git tag range"
agent: "changelog-community"
---

# /generate-changelog

Use `changelog-community` to create a new `CHANGELOG.md` from scratch.

## Execution contract

1. Run an adaptive interview to collect release history details.
2. Inspect git history, tags, and existing release notes if available.
3. Generate a complete CHANGELOG draft following Keep a Changelog conventions.
4. Optionally run iterative refinement passes until quality is high.
5. Return:
   - final CHANGELOG content
   - assumptions made
   - open questions (if any)

## File target

- `CHANGELOG.md`

## File location strategy (mandatory)

`CHANGELOG.md` is placed at the repository root by convention.

1. Default file path: `CHANGELOG.md` (repository root)
2. If the user explicitly requests a different location, respect their choice

## Format convention (mandatory)

Follow [Keep a Changelog](https://keepachangelog.com) format:

- `[Unreleased]` section at the top
- Versions in reverse chronological order with ISO-8601 dates
- Change categories: `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`, `Security`
- Version comparison links at the bottom

## Post-generation lifecycle (mandatory)

After finalizing `CHANGELOG.md`, download the related update prompt from `weslleycapelari/github-patterns`.

1. Source repository: `weslleycapelari/github-patterns`
2. Source asset: `update-changelog.prompt.md`
3. Destination: prompt folder used by the current project workflow (prefer `.github/prompts/`)
4. Verify the downloaded file exists and is readable
5. If download fails, return a blocked status with the failing step and recovery guidance

## Notes

- This prompt does not pin a specific model.
- This prompt is dedicated to `changelog-community`.

## Next command (mandatory — include at end of final message)

At the end of your final message, tell the user that all core community files are now complete. Summarize the full set:
`README`, `CONTRIBUTING`, `CODE_OF_CONDUCT`, `SECURITY`, `SUPPORT`, `GOVERNANCE`, `CHANGELOG`.

Suggest the next logical action based on the project state:
- If any file was placed in root or `docs/` instead of `.github/`, mention that moving it to `.github/` gives highest GitHub precedence
- Suggest validating the GitHub Community Profile checklist
- Suggest running `/start-project` if a kickoff profile does not yet exist in `docs/project/`

Format the summary as a clear final handoff block, not an inline note.
