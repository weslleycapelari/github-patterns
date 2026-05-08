# Documentation And ADR

## Objective

Ensure project longevity through decision-making, historical, and operational documentation that survives changes in people, tools, and agents.

This standard defines:

- when a decision deserves an ADR;
- how to record context, alternatives, trade-offs, and consequences;
- how to maintain a useful llms.txt index for agents and LLMs;
- how to maintain a consistent, readable, and automatable CHANGELOG without turning it into a commit dump.

## Non-Negotiable Principles

1. Every relevant architectural decision must be recorded while it is still fresh.
2. An ADR records a single decision and its rationale, never a generic diary.
3. The project history must be human-readable first and automatable second.
4. All AI documentation must be short, curated, and point to canonical sources.
5. CHANGELOG does not replace ADR and ADR does not replace CHANGELOG.
6. Code is only self-documenting when behavior and intention are clear without an additional explanatory comment.

## When To Create An ADR

Creating an ADR is not bureaucracy. It is protection against repeated debate, loss of context, and contradictory decisions over time.

### Always: Create An ADR When

- Whenever a decision changes architecture, boundaries, contracts, core technology, or operational strategy.
- Whenever there is a relevant trade-off between performance, security, cost, maintainability, or delivery speed.
- Whenever the team rejects a plausible alternative and that rejection needs to be made explicit.
- Whenever the decision impacts multiple modules, teams, deploy flows, or external integrations.
- Whenever the absence of the rationale would force future people to relitigate the same problem from scratch.

### Never: Do Not Create An ADR When

- Never for trivial local implementation details.
- Never to record aesthetic preferences with no architectural impact.
- Never to duplicate a decision that is already recorded and still valid.
- Never to hide indecision; if no decision has been made yet, record the problem in the backlog, not as an accepted ADR.

### ADR Triggers

Creating an ADR is mandatory when any of these triggers applies:

1. adoption or replacement of a framework, database, broker, cache, or primary protocol;
2. structural decision between monolith, modularization, microservices, or event-driven;
3. definition of authentication, authorization, observability, or resilience strategy;
4. change to the public API contract, data schema, or versioning policy;
5. choice of operational standard for AI, automation, or agent governance.

## ADR Lifecycle

### Status Model

Every ADR must declare a single status:

- Proposed
- Accepted
- Superseded
- Deprecated
- Rejected

### Lifecycle Rules

- Proposed records a decision under evaluation.
- Accepted records a decision currently in force.
- Superseded explicitly points to the ADR that replaced the decision.
- Deprecated indicates a decision that still exists but is being phased out.
- Rejected records an analyzed and refused alternative when that prevents future rework.

## ADR Writing Standard

Following the pattern popularized in the ADR ecosystem, each record must capture an architectural decision with context, decision, alternatives, and consequences.

### Always: ADR Structure

- Always use one file per decision.
- Always number ADRs in a stable, ascending order.
- Always describe context and problem before the decision.
- Always make alternatives considered explicit.
- Always record positive consequences, negative consequences, and residual risks.
- Always link related ADRs, tickets, and canonical documents.

### Never: ADR Structure

- Never mix multiple independent decisions in the same ADR.
- Never record only the conclusion without the rationale.
- Never leave an Accepted ADR without consequences or trade-offs.
- Never delete an old ADR; replace it with a new ADR and mark the previous one appropriately.

## Ready To Use ADR Template

```md
# ADR-0001: <short decision title>

- Status: Proposed
- Date: 2026-05-07
- Deciders: <team or names>
- Technical Story: <issue, epic, incident, or PR link>

## Context

Describe the problem, constraints, forces, and architecturally significant requirements.
Explain what is changing, what hurts today, and what must remain true.

## Decision

State the decision in direct language.
Describe the chosen option and the scope where it applies.

## Alternatives Considered

### Option A: <name>

- Pros:
- Cons:

### Option B: <name>

- Pros:
- Cons:

## Consequences

### Positive

-

### Negative

-

### Risks

-

## Implementation Notes

- Migration steps:
- Rollback strategy:
- Observability and test impact:

## Related Records

- Supersedes:
- Superseded by:
- Related ADRs:
```

## ADR Quality Checklist

Before accepting an ADR, validate:

1. Is the problem clear without depending on an external oral conversation?
2. Is there a single main decision in the document?
3. Does the rationale explain why the chosen option beat the others?
4. Were the relevant alternatives recorded?
5. Are the negative consequences and risks explicit?
6. Does the ADR point to related artifacts and the correct status?

