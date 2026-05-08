# Enterprise Admin Panel — Prompt Examples Pack

This directory separates, into dedicated files, the prompts used to start and evolve a corporate admin dashboard with the `github-patterns` marketplace.

## Scenario context

`Enterprise Admin Panel` represents a front-end product with strong durability and governance requirements from day one:

- multiple access levels and PII-sensitive data;
- WCAG 2.2 accessibility as a product requirement, not a retrofit;
- architectural decisions that must survive team turnover;
- strong performance discipline for dashboards and visualization-heavy components.

## Recommended order

1. [01-onboarding-governance-adr.md](01-onboarding-governance-adr.md)
2. [02-agent-factory-a11y-guardian.md](02-agent-factory-a11y-guardian.md)
3. [03-datachart-performance-component.md](03-datachart-performance-component.md)
4. [04-design-system-tailwind-foundation.md](04-design-system-tailwind-foundation.md)
5. [05-react-query-data-layer-hardening.md](05-react-query-data-layer-hardening.md)
6. [06-phase-d-pii-security-hardening.md](06-phase-d-pii-security-hardening.md)
7. [07-wcag-22-accessibility-audit.md](07-wcag-22-accessibility-audit.md)
8. [08-quality-monitoring-adr-commits-ci.md](08-quality-monitoring-adr-commits-ci.md)

## How to use

- Execute **one prompt at a time**.
- Wait for implementation to finish before moving to the next one.
- Reuse the same project context throughout the sequence.
- Use each file's acceptance criteria to confirm completion.

## Expected inputs for the full sequence

Before starting, it helps to have:

- project name and main stack;
- actual default branch (`main` or otherwise);
- intended charting library (`recharts`, `visx`, `nivo`, or similar);
- existing authentication/authorization policy and roles;
- a minimum definition of what counts as PII in the product;
- expected CI checks for lint, tests, accessibility, and build.

## Editorial convention

- Document in EN, with prompt blocks preserved in their original language when appropriate.
- The steps follow the real execution order of Scenario 3 in `README.md`.
- This pack focuses on initial governance, specialist agent creation, component performance, and operational hardening.
- Steps `01` to `03` cover the base scenario track.
- Steps `04` to `08` form an extended track for design system, data layer, security, accessibility, and quality.

## What each step produces

- `01-onboarding-governance-adr.md`: bootstrap proposal, initial ADR, and governance baseline.
- `02-agent-factory-a11y-guardian.md`: accessibility specialist agent and operating criteria.
- `03-datachart-performance-component.md`: `DataChart` component with clear separation between data-fetching and presentation.
- `04-design-system-tailwind-foundation.md`: Tailwind design system foundation for consistent dashboard growth.
- `05-react-query-data-layer-hardening.md`: cache/invalidation policy and typed hooks for corporate data flows.
- `06-phase-d-pii-security-hardening.md`: PII protection controls, masking, and access boundaries.
- `07-wcag-22-accessibility-audit.md`: WCAG 2.2 audit with prioritized remediation backlog.
- `08-quality-monitoring-adr-commits-ci.md`: quality gates, monitoring, ADR follow-up, and conventional-commit discipline.

## Execution checklist

- [ ] Confirm the default branch and actual checks before configuring governance.
- [ ] Define which architectural decision will be recorded in the initial ADR.
- [ ] Ensure `A11y-Guardian` has verifiable scope instead of generic wording.
- [ ] Measure re-render risk before optimizing `DataChart`.
- [ ] Validate PII and accessibility requirements using concrete UI examples.
- [ ] Close the track with CI and continuous-operation conventions.

## Common mistakes

- Treating accessibility as a late visual review only.
- Mixing fetch, transformation, and rendering responsibilities in the same component.
- Choosing React Query by habit without recording the decision and trade-offs.
- Talking about Phase D without mapping the product's truly sensitive data.
- Defining quality gates before confirming which checks will actually exist in the pipeline.

## Next steps

After this track, the natural path is to:

1. expand the dashboard with domain-oriented modules;
2. turn accessibility and security findings into a prioritized backlog;
3. materialize the standards in the target project to reduce future ambiguity;
4. add UX/performance observability in production with actionable alerts.

## Scope

The files below reflect a progressive track for a `React 18 + TypeScript` project, covering onboarding, ADR, specialist agent creation, component performance, design system, PII security, accessibility, and operational quality.
