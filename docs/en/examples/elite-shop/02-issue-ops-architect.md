# Example 02 — Issue Strategy (Agile/Scrum)

## Goal

Install issue templates for the `agile-scrum` strategy and create an initial checkout Epic.

## Prompt

```text
Invoke agent @issue-ops-architect.
Select model '3. Agile / Scrum'.
Generate the script to install the Issue templates.
After installing, create an Issue of type 'Epic' for the 'Checkout System'.
```

## Expected result

- Template installation script for `.github/ISSUE_TEMPLATE`.
- Installed files: `config.yml`, `bug.yml`, `epic.yml`, `task.yml`, `user-story.yml`.
- Epic issue created for `Checkout System`.

## Acceptance criteria

- Templates resolved via `registry.json`.
- Epic created with scope and success criteria.
- Flow does not overwrite existing files without confirmation.
