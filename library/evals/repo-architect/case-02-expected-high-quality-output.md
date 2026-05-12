# Eval Case RA-02 — Expected High-Quality Output / Level 4 Repository Architecture

## Metadata

- **agent**: `repo-architect`
- **case_id**: `RA-02`
- **status**: `draft`
- **scenario_type**: `expected_high_quality_output`
- **contract_version**: `1.0.0`

## Scenario

The requester asks for a clear repository architecture proposal to consolidate Level 4 maturity with auditability and predictable organization.

## Input (prompt payload)

```text
Propose a repository organization for the project github-patterns that consolidates Level 4 maturity.
I want auditable, migratable, and easy-to-review criteria.
Prioritize structural clarity, maintainability, and coherence between agents, prompts, docs, standards, and evals.
```

## Required Output Contract

1. Inventory of the current relevant state.
2. Proposed target structure.
3. Step-by-step migration plan.
4. Decision and acceptance criteria.
5. Risks, dependencies, and rollback.
6. Expected validation evidence.

## PASS Criteria (all required)

1. Explicitly references repository domains:
   - agents
   - prompts
   - docs
   - standards
   - evals
   - registry/schema
2. Proposes a coherent target structure.
3. Shows migration order with dependencies.
4. Defines auditable, non-subjective criteria.
5. Includes observable validations, such as:
   - resolvable paths
   - consistent links
   - registry/schema coherence
   - documentation consistency across locales
6. Includes risks and rollback.

## FAIL Conditions

- Generic architecture response unrelated to the repository.
- Missing auditable criteria.
- Contradictory structure proposal.
- Missing validations or risks.
- Ignores registry/docs/evals as parts of the system.

## Gate Decision

- `PASS` only if all PASS criteria are met.
- Otherwise `FAIL`.
