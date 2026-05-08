# GitHub Patterns Marketplace

Production-grade marketplace for repository governance assets, Copilot agents, issue strategy templates, and CI baselines.

This repository is designed to bootstrap and evolve projects according to the GitHub 100% governance model, from basic collaboration setup to security and AI-assisted operations.

## Table of Contents

1. Overview
2. Core Concepts
3. What Is Included
4. Governance Phases (A-E)
5. Issue Strategy Catalog
6. Quick Start
7. Registry and Schema
8. Repository Structure
9. Validation and Quality Checks
10. Extending the Marketplace
11. Contributing
12. Roadmap

## Overview

GitHub Patterns Marketplace provides reusable, composable assets to standardize repository operations.

Primary goals:

- Accelerate onboarding with consistent governance defaults.
- Improve maintainability through structured templates and machine-readable metadata.
- Enable AI-assisted repository management using specialized Copilot agents.
- Keep the system language-agnostic while supporting stack-aware recommendations.

## Core Concepts

The marketplace is driven by two source-of-truth files:

- registry.json: catalog of assets, stacks, governance phases, and paths.
- docs/schemas/registry.schema.json: JSON Schema used to validate registry structure.

Automation agents should always resolve assets from registry metadata and avoid hardcoded paths.

## What Is Included

### Agents

- Repo Architect: orchestrates phase-by-phase repository setup.
- Agent Factory: generates high-quality specialist agents.
- Issue Ops Architect: maps team maturity to issue template strategy.

### Baseline Assets

- Copilot instruction baseline.
- CONTRIBUTING baseline.
- CI workflow baseline.

### Issue Template Strategies

- minimalist
- open-source
- agile-scrum
- kanban-devops
- enterprise-safe
- shape-up

## Governance Phases (A-E)

The GitHub 100% model is represented in registry core phases:

- Phase A, Collaboration Base: contribution baseline and issue operations foundation.
- Phase B, Merge Governance: repository-level governance orchestration.
- Phase C, CI/CD and Quality: workflow baseline with linting and conditional tests.
- Phase D, Advanced Security: governance-ready foundation for security controls.
- Phase E, Intelligence and MCP: Copilot instructions and agent-driven operations.

## Issue Strategy Catalog

Each strategy is optimized for a different operating model:

- minimalist: fast, low-friction issue flow for solo or MVP projects.
- open-source: stronger triage and duplicate prevention for communities.
- agile-scrum: stories, tasks, epics, and definition-of-done discipline.
- kanban-devops: continuous delivery with incident and RFC support.
- enterprise-safe: compliance, auditability, and security remediation workflows.
- shape-up: appetite-based planning with pitches, scopes, and rabbit-hole handling.

## Quick Start

### Option 1: Copilot Chat Bootstrap

Use this prompt in Copilot Chat:

```text
Act as Repo Architect.
Use:
- https://raw.githubusercontent.com/weslleycapelari/github-patterns/main/agents/setup-orchestrator.agent.md
- https://raw.githubusercontent.com/weslleycapelari/github-patterns/main/registry.json
Start onboarding and ask the intake form.
```

### Option 2: Manual Asset Installation

1. Inspect desired assets in registry.json.
2. Resolve source paths using endpoint_base + path.
3. Copy files to target destinations in your repository.
4. Commit with a setup-oriented message, for example:

```text
chore(setup): apply github-patterns baseline
```

## Registry and Schema

### Files

- registry.json
- docs/schemas/registry.schema.json

### Validation

Use a JSON Schema validator compatible with draft 2020-12.

Example using Python:

```bash
python - <<'PY'
import json
from jsonschema import Draft202012Validator

with open('registry.json', encoding='utf-8') as f:
    data = json.load(f)
with open('docs/schemas/registry.schema.json', encoding='utf-8') as f:
    schema = json.load(f)

Draft202012Validator(schema).validate(data)
print('VALID')
PY
```

## Repository Structure

```text
agents/
docs/
  en/
  pt/
  pt-br/
  schemas/
library/
  github-baseline/
    issue-templates/
    workflows/
registry.json
README.md
```

## Validation and Quality Checks

Recommended checks before release:

1. Validate registry against schema.
2. Verify YAML syntax for all issue templates and workflows.
3. Confirm each registry path maps to an existing file.
4. Ensure all agents and user-facing docs are internally consistent.

## Extending the Marketplace

When adding a new asset:

1. Add the file under the correct folder.
2. Register it in registry.json under the appropriate assets section.
3. Update stack recommendations and/or phase mappings if applicable.
4. Update schema only if structure changes.
5. Re-run validation checks.

When adding a new issue strategy:

1. Create strategy folder and config.yml.
2. Add templates with consistent field semantics.
3. Register strategy metadata in assets.issue_strategies.
4. Document expected use case in docs.

## Contributing

Contributions are welcome for:

- New governance assets.
- Improved templates for better human and AI usability.
- Additional stack recommendations.
- Registry/schema hardening and automation.

Please open issues and pull requests with clear scope, rationale, and validation evidence.

## Roadmap

Planned improvements:

- Expanded Phase D security asset catalog.
- Optional CD deployment baselines.
- Automated registry path integrity checks in CI.
- Additional language-specific setup playbooks.
