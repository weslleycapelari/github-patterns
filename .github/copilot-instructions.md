# GitHub Patterns - Copilot Operating Instructions

## Mission

This repository is AI-first. Every meaningful change must be designed, reviewed, and improved through subagent-driven workflows. Copilot must behave as an engineering system, not as a one-pass generator.

## Mandatory Workflow

For any change to agents, prompts, documentation, registry, schema, stacks, instructions, standards, workflows, or templates, follow this sequence:

1. **Discover**: read relevant files and current conventions.
2. **Develop (Subagent)**: generate or modify artifact drafts.
3. **Review (Subagent)**: run independent critique focused on correctness and risks.
4. **Improve (Subagent or Main Agent)**: apply findings and close gaps.
5. **Validate**: run lint/schema/tests relevant to the artifact.
6. **Summarize**: report decisions, risks, and next actions.

Do not skip the Review step.

## Iteration Policy

- Use at least one review iteration for every non-trivial change.
- If review finds major issues, iterate again.
- Stop only when artifacts pass objective checks and review findings are resolved or explicitly accepted.

## Subagent Usage Policy

- Prefer specialized subagents for generation and review.
- Use nested subagents when scope spans multiple disciplines (for example: architecture + security + docs).
- Keep subagent prompts explicit about input, expected output, constraints, and acceptance criteria.
- Never claim a subagent executed actions it did not execute.

## Subagent Invocation Model

- Invoke specialized subagents explicitly for Draft and Review stages.
- Treat the review subagent as independent from the draft subagent.
- When review findings are critical, run an Improve iteration and re-run review before finalization.

## Terminology

- **Artifact**: any file being created or modified.
- **Asset**: a registry-managed artifact with ID, path, version, and metadata.

## Quality Gates by Artifact

### Agent Files (.agent.md)

- Include frontmatter with `name` and `description`.
- Include: Primary Intent, Adaptive Questioning, Workflow, Anti-Patterns, Quality Bar, Output Contract.
- Keep steps testable and procedural.
- Avoid vague verbs like "help" without measurable outputs.

### Prompt Files (.prompt.md)

- Include objective, context, input contract, workflow, expected output.
- Include at least one concrete usage example.
- Include guardrails for sensitive or destructive actions.

### Documentation (README, docs/en, docs/pt-br)

- Keep source-of-truth references accurate.
- Prefer task-oriented guidance over abstract prose.
- When behavior changes, update docs in the same change set.

### Registry (registry.json)

- Keep IDs unique and kebab-case.
- Keep paths resolvable and repository-relative.
- Keep semver versions valid.
- Keep `lastUpdated` current on meaningful catalog updates.
- Ensure stacks, phases, and assets remain logically consistent.

### Schema (docs/schemas/registry.schema.json)

- Use JSON Schema draft 2020-12.
- Prefer reusable `$defs` to avoid redundancy.
- Keep validation strict but practical.
- Ensure schema matches the actual registry structure.

### Standards / Instructions / Stacks

- Standards must be enforceable and explicit.
- Instructions must be concise, imperative, and measurable.
- Stack assets must define technology scope, constraints, and expected outputs.

## Validation Requirements

When touching registry or schema:

1. Validate JSON syntax.
2. Validate `registry.json` against `registry.schema.json`.
3. Check referenced paths exist.

When touching agents/prompts/docs:

1. Run structural review with a subagent.
2. Check consistency with existing repository tone and conventions.
3. Confirm no overclaim in operational promises.

## Security and Safety Rules

- Never expose secrets or credentials.
- Never invent command results.
- Never apply destructive actions without explicit user approval.
- Always document assumptions and residual risk.

## Error and Observability Standards

When operating with subagents, follow:

- `.github/standards/agent-error-contract.md`
- `.github/standards/agent-observability.md`

At minimum, include a compact decision log for non-trivial changes.

## Change Documentation Rule

For substantial edits, include in final report:

- What changed
- Why it changed
- What was validated
- Remaining risks or next steps

## Preferred Agent Roles for This Repository

- **Creator**: builds draft artifacts.
- **Reviewer**: critiques for correctness and risk.
- **Refiner**: applies remediation and quality improvements.
- **Registrar**: verifies registry/schema coherence.

These roles may be implemented by dedicated `.github/agents` files.

## Definition of Done

A task is done only when:

- Required subagent cycles were executed.
- Artifacts pass validations.
- Documentation and registry coherence are preserved.
- Final output is actionable and auditable.
