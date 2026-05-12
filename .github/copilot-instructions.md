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

## Iteration and Subagent Execution Model

- For every non-trivial change, execute: Draft (specialized subagent) → Review (independent subagent) → Improve → Validate.
- If review finds major issues, iterate again until findings are resolved or explicitly accepted.
- Use nested subagents when scope spans multiple disciplines.
- Keep subagent prompts explicit about inputs, constraints, acceptance criteria, and expected outputs.
- Never claim a subagent executed actions it did not execute.

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

**Operational Prompts** (runnable commands):
- `.github/prompts/sync-locales.prompt.md` — Detect and sync semantic drift between docs/en/ and docs/pt-br/
- `.github/prompts/eval-coverage-sprint.prompt.md` — Execute sprint cycle to expand evaluation coverage (runnable as `/eval-coverage-sprint`)
- Additional operational prompts are listed in `ROADMAP.md` and referenced in `docs/en/zero-inertia-command.md`

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

### Documentation Locale Sync Gate (PR-Required)

For every Pull Request that changes any documentation file (`README*`, `docs/**`, `.github/**/*.md`, `library/**/*.md`), the PR description must include a mandatory locale sync declaration:

- `en_status`: `done` or `pending`
- `pt_br_status`: `done` or `pending`
- `pending_sync_tasks`: explicit list of remaining sync actions (use `[]` when none)

Acceptance rule (measurable):

- PR is non-compliant if this declaration is missing.
- PR is non-compliant if any status is `pending` without explicit `pending_sync_tasks`.

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

## Change Documentation and Definition of Done

For substantial edits, the final report must include:

- What changed
- Why it changed
- What was validated
- Remaining risks or next steps

A task is done only when:

- Required subagent cycles were executed.
- Artifacts pass validations.
- Documentation and registry coherence are preserved.
- Final output is actionable and auditable.

## Preferred Agent Roles for This Repository

- **Creator**: builds draft artifacts.
- **Reviewer**: critiques for correctness and risk.
- **Refiner**: applies remediation and quality improvements.
- **Registrar**: verifies registry/schema coherence.

These roles may be implemented by dedicated `.github/agents` files.
