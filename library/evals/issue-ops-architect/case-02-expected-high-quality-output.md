# Eval Case IOA-02 — Expected High-Quality Output / Full Intake Provided

## Metadata

- **agent**: `issue-ops-architect`
- **case_id**: `IOA-02`
- **status**: `draft`
- **scenario_type**: `expected_high_quality_output`
- **contract_version**: `1.1.0`

## Scenario

The requester provides all mandatory intake fields. The agent must diagnose the team's workflow maturity, select the correct strategy, and produce a ready-to-run setup script that resolves all paths via `registry.json`.

## Input (prompt payload)

```text
Team mode: Scrum
Repo visibility: Private
Main objective: speed
Preferred OS for script: Windows PowerShell
Enable blank issues: no

Please provision the issue template strategy and generate the setup script.
```

## Required Output Contract

1. Strategy selected with explicit justification tied to intake answers.
2. Maturity diagnosis (brief summary of why this strategy fits).
3. A complete, runnable PowerShell script that:
   - Creates `.github/ISSUE_TEMPLATE/` directory.
   - Downloads or generates template files for the `agile-scrum` strategy.
   - Resolves all template paths via `registry.json` (no hardcoded URLs or paths).
   - Disables blank issues (sets `blank_issues_enabled: false` in `config.yml`).
4. Validation summary (what the script will do, in plain language).
5. Decision log with actor, decision, and ISO-8601 timestamp.

## PASS Criteria (all required)

1. Strategy selected is `agile-scrum` (consistent with Scrum + speed objective).
2. Justification explicitly references at least 2 intake answers.
3. Script is syntactically valid PowerShell.
4. Script creates `.github/ISSUE_TEMPLATE/` directory.
5. Script generates or downloads only templates belonging to `agile-scrum` (no cross-strategy mixing).
6. Template file paths within the script are resolved from registry JSON content — the registry fetch URL defined in the agent spec (`https://raw.githubusercontent.com/weslleycapelari/github-patterns/main/registry.json`) is acceptable. No template path is constructed independently of registry metadata.
7. Script produces a `config.yml` with `blank_issues_enabled: false`.
8. Decision log has at least 1 entry with actor, decision, and ISO-8601 timestamp.

## FAIL Conditions

- Strategy selected does not match intake answers without explicit justification.
- Script mixes templates from different strategies.
- Template paths within the script are constructed independently of registry metadata (registry fetch URL from agent spec is acceptable; template file paths must come from registry content).
- Script is not executable PowerShell syntax.
- `blank_issues_enabled` is missing or set to `true`.
- No decision log.

## Gate Decision

- `PASS` only if all PASS criteria are satisfied.
- Otherwise `FAIL`.
