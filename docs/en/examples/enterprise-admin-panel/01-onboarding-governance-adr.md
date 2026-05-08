# Enterprise Admin Panel — Example 01: governance onboarding + initial ADR

## Goal

Start the project with strong governance from the beginning and formally record the architectural decision to use `React Query` instead of `Redux`.

## Step context

The scenario describes a corporate admin panel with compliance, monitoring, and multiple access levels. In this kind of project, the data-layer decision is not a detail: it affects complexity, cache predictability, front-end ergonomics, and long-term architectural durability.

## Expected inputs

- project name;
- repository URL, if it already exists;
- repository visibility;
- desired GitHub 100% phases;
- main team OS;
- conflict policy for existing files.

## Prompt

```text
Act as Repo Architect.
Configure this Dashboard project.
Beyond the baseline, inject agent-factory into .github/agents/.
Create an ADR using the pattern from docs/standards/documentation.md
explaining why React Query was chosen over Redux for this project.
```

## Expected generated artifacts

- phase-based onboarding proposal;
- assets resolved from `registry.json`;
- bootstrap plan with installation guidance;
- initial ADR comparing React Query vs Redux;
- CI baseline and clear next-step guidance.

> Mapping note: in the marketplace, the source of truth for ADR guidance lives in `library/standards/documentation-adr.md`. In the target project, it may be materialized as `docs/standards/documentation.md`.

## Expected result

By the end of this step, the project should move from “front-end without operational context” to a state with:

- a governance path defined by phases;
- documented rationale for the remote-data approach;
- readiness to evolve into specialist agents and stronger security controls.

## Execution checklist

- [ ] Confirm the main stack resolves to `Node.js & TypeScript` in the registry.
- [ ] Ensure `agent-factory` is explicitly included in the plan.
- [ ] Verify the ADR records context, decision, alternatives, and consequences.
- [ ] Confirm the proposal does not drift into dashboard business code.

## Acceptance criteria

- The onboarding follows the `Repo Architect` flow and does not invent assets outside `registry.json`.
- The ADR covers a single decision: `React Query` vs `Redux`.
- Trade-offs around performance, complexity, and ergonomics are explicit.
- There is a clear operational next step after bootstrap.

## Common mistakes

- Skipping the ADR and simply “assuming” React Query.
- Mixing Redux Toolkit, Zustand, and React Query into one unfocused decision.
- Asking `Repo Architect` to generate dashboard business code, which is outside its scope.

## Next step

Move to `02-agent-factory-a11y-guardian.md` to create the accessibility specialist agent that will support continuous React component review.
