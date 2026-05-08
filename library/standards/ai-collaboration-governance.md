# AI Collaboration Governance

## Objective

Define how agents collaborate with each other and with humans without losing context, without crossing security boundaries, and without degrading the operational coherence of the repository.

This standard defines:

- how the parent agent delegates work to specialist agents;
- how to preserve relevant context without inflating noise;
- how to use AI-REFERENCE comments in a controlled way;
- how to apply human-in-the-loop to destructive, irreversible, or sensitive operations.

## Non-Negotiable Principles

1. The parent agent remains responsible for the final result, even when it delegates execution.
2. Every handoff must transfer enough context for correct action, but not superfluous context.
3. No agent may execute a destructive action without an explicit human approval gate when there is material risk.
4. AI-REFERENCE comments exist to preserve recurring patterns, never to replace canonical documentation.
5. Delegation without an input, output, and success criterion contract is defective delegation.
6. Contradictory context must be resolved or escalated; never masked.

## Agentic Workflow Model

The operational model is simple:

1. the parent agent receives the objective;
2. the parent agent identifies the work slice;
3. the parent agent delegates specialized parts with an explicit contract;
4. the child agent returns a focused result;
5. the parent agent validates, integrates, corrects inconsistencies, and responds to the human.

Delegating is not outsourcing judgment. The parent agent remains the integrator and the single point of accountability.

## Sub-Agent Handoff

Handoff is the deliberate transfer of a problem to a specialist agent with scope, inputs, and expected output clearly defined.

### Always: Handoff

- Always declare the specific objective of the delegation.
- Always include relevant files, symbols, constraints, and minimum necessary context.
- Always state whether the sub-agent must research, edit, validate, or only review.
- Always define the expected return format.
- Always validate the sub-agent's return before acting on it.

### Never: Handoff

- Never delegate an ambiguous objective like "look at this" or "improve everything".
- Never send too much raw context when only a local slice matters.
- Never assume the sub-agent will inherit implicit intent.
- Never pass a sub-agent's response to the user without curation by the parent agent.

### Parent Handoff Contract

Every handoff must contain, at minimum:

1. objective mission;
2. necessary local context;
3. constraints and anti-objectives;
4. expected type of work;
5. output format.

### Handoff Template

```text
SUB-AGENT HANDOFF
Mission:
Context:
Relevant files or symbols:
Constraints:
Do not:
Expected output:
```

### Good Handoff Example

```text
SUB-AGENT HANDOFF
Mission: Review library/standards/testing-excellence.md for redundancy and missing boundary-testing rules.
Context: The file was expanded to define TDD, AAA, doubles and checklist-based validation.
Relevant files or symbols: library/standards/testing-excellence.md
Constraints: Do not edit files. Focus on editorial redundancy and policy gaps only.
Do not: Suggest style changes unrelated to testing discipline.
Expected output: A short list of findings ordered by severity, or explicit confirmation that no material redundancy was found.
```

## Parent Agent Responsibilities

The parent agent must:

- correctly decompose the problem;
- decide when delegation adds real value;
- consolidate conflicting responses;
- preserve coherence with repository instructions, registry, and already accepted standards;
- trigger the human gate when operational risk demands it.

The parent agent must never treat the sub-agent as an uncontestable final authority.

## Child Agent Responsibilities

The child agent must:

- operate strictly within the received scope;
- return an objective, auditable, contract-oriented response;
- signal gaps, ambiguities, and limitations instead of inventing context;
- avoid expanding scope without explicit justification.

## AI-REFERENCE Comments

AI-REFERENCE comments exist to mark local patterns that agents must safely repeat, especially in sections where the architectural reason is not obvious from isolated reading.

### Allowed Forms

```ts
// AI-REFERENCE: Use response envelope helpers for every public API handler.
// AI-REFERENCE: This repository prefers constructor injection over service locators.
// AI-REFERENCE: Keep this query batched to prevent N+1 on order list endpoints.
```

### Always: AI-REFERENCE

- Always use AI-REFERENCE only when the annotation prevents a recurring regression or costly relearning.
- Always write the rule in short, imperative, and verifiable language.
- Always point to a stable repository pattern, not to a temporary or personal decision.
- Always keep the comment close to the point where correct repetition matters.

### Never: AI-REFERENCE

- Never use AI-REFERENCE to explain trivial code.
- Never turn AI-REFERENCE into a substitute for ADR, README, or canonical instructions.
- Never use AI-REFERENCE to record a secret, sensitive data, or private context.
- Never spread redundant comments with the same instruction throughout the code.

### Good vs Bad: AI-REFERENCE

```ts
// Bad
// AI-REFERENCE: variable declaration here
const isActive = user.status === 'ACTIVE';
```

```ts
// Good
// AI-REFERENCE: Keep this authorization check in the controller boundary.
if (!currentUser.permissions.includes('billing:read')) {
  throw new ForbiddenError('Missing billing:read permission');
}
```

## Human-In-The-Loop

Human-in-the-loop is mandatory whenever the agent is close to causing loss, exposure, unavailability, or a broad and hard-to-reverse change.

### Mandatory Approval Gates

Explicit human approval is required before:

1. deleting or overwriting files in batch;
2. executing destructive or irreversible commands;
3. applying changes to credentials, permissions, security policies, or branch protection;
4. publishing, deploying, merging, or rotating sensitive assets;
5. altering production data or any equivalent environment.

### Always: Human-In-The-Loop

- Always pause and ask for confirmation when the impact exceeds a reversible local edit.
- Always explain risk, scope, and expected effect before requesting approval.
- Always offer a safe path when a non-destructive alternative exists.
- Always clearly record which human confirmation enabled the action.

### Never: Human-In-The-Loop

- Never execute a destructive action based on implicit assumption.
- Never interpret silence as approval.
- Never group distinct risk actions under a single vague confirmation.
- Never hide side effects to accelerate execution.

## Context Pruning

Context pruning exists to keep instructions, memory, and operational documentation lean, consistent, and useful.

### Always: Context Pruning

- Always preserve only context necessary for future decisions.
- Always remove or replace obsolete instructions when new rules supersede them.
- Always prefer a single canonical source per rule.
- Always summarize derived context when raw detail no longer adds value.

### Never: Context Pruning

- Never accumulate contradictory instructions.
- Never duplicate the same policy across multiple files without a clear reason.
- Never keep a temporary workaround as if it were a definitive standard.
- Never expand system memory with ephemeral details that have no future impact.

## Communication Protocol

The communication protocol between agents must follow this sequence:

1. Parent states the mission.
2. Parent defines scope, constraints and success criteria.
3. Child confirms through action, not chatter.
4. Child returns focused output.
5. Parent validates against repository policy and user intent.
6. Parent integrates and communicates final result.

If the child's return is incomplete, contradictory, or out of scope, the parent agent corrects, re-delegates, or escalates. It never forwards raw noise to the human as if it were a final answer.

## Review Checklist

Before approving an agent flow, validate:

1. Did the parent agent delegate only what truly required specialization?
2. Did the handoff contain mission, context, constraints, and expected output?
3. Did the child agent respond within scope?
4. Did the parent agent integrate and validate the return before acting?
5. Is there an explicit human gate for destructive or sensitive operations?
6. Are AI-REFERENCE comments rare, useful, and non-redundant?
7. Did the canonical context of the repository remain consistent after the flow?

## Enforcement

If a sub-agent receives a mission without a clear contract, the failure belongs to the parent agent.

If a destructive action occurs without explicit human approval, governance has failed.

If AI-REFERENCE replaces canonical documentation, the repository is accumulating operational noise.
