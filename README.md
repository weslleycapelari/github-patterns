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

This scenario now has complete step-by-step documentation in separate files:

- Execution index: `docs/en/examples/elite-shop/README.md`
- Step 1 (Repo Architect onboarding): `docs/en/examples/elite-shop/01-onboarding-repo-architect.md`
- Step 2 (Issue strategy / Agile-Scrum): `docs/en/examples/elite-shop/02-issue-ops-architect.md`
- Step 3 (Nested delegation with Laravel specialist): `docs/en/examples/elite-shop/03-laravel-expert-delegacao.md`
- Step 4 (ProductService with TDD and standards): `docs/en/examples/elite-shop/04-product-service-tdd.md`

Extended MVP prompt pack (used in a full greenfield execution variant with Laravel 13.8 + Blade/Alpine):

- Prompt 01 — Factories + Seeders: `docs/en/examples/elite-shop/05-mvp-factories-seeders.md`
- Prompt 02 — Order module: `docs/en/examples/elite-shop/06-mvp-order-module.md`
- Prompt 03 — HTTP API layer: `docs/en/examples/elite-shop/07-mvp-http-api.md`
- Prompt 04 — Frontend Blade + Tailwind + Alpine: `docs/en/examples/elite-shop/08-mvp-frontend-blade.md`
- Prompt 05 — Quality, CI/CD, docs and deploy readiness: `docs/en/examples/elite-shop/09-mvp-quality-deploy.md`

> Note: Scenario 1 base context remains Laravel + Vue.js 3. The extended pack above documents a real alternate execution track for a Blade-first storefront.

---

### Scenario 2: Hotel Reservation System (Python + FastAPI)

**Description:** Room booking platform with real-time availability and payment integration.

**Technical context:** Python 3.11, FastAPI, SQLAlchemy, Alembic migrations, OpenAPI documentation.

**Requirements:** Layered architecture (Schemas, Models, CRUD, Endpoints), 100% type hints, transaction-safe concurrency, CI quality gates.

This scenario now has complete step-by-step documentation in separate files:

- Execution index: `docs/en/examples/swift-booking/README.md`
- Step 1 (Onboarding and initial governance): `docs/en/examples/swift-booking/01-onboarding-governance.md`
- Step 2 (Phase B branch protection): `docs/en/examples/swift-booking/02-phase-b-branch-protection.md`
- Step 3 (Project audit for transactions and race conditions): `docs/en/examples/swift-booking/03-project-audit.md`

Extended prompt pack (used to turn the governance-first scenario into a more complete implementation-and-quality track):

- Prompt 01 — Domain model + Alembic baseline: `docs/en/examples/swift-booking/04-domain-model-alembic.md`
- Prompt 02 — Availability search API: `docs/en/examples/swift-booking/05-availability-search-api.md`
- Prompt 03 — Reservation workflow API: `docs/en/examples/swift-booking/06-reservation-workflow-api.md`
- Prompt 04 — Concurrency hardening: `docs/en/examples/swift-booking/07-concurrency-hardening.md`
- Prompt 05 — Quality, OpenAPI, and CI gates: `docs/en/examples/swift-booking/08-quality-openapi-ci.md`

> Note: the original Scenario 2 still centers on onboarding, branch protection, and audit. The extended pack above adds a practical implementation-and-quality track for a fuller Swift-Booking example.

---

### Scenario 3: Enterprise Admin Panel (React + TypeScript)

**Description:** Corporate data dashboard with multi-level access control and data compliance.

**Technical context:** React 18, TypeScript, Tailwind CSS Design System, React Query, performance monitoring.

**Requirements:** Phase D (Advanced Security) for PII protection, WCAG 2.2 accessibility, ADR documentation, conventional commit enforcement.

This scenario now has complete step-by-step documentation in separate files:

- Execution index: `docs/en/examples/enterprise-admin-panel/README.md`
- Step 1 (Governance onboarding + initial ADR): `docs/en/examples/enterprise-admin-panel/01-onboarding-governance-adr.md`
- Step 2 (Specialist agent creation with Agent Factory): `docs/en/examples/enterprise-admin-panel/02-agent-factory-a11y-guardian.md`
- Step 3 (Performance-oriented DataChart component): `docs/en/examples/enterprise-admin-panel/03-datachart-performance-component.md`

Extended prompt pack (used to turn the base scenario into a fuller implementation-and-quality track):

- Prompt 01 — Tailwind design system foundation: `docs/en/examples/enterprise-admin-panel/04-design-system-tailwind-foundation.md`
- Prompt 02 — React Query data-layer hardening: `docs/en/examples/enterprise-admin-panel/05-react-query-data-layer-hardening.md`
- Prompt 03 — Phase D PII security hardening: `docs/en/examples/enterprise-admin-panel/06-phase-d-pii-security-hardening.md`
- Prompt 04 — WCAG 2.2 accessibility audit: `docs/en/examples/enterprise-admin-panel/07-wcag-22-accessibility-audit.md`
- Prompt 05 — Quality, monitoring, ADRs, and CI: `docs/en/examples/enterprise-admin-panel/08-quality-monitoring-adr-commits-ci.md`

> Note: the original Scenario 3 still centers on onboarding, specialist-agent creation, and performance-aware component development. The extended pack above adds a practical design-system, security, accessibility, and operational-quality track for a fuller enterprise dashboard example.

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
