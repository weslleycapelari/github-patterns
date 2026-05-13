# Repository Evolution Roadmap

> This file is maintained by the `@roadmap-steward` agent. Do not edit manually unless updating strategic direction. See [Manual Edit Policy](#manual-edit-policy) below.

## 🗓️ Current Sprint (N5 — Locale Sync & L4 Stabilization — 2026-05-26 to 2026-06-09)

| Task                                            | Priority | Status      | Owner                    | Acceptance Criteria                                                                                                                    |
| ----------------------------------------------- | -------- | ----------- | ------------------------ | -------------------------------------------------------------------------------------------------------------------------------------- |
| Execute sync-locales & Validate PT-BR Coherence | High     | Not Started | `@documentation-steward` | Nenhuma divergência EN ↔ PT-BR; "Ejecute" → "Execute"; referências de maturity atualizadas; sync declaration adicionada a docs.        |
| Update Governance Docs to Reflect L4 Status     | High     | Not Started | `@documentation-steward` | governance-maturity-model.md, zero-inertia-command.md, ROADMAP.md mostram L4 como "In Progress"; timestamp e decision log adicionados. |
| Operationalize Locale Sync Validation in CI     | Medium   | Not Started | `@project-auditor`       | Novo step no marketplace-integrity.yml ou workflow; valida locale sync; bloqueia PR sem declaração válida; teste manual confirmado.    |

**Context**: Stabilizing Level 4 (Self-Auditable) by eliminating locale drift and automating sync validation. Post-N4 audit identified PT-BR gaps and automation missing. See [Mission File](.github/MISSIONS/roadmap-2026-05-26-sprint-n5-locale-sync.md) for details.

---

## ✅ Completed Work

### Sprint N4 Hardening (2026-05-12 to 2026-05-26)

- **Close Eval Coverage Gap for Core Agents** (High, Done): Cobertura suba de 78.6% para 100%; 6 evals criadas (AGFAC-01/02, IOA-01/02, RD-01/02) + 3 HIGH findings corrigidos.
- **Operationalize Continuous Governance Audit** (High, Done): Step `Governance Audit — Eval Coverage Report (PR)` adicionada a marketplace-integrity.yml; relatório em CI visível e acionável.
- **Activate Decision Memory Routine** (Medium, Done): MEMORY.md recebe 3 entradas (MEM-20260512-01/02/03) documentando decisões do sprint.

---

## 📝 Backlog (Future Sprints)

### Stack Expansion (Swift) — Deferred until Level 4 Stability (N6+)

- **Rationale**: Evitar dispersão antes da maturidade Self-Auditable consolidada.
- **Entry Gate**: Iniciar após 2 ciclos completos pós-L4 (N5 + N6) com zero regressões críticas em gates de missão/auditoria.

### Technical Documentation Automation (N6+)

- **Rationale**: Reduzir esforço manual recorrente em onboarding e manutenção documental.
- **Entry Gate**: Executar após N5 completo e locale sync automation validada em 2 ciclos.

---

## ✅ Completed Work

### Foundations (MVP 1.0.0 - 1.9.x)

- **Repository Onboarding** (`docs/en/examples/` + `library/examples/`): Multi-language walkthroughs demonstrating agent orchestration workflows for 3 distinct scenarios (Elite Shop, Enterprise Admin, Swift Booking).
- **Registry & Schema** (`registry.json` + `registry.schema.json`): Centralized asset catalog with strict validation; foundation for marketplace and marketplace-ready assets.
- **Core Standards** (`library/standards/`): 8 standards covering governance, security, testing, performance, documentation, design patterns, collaboration, and hardening.
- **Issue Operations** (`library/github-baseline/issue-templates/`): 5 templated strategies (Agile Scrum, Enterprise SAFe, Kanban DevOps, Minimalist, Open Source, Shape-Up) for diverse workflow styles.

---

## 🔧 Maintenance & Review Schedule

### Update Frequency

- **Current Sprint**: Updated at the start of each 2-week cycle by `@roadmap-steward` or designated PM.
- **Backlog**: Reviewed quarterly to reflect user feedback, emerging patterns, and technology shifts.
- **Completed Work**: Retained as historical record; only updated when major refactoring occurs.

### Review Process

1. **Automated Review**: Roadmap sync check runs in CI to validate consistency with `registry.json` and `structure.md`.
2. **Human Review**: At sprint planning, PM confirms sprint items align with user needs and engineering capacity.
3. **Stakeholder Input**: Issues tagged `roadmap-feedback` are collected and incorporated into next cycle.

---

## 📋 Manual Edit Policy

**When to edit manually:**

- Updating strategic direction (e.g., pivoting from 1.9.x to 2.1.x release line).
- Correcting factual errors in Completed or Backlog sections.
- Reflecting major architectural decisions (e.g., deprecating a standard).

**Process:**

1. Create an ADR (Architecture Decision Record) or issue documenting the change rationale.
2. Edit the relevant section, referencing the ADR in a comment.
3. Notify stakeholders via issue or discussion.
4. `@roadmap-steward` will validate changes on next sync run.

---

## 📚 Related Documentation

- **[Registry](registry.json)**: Full asset catalog with versions and metadata.
- **[Structure](structure.md)**: Directory organization and file purposes.
- **[Memory](MEMORY.md)**: Project lessons learned and conventions.
- **[Copilot Instructions](.github/copilot-instructions.md)**: Mandatory workflow for changes.