## Self-Documenting Code

Self-documenting code reduces the need for low-value comments, but does not eliminate the need for ADR, changelog, and boundary documentation.

### Always: Self-Documenting Code

- Always use names that reveal intention, domain, and effect.
- Always decompose dense flows into functions with clear responsibility.
- Always make public contracts explicit through types, DTOs, and envelopes.
- Always document architectural decisions outside the code when the reason cannot be recovered by reading the implementation.

### Never: Self-Documenting Code

- Never use "readable code" as an excuse to avoid recording an architectural decision.
- Never hide important trade-offs in scattered comments.
- Never rely on the PR history as permanent documentation.

## llms.txt Standard

The llms.txt file exists to provide a curated, short, and navigable view of the project's canonical knowledge for agents and LLMs at inference time.

### llms.txt Rules

- Always maintain an llms.txt at the applicable documentary root of the project.
- Always start with an H1 containing the project name.
- Always include a short blockquote with essential context.
- Always organize links in H2 sections with clear descriptions.
- Always point to canonical markdown sources, not to ambiguous or transitory pages.
- Always use an Optional section for secondary material that can be omitted in short context.

### llms.txt Minimum Structure

```md
# Project Name

> Short expert summary of what this project is, how it should be interpreted, and what an agent must know first.

Important notes:

- Canonical source of truth is registry.json.
- Standards live under library/standards/.
- Operational instructions live under library/instructions/.

## Core Docs

- [README](./README.md): Project overview and adoption path.
- [Registry](./docs/en/registry.md): Machine-readable catalog contract.

## Standards

- [Architecture Patterns](./library/standards/architecture-patterns.md): Layering, SOLID, DI, response envelope.
- [Testing Excellence](./library/standards/testing-excellence.md): TDD, AAA, doubles, boundary testing.

## Optional

- [Structure](./structure.md): Expanded repository snapshot for deep navigation.
```

### Never: llms.txt

- Never turn llms.txt into a full mirror of the site or repository.
- Never list links without a useful description.
- Never use llms.txt to replace README, ADR, or reference documentation.
- Never point to content that is known to be obsolete.

## CHANGELOG Automation

The CHANGELOG must follow Keep a Changelog: human-oriented, in reverse chronological order, with an Unreleased section at the top and stable categories.

### Required Format

- File name: CHANGELOG.md
- Order: most recent version first
- Date: ISO 8601
- Standard categories:
  - Added
  - Changed
  - Deprecated
  - Removed
  - Fixed
  - Security

### Always: CHANGELOG

- Always maintain an Unreleased section at the top.
- Always group changes by type.
- Always record only notable changes.
- Always promote Unreleased to a version on release.
- Always align versioning with Semantic Versioning when applicable.
- Always derive automatic notes from Conventional Commits, but review the final text manually.

### Never: CHANGELOG

- Never dump raw git log into the CHANGELOG.
- Never mix operational noise with changes relevant to users or maintainers.
- Never omit deprecated and removed entries when there is an upgrade impact.
- Never publish a release without moving items from Unreleased.

### Automatic Changelog Rules

To keep automatic generation predictable:

1. commits must follow Conventional Commits;
2. the pipeline must map types to CHANGELOG sections;
3. breaking changes must appear explicitly in Changed, Deprecated, or Removed;
4. Security items must be preserved as their own category;
5. automation generates the draft, but final publication requires human curation.

### Keep A Changelog Template

```md
# Changelog

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog,
and this project adheres to Semantic Versioning.

## [Unreleased]

### Added

-

### Changed

-

### Deprecated

-

### Removed

-

### Fixed

-

### Security

-

## [1.0.0] - 2026-05-07

### Added

- Initial release.
```

## Review Checklist

Before approving the project's documentation discipline, validate:

1. Does every relevant recent architectural decision have an ADR?
2. Do ADRs have the correct status and supersession links?
3. Does llms.txt point to current and canonical sources?
4. Does the CHANGELOG use Unreleased and standardized categories?
5. Is the history comprehensible to humans without opening dozens of PRs?
6. Would the project remain intelligible to a new person or a new agent 12 months from now?

## Enforcement

If a decision changes the architecture and generates no documentary trail, the project is accumulating cognitive debt.

If the CHANGELOG has become a commit diff, it has failed as a communication instrument.

If llms.txt does not point to canonical and concise knowledge, it has failed as an AI index.
