# Repository Evolution Roadmap

> This file is maintained by the `@roadmap-steward` agent. Do not edit manually unless updating strategic direction. See [Manual Edit Policy](#manual-edit-policy) below.

## 🗓️ Current Sprint (MVP 1.9.x → 2.0.0)

| Task                                          | Priority | Status      | Acceptance Criteria                                                                                                                                     |
| --------------------------------------------- | -------- | ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Enforce Mission Protocol + Traceability Gate  | High     | Not Started | 100% dos PRs não triviais exigem Mission File válido em `.github/MISSIONS/` com campos exatos do protocolo; merge bloqueado quando ausente ou inválido. |
| Continuous Governance Audit (Project Auditor) | High     | Not Started | Auditor roda em todo merge para `main`, publica relatório com severidade e sinais de observabilidade; 0 artefatos órfãos na execução do gate.           |
| Evals Coverage for Major Agents (≥80%)        | Medium   | Not Started | Cobertura de evals ≥80% por agente majoritário (ao menos 1 suíte por agente); PR falha quando cobertura cair abaixo do baseline aprovado.               |

**Context**: These sprints build on [foundations](#completed-work) and advance toward version 2.0 governance model.

---

## 📝 Backlog (Future Sprints)

### Stack Expansion (Swift) — Deferred until Level 4 Stability

- **Rationale**: Evitar dispersão antes da maturidade Self-Auditable.
- **Entry Gate**: Somente iniciar após 2 ciclos de sprint com gates de missão/auditoria estáveis e sem regressão crítica.

### Locale Sync Automation (en ↔ pt-br)

- **Rationale**: Reforçar qualidade documental após estabilização dos gates de governança.
- **Entry Gate**: PR deve manter declaração de sync (`en_status`, `pt_br_status`, `pending_sync_tasks`) validada em CI.

### Technical Documentation Automation

- **Rationale**: Reduzir esforço manual recorrente em onboarding e manutenção documental.
- **Entry Gate**: Executar somente após cobertura de evals ≥80% sustentada por 2 ciclos.

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
