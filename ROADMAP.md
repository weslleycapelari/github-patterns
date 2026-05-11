# Repository Evolution Roadmap

> This file is maintained by the `@roadmap-steward` agent. Do not edit manually unless updating strategic direction. See [Manual Edit Policy](#manual-edit-policy) below.

## 🗓️ Current Sprint (MVP 1.9.x → 2.0.0)

| Task                                           | Priority | Status      | Acceptance Criteria                                               |
| ---------------------------------------------- | -------- | ----------- | ----------------------------------------------------------------- |
| Implement Mission Protocol (Automatic Handoff) | High     | Not Started | Mission file gate enforced in all agents; delegation audit passes |
| Create Evals for Laravel Stack                 | Medium   | Not Started | ≥3 eval cases per standard (security, performance, design)        |
| Automate Locale Sync via GitHub Action         | Low      | Not Started | Sync runs on doc change; pt-br/en consistency verified in CI      |

**Context**: These sprints build on [foundations](#completed-work) and advance toward version 2.0 governance model.

---

## 📝 Backlog (Future Sprints)

### Swift Stack Support (iOS)

- **Rationale**: Expand beyond web/backend to native mobile; complements Laravel stack for full-stack teams.
- **Impact**: Unlock use cases requiring iOS expertise; improve platform diversity.

### Front-end Performance Audit Agent

- **Rationale**: Laravel expert and Vue architect exist; performance auditing closes visibility gap on metrics (Core Web Vitals, bundle size, rendering).
- **Impact**: Enable teams to catch performance regressions early; complements existing security and reactivity agents.

### Automated Technical Documentation Generator

- **Rationale**: Registry and standards exist; auto-generating job descriptions, API docs, and onboarding guides reduces manual overhead.
- **Impact**: Improve DX for teams adopting the repository; reduce context switching during hiring.

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
