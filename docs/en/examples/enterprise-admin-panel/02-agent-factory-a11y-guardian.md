# Enterprise Admin Panel — Example 02: creating the A11y-Guardian agent

## Goal

Create an accessibility specialist agent that reviews React components with clear operating criteria, instead of a generic agent that sounds nice and helps very little.

## Step context

The scenario requires WCAG 2.2. In corporate dashboards, focus, keyboard navigation, contrast, and semantic issues tend to appear early and multiply quickly. Creating a dedicated specialist reduces regressions and improves the quality of future reviews.

## Expected inputs

- already-initialized project context;
- expected `.agent.md` file pattern;
- multi-agent collaboration rules;
- policy for registering new agents/assets in the target project.

## Prompt

```text
Asset contract: EAP-CORE (see this directory's README.md, section "Prompt Asset Contract"). Step delta: explicitly use `@agent-factory` plus collaboration standard.
Use @agent-factory to create a new agent called 'A11y-Guardian'.
It must specialize in accessibility review for React components,
following docs/standards/ai-collaboration.md.
Register it in the local registry.json.
```

## Expected generated artifacts

- `A11y-Guardian` file under `.github/agents/`;
- clear mission, workflow, anti-patterns, and output contract;
- specialist behavior focused on React + real accessibility concerns, not vague review language;
- coherent update to the target project's `registry.json`.

> Mapping note: in the marketplace, the source of truth for collaboration lives in `library/standards/ai-collaboration-governance.md`. In the target project, it may appear as `docs/standards/ai-collaboration.md` or equivalent.

## Expected result

The project gains a specialist that can:

- review React components with WCAG 2.2 in mind;
- return findings by severity with verifiable evidence;
- guide fixes without invading design-system, security, or product scope.

## Execution checklist

- [ ] Verify frontmatter with `name` and `description`.
- [ ] Ensure the agent includes Primary Intent, Workflow, Anti-Patterns, and Output Contract.
- [ ] Confirm the examples and rules are specific to React components.
- [ ] Validate that the local registry entry is resolvable and consistent.

## Acceptance criteria

- The agent is not described as merely “helping with accessibility”; it defines auditable outputs.
- The expected handoff for reviews includes mission, context, constraints, and expected output.
- The local registry points to a valid path and uses a coherent format.
- The agent does not promise destructive actions or automations outside review scope.

## Common mistakes

- Creating an accessibility agent without mentioning React, WCAG, or evidence types.
- Registering the agent without consistent naming, description, and path.
- Mixing security auditing and accessibility auditing into the same agent.

## Next step

Move to `03-datachart-performance-component.md` to apply performance standards while building the dashboard's first rich component.
