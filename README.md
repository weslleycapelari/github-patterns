# GitHub Patterns Marketplace

Production-grade marketplace for repository governance assets, Copilot agents, issue strategy templates, and CI baselines.

Designed to bootstrap and evolve repositories with the GitHub 100% governance model—from collaboration setup to security and AI-assisted operations.

## Table of Contents

- [Overview](#overview)
- [Quick Start](#quick-start)
- [Core Concepts](#core-concepts)
- [What Is Included](#what-is-included)
- [Governance Phases (A–E)](#governance-phases-ae)
- [Issue Strategy Catalog](#issue-strategy-catalog)
- [Registry and Schema](#registry-and-schema)
- [Validation and Quality Checks](#validation-and-quality-checks)
- [Real-World Scenarios](#real-world-scenarios)
- [AI Operating Model](#ai-operating-model)
- [Extending the Marketplace](#extending-the-marketplace)
- [Repository Structure](#repository-structure)
- [Contributing](#contributing)
- [Roadmap](#roadmap)

## Overview

GitHub Patterns Marketplace provides reusable, composable assets to standardize repository operations.

Primary goals:

- Accelerate onboarding with consistent governance defaults.
- Improve maintainability through structured templates and machine-readable metadata.
- Enable AI-assisted repository management using specialized Copilot agents.
- Keep the system language-agnostic while supporting stack-aware recommendations.

## Quick Start

New here? Start with **Option 1** for fastest onboarding, then use **Option 2** for fine-grained customization.

### Option 1: Copilot Chat Bootstrap

Use this prompt in Copilot Chat:

```text
Act as Repo Architect (setup-orchestrator).
Use:
- https://raw.githubusercontent.com/weslleycapelari/github-patterns/main/agents/setup-orchestrator.agent.md
- https://raw.githubusercontent.com/weslleycapelari/github-patterns/main/registry.json
Start onboarding and ask the intake form.
```

### Option 2: Manual Asset Installation

1. Inspect desired assets in `registry.json`.
2. Resolve source paths using `endpoint_base + path`.
3. Copy files to target destinations in your repository.
4. Commit with a setup-oriented message, for example:

```text
chore(setup): apply github-patterns baseline
```

## Core Concepts

The marketplace is driven by two source-of-truth files:

- `registry.json`: catalog of assets, stacks, governance phases, and paths.
- `docs/schemas/registry.schema.json`: JSON Schema used to validate registry structure.

Automation agents should resolve assets from registry metadata and avoid hardcoded paths.

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

- `minimalist`
- `open-source`
- `agile-scrum`
- `kanban-devops`
- `enterprise-safe`
- `shape-up`

## Governance Phases (A–E)

The GitHub 100% governance model is represented in registry core phases:

- **Phase A, Collaboration Base:** contribution baseline and issue operations foundation.
- **Phase B, Merge Governance:** repository-level governance orchestration.
- **Phase C, CI/CD and Quality:** workflow baseline with linting and conditional tests.
- **Phase D, Advanced Security:** governance-ready foundation for security controls.
- **Phase E, Intelligence and MCP:** Copilot instructions and agent-driven operations.

## Issue Strategy Catalog

Each strategy is optimized for a different operating model:

- **minimalist:** fast, low-friction issue flow for solo or MVP projects.
- **open-source:** stronger triage and duplicate prevention for communities.
- **agile-scrum:** stories, tasks, epics, and definition-of-done discipline.
- **kanban-devops:** continuous delivery with incident and RFC support.
- **enterprise-safe:** compliance, auditability, and security remediation workflows.
- **shape-up:** appetite-based planning with pitches, scopes, and rabbit-hole handling.

## Registry and Schema

### Files

- `registry.json`
- `docs/schemas/registry.schema.json`

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

## Validation and Quality Checks

Recommended checks before release:

1. Validate registry against schema.
2. Verify YAML syntax for all issue templates and workflows.
3. Confirm each registry path maps to an existing file.
4. Ensure all agents and user-facing docs are internally consistent.

## Real-World Scenarios

Use the scenario indexes below for quick access:

- **Scenario 1 (Laravel + Vue.js 3):** [docs/en/examples/elite-shop/README.md](docs/en/examples/elite-shop/README.md)
- **Scenario 2 (Python + FastAPI):** [docs/en/examples/swift-booking/README.md](docs/en/examples/swift-booking/README.md)
- **Scenario 3 (React + TypeScript):** [docs/en/examples/enterprise-admin-panel/README.md](docs/en/examples/enterprise-admin-panel/README.md)

<details>
<summary><strong>Scenario 1: High-Performance E-Commerce (Laravel + Vue.js 3)</strong></summary>

**Description:** Marketplace with shopping cart, inventory management, and secure checkout.

**Technical context:** Modular monolith with Laravel 11, Service Layer, Vue 3 Composition API, PostgreSQL with query-level optimization via specialist subagents.

**Requirements:** Sanctum auth, Pinia state management, FormRequest validation, Pest + Vitest test coverage, N+1 and XSS protection.

Step-by-step documentation:

- Execution index: [README.md](docs/en/examples/elite-shop/README.md)
- Step 1 (Repo Architect onboarding): [01-onboarding-repo-architect.md](docs/en/examples/elite-shop/01-onboarding-repo-architect.md)
- Step 2 (Issue strategy / Agile-Scrum): [02-issue-ops-architect.md](docs/en/examples/elite-shop/02-issue-ops-architect.md)
- Step 3 (Nested delegation with Laravel specialist): [03-laravel-expert-delegacao.md](docs/en/examples/elite-shop/03-laravel-expert-delegacao.md)
- Step 4 (ProductService with TDD and standards): [04-product-service-tdd.md](docs/en/examples/elite-shop/04-product-service-tdd.md)

Extended MVP prompt pack (Laravel 13.8 + Blade/Alpine variant):

- Prompt 01 — Factories + Seeders: [05-mvp-factories-seeders.md](docs/en/examples/elite-shop/05-mvp-factories-seeders.md)
- Prompt 02 — Order module: [06-mvp-order-module.md](docs/en/examples/elite-shop/06-mvp-order-module.md)
- Prompt 03 — HTTP API layer: [07-mvp-http-api.md](docs/en/examples/elite-shop/07-mvp-http-api.md)
- Prompt 04 — Frontend Blade + Tailwind + Alpine: [08-mvp-frontend-blade.md](docs/en/examples/elite-shop/08-mvp-frontend-blade.md)
- Prompt 05 — Quality, CI/CD, docs and deploy readiness: [09-mvp-quality-deploy.md](docs/en/examples/elite-shop/09-mvp-quality-deploy.md)

> Note: Scenario 1 base context remains Laravel + Vue.js 3. The extended pack documents an alternate Blade-first storefront execution track.

</details>

<details>
<summary><strong>Scenario 2: Hotel Reservation System (Python + FastAPI)</strong></summary>

**Description:** Room booking platform with real-time availability and payment integration.

**Technical context:** Python 3.11, FastAPI, SQLAlchemy, Alembic migrations, OpenAPI documentation.

**Requirements:** Layered architecture (Schemas, Models, CRUD, Endpoints), 100% type hints, transaction-safe concurrency, CI quality gates.

Step-by-step documentation:

- Execution index: [README.md](docs/en/examples/swift-booking/README.md)
- Step 1 (Onboarding and initial governance): [01-onboarding-governance.md](docs/en/examples/swift-booking/01-onboarding-governance.md)
- Step 2 (Phase B branch protection): [02-phase-b-branch-protection.md](docs/en/examples/swift-booking/02-phase-b-branch-protection.md)
- Step 3 (Project audit for transactions and race conditions): [03-project-audit.md](docs/en/examples/swift-booking/03-project-audit.md)

Extended prompt pack:

- Prompt 01 — Domain model + Alembic baseline: [04-domain-model-alembic.md](docs/en/examples/swift-booking/04-domain-model-alembic.md)
- Prompt 02 — Availability search API: [05-availability-search-api.md](docs/en/examples/swift-booking/05-availability-search-api.md)
- Prompt 03 — Reservation workflow API: [06-reservation-workflow-api.md](docs/en/examples/swift-booking/06-reservation-workflow-api.md)
- Prompt 04 — Concurrency hardening: [07-concurrency-hardening.md](docs/en/examples/swift-booking/07-concurrency-hardening.md)
- Prompt 05 — Quality, OpenAPI, and CI gates: [08-quality-openapi-ci.md](docs/en/examples/swift-booking/08-quality-openapi-ci.md)

> Note: the original Scenario 2 centers on onboarding, branch protection, and audit. The extended pack adds an implementation-and-quality track.

</details>

<details>
<summary><strong>Scenario 3: Enterprise Admin Panel (React + TypeScript)</strong></summary>

**Description:** Corporate data dashboard with multi-level access control and data compliance.

**Technical context:** React 18, TypeScript, Tailwind CSS Design System, React Query, performance monitoring.

**Requirements:** Phase D (Advanced Security) for PII protection, WCAG 2.2 accessibility, ADR documentation, conventional commit enforcement.

Step-by-step documentation:

- Execution index: [README.md](docs/en/examples/enterprise-admin-panel/README.md)
- Step 1 (Governance onboarding + initial ADR): [01-onboarding-governance-adr.md](docs/en/examples/enterprise-admin-panel/01-onboarding-governance-adr.md)
- Step 2 (Specialist agent creation with Agent Factory): [02-agent-factory-a11y-guardian.md](docs/en/examples/enterprise-admin-panel/02-agent-factory-a11y-guardian.md)
- Step 3 (Performance-oriented DataChart component): [03-datachart-performance-component.md](docs/en/examples/enterprise-admin-panel/03-datachart-performance-component.md)

Extended prompt pack:

- Prompt 01 — Tailwind design system foundation: [04-design-system-tailwind-foundation.md](docs/en/examples/enterprise-admin-panel/04-design-system-tailwind-foundation.md)
- Prompt 02 — React Query data-layer hardening: [05-react-query-data-layer-hardening.md](docs/en/examples/enterprise-admin-panel/05-react-query-data-layer-hardening.md)
- Prompt 03 — Phase D PII security hardening: [06-phase-d-pii-security-hardening.md](docs/en/examples/enterprise-admin-panel/06-phase-d-pii-security-hardening.md)
- Prompt 04 — WCAG 2.2 accessibility audit: [07-wcag-22-accessibility-audit.md](docs/en/examples/enterprise-admin-panel/07-wcag-22-accessibility-audit.md)
- Prompt 05 — Quality, monitoring, ADRs, and CI: [08-quality-monitoring-adr-commits-ci.md](docs/en/examples/enterprise-admin-panel/08-quality-monitoring-adr-commits-ci.md)

> Note: the original Scenario 3 centers on onboarding, specialist-agent creation, and performance-aware component development. The extended pack adds design-system, security, accessibility, and operational-quality tracks.

</details>

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

<details>
<summary>How to add assets and issue strategies</summary>

When adding a new asset:

1. Add the file under the correct folder.
2. Register it in `registry.json` under the appropriate assets section.
3. Update stack recommendations and/or phase mappings if applicable.
4. Update schema only if structure changes.
5. Re-run validation checks.

When adding a new issue strategy:

1. Create strategy folder and `config.yml`.
2. Add templates with consistent field semantics.
3. Register strategy metadata in `assets.issue_strategies`.
4. Document expected use case in docs.

</details>

## Repository Structure

<details>
<summary>Reference tree</summary>

```text
.github/
agents/
docs/
  en/
  pt-br/
  schemas/
library/
  github-baseline/
    issue-templates/
    workflows/
registry.json
README.md
```

</details>

## Contributing

Contributions are welcome for:

- New governance assets.
- Improved templates for better human and AI usability.
- Additional stack recommendations.
- Registry/schema hardening and automation.

Please open issues and pull requests with clear scope, rationale, and validation evidence.

## Roadmap

<details>
<summary>Planned improvements</summary>

- Expanded Phase D security asset catalog.
- Optional CD deployment baselines.
- Automated registry path integrity checks in CI.
- Additional language-specific setup playbooks.

</details>
