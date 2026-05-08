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
10. AI Operating Model
11. Extending the Marketplace
12. Real-World Scenarios
13. Contributing
14. Roadmap

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

## AI Operating Model

This repository uses a mandatory AI-first workflow for non-trivial changes.

- Core instructions: `.github/copilot-instructions.md`
- Specialized governance agents: `.github/agents/`
- Operational prompts: `.github/prompts/`
- Error and observability standards: `.github/standards/`

Required cycle:

1. Develop with a specialist subagent.
2. Review with an independent subagent.
3. Improve and re-validate.

No substantial artifact change should skip the review phase.

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

## Real-World Scenarios

Copy each prompt block in sequence into Copilot Chat to see the marketplace in action. Each scenario is self-contained; execute prompts in order within the same project context.

---

### Scenario 1: High-Performance E-Commerce (Laravel + Vue.js 3)

**Description:** Marketplace with shopping cart, inventory management, and secure checkout.

**Technical context:** Modular monolith with Laravel 11, Service Layer, Vue 3 Composition API, PostgreSQL with query-level optimization via specialist subagents.

**Requirements:** Sanctum auth, Pinia state management, FormRequest validation, Pest + Vitest test coverage, N+1 and XSS protection.

**Step 1 — Ecosystem onboarding:**

```text
Act as Repo Architect.
Use:
- https://raw.githubusercontent.com/weslleycapelari/github-patterns/main/registry.json
- https://raw.githubusercontent.com/weslleycapelari/github-patterns/main/agents/setup-orchestrator.agent.md
Start onboarding for a project called 'Elite-Shop', stack 'laravel',
visibility 'private', phases 'all', OS 'Windows'.
```

**Step 2 — Issue strategy setup:**

```text
Invoke agent @issue-ops-architect.
Select model '3. Agile / Scrum'.
Generate the script to install the Issue templates.
After installing, create an Issue of type 'Epic' for the 'Checkout System'.
```

**Step 3 — Nested delegation for CRUD architecture:**

```text
Act as @laravel-expert.
Analyze the requirement for a product CRUD with stock variations.
MUST invoke subagent @eloquent-optimizer to design the table schema
and subagent @laravel-security to ensure the checkout flow has no
authorization gaps, following docs/standards/architecture.md.
```

**Step 4 — Doctrine-driven implementation:**

```text
Copilot, using this project's llms.txt, implement the ProductService class.
Follow the Immutability and Early Return rules from docs/standards/code-design.md.
Before writing logic, generate the Pest test file following docs/standards/testing.md.
```

---

### Scenario 2: Hotel Reservation System (Python + FastAPI)

**Description:** Room booking platform with real-time availability and payment integration.

**Technical context:** Python 3.11, FastAPI, SQLAlchemy, Alembic migrations, OpenAPI documentation.

**Requirements:** Layered architecture (Schemas, Models, CRUD, Endpoints), 100% type hints, transaction-safe concurrency, CI quality gates.

**Step 1 — Bootstrap and governance:**

```text
Act as Repo Architect.
Install the ecosystem for a Python/FastAPI project called 'Swift-Booking'.
Ensure phases A, B, and C are configured first, including ci-pipeline-base
to validate code on every commit.
```

**Step 2 — Branch protection hardening:**

```text
Use the governance prompt at:
https://raw.githubusercontent.com/weslleycapelari/github-patterns/main/prompts/start-phase-b.prompt.md
Help me configure the Ruleset for the 'main' branch.
Require 2 approvals and mandate that the 'ci/test' check passes.
```

**Step 3 — Existing code audit:**

```text
Call @project-auditor.
Scan the app/database/ folder and verify that reservation transactions follow
the Security and Performance standards from the marketplace.
If a Race Condition risk is found, classify it as CRITICAL and provide a
corrective prompt.
```

---

### Scenario 3: Enterprise Admin Panel (React + TypeScript)

**Description:** Corporate data dashboard with multi-level access control and data compliance.

**Technical context:** React 18, TypeScript, Tailwind CSS Design System, React Query, performance monitoring.

**Requirements:** Phase D (Advanced Security) for PII protection, WCAG 2.2 accessibility, ADR documentation, conventional commit enforcement.

**Step 1 — Longevity-first initialization:**

```text
Act as Repo Architect.
Configure this Dashboard project.
Beyond the baseline, inject agent-factory into .github/agents/.
Create an ADR using the pattern from docs/standards/documentation.md
explaining why React Query was chosen over Redux for this project.
```

**Step 2 — Specialist agent factory:**

```text
Use @agent-factory to create a new agent called 'A11y-Guardian'.
It must specialize in accessibility review for React components,
following docs/standards/ai-collaboration.md.
Register it in the local registry.json.
```

**Step 3 — Standards-driven component development:**

```text
Copilot, create the DataChart component.
Consult docs/standards/performance.md to ensure the component causes
no unnecessary re-renders.
Apply the KISS principle and separate data-fetching logic from presentation.
```

---

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
