# Mission Files (`.github/MISSIONS/`)

This directory enforces delegation traceability required by the Agent Mission Protocol.

## When a mission file is required

A mission file is required for pull requests with **non-trivial** scope changes, including:

- `agents/**`
- `prompts/**`
- `docs/**`
- `library/**`
- `standards/**`
- `instructions/**`
- `stacks/**`
- `.github/**`
- `README*`
- `registry.json`
- `ROADMAP.md`
- `structure.md`

Exception: PRs that change **only** `.github/MISSIONS/**` are treated as trivial by the CI gate.

## Mandatory fields (exact keys)

Each mission file must contain all of these exact field names with non-empty values:

- `Parent_Agent`
- `Child_Agent`
- `Mission_Objective`
- `Context_Links`
- `Success_Criteria`
- `Result_Payload`

## Naming rules

- Path: `.github/MISSIONS/<task-id>.md`
- `task-id` should be kebab-case and unique for the delegation event.
- Recommended: `<parent>-to-<child>-<scope>-<date-or-seq>`
- One delegation hop per file (one `Child_Agent` value). Nested delegations require a new mission file.

## CI gate behavior

The workflow runs `.github/scripts/validate-mission-protocol.sh` on PRs:

- **PASS**: non-trivial PR with at least one valid mission file changed.
- **FAIL**: non-trivial PR without mission file, or with invalid mission field contract.

## Local check

Run before opening a PR:

`bash .github/scripts/validate-mission-protocol.sh`
