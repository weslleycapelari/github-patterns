---
name: "update-changelog"
description: "Add a new release entry or improve an existing CHANGELOG.md following Keep a Changelog conventions."
argument-hint: "Optional: new version number, release date, list of changes by category"
agent: "changelog-community"
---

# /update-changelog

Use `changelog-community` to add a new release entry or improve an existing `CHANGELOG.md`.

## Execution contract

1. Locate the existing CHANGELOG at repository root.
2. Read current content and identify the `[Unreleased]` section and latest version.
3. Ask for the new version number, release date, and categorized change list.
4. Promote `[Unreleased]` to the new version entry and reset `[Unreleased]` to empty.
5. Return:
   - final updated CHANGELOG content
   - explicit diff summary (new section added, links updated)

## File discovery strategy (mandatory)

Search in this order and use the first match found:

1. `CHANGELOG.md` (repository root)
2. `CHANGELOG` (no extension, repository root)

If no file is found, report clearly and suggest running `/generate-changelog` instead.

## Format convention (mandatory)

Follow [Keep a Changelog](https://keepachangelog.com) format:

- `[Unreleased]` section always present at top after update
- New version entry immediately below `[Unreleased]`
- ISO-8601 date format (`YYYY-MM-DD`)
- Change categories: `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`, `Security`
- Update version comparison links at the bottom

## Notes

- This prompt does not pin a specific model.
- This prompt is dedicated to `changelog-community`.

## Next command (mandatory — include at end of final message)

At the end of your final message, tell the user that community files are complete and recommend the next phase:

- Run `/generate-issue-templates` to initialize structured issue management.
- Mention that this enables qualitative importance, quantitative epic progress, and duplicate linkage.

Format the suggestion as a clear next-step block, not an inline note.
