# Example 01 — Onboarding with Repo Architect

## Goal

Start the `Elite-Shop` project with Laravel stack, phases A→E, and script generation for Windows.

## Prerequisites

- Access to this marketplace repository.
- Usage of the `Repo Architect` agent.
- Project context defined (name, stack, visibility, phases, OS).

## Prompt

```text
Act as Repo Architect.
Use:
- https://raw.githubusercontent.com/weslleycapelari/github-patterns/main/registry.json
- https://raw.githubusercontent.com/weslleycapelari/github-patterns/main/agents/setup-orchestrator.agent.md
Start onboarding for a project called 'Elite-Shop', stack 'laravel',
visibility 'private', phases 'all', OS 'Windows'.
```

## Expected result

- Intake form completed.
- Asset proposal by phase (A→E).
- Table with source, destination, and phase.
- Explicit `CONFIRM` request to generate the script.

## Acceptance criteria

- All assets are resolved from `registry.json`.
- No invented/hardcoded paths.
- Proposal distinguishes mandatory phase assets vs stack recommendations.
