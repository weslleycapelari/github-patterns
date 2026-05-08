# Enterprise Admin Panel — Example 07: WCAG 2.2 accessibility audit

## Goal

Run a practical accessibility audit for the panel, turning WCAG 2.2 requirements into prioritized findings and remediation actions.

## Step context

After creating `A11y-Guardian` and consolidating part of the visual foundation, it is time to verify whether the interface really works with keyboard navigation, visible focus, correct semantics, adequate contrast, and understandable feedback.

## Expected inputs

- scope of pages/components to audit;
- examples of critical screens (table, filters, modal, chart, form);
- internal severity criteria;
- preferred evaluation tools or approach (`axe`, manual checks, reader support, etc.).

## Prompt

```text
Copilot, run an accessibility-oriented review plan for this enterprise admin panel with WCAG 2.2 in mind.
Use the A11y-Guardian perspective to inspect keyboard navigation, focus management, semantics, contrast, chart accessibility, form feedback, and reusable component patterns.
Return findings by severity, with evidence, likely impact, and a prioritized remediation backlog.
```

## Expected generated artifacts

- audit report by severity;
- evidence or concrete examples per finding;
- prioritized remediation backlog;
- guidance for reusing fixes in the design system.

## Expected result

The ideal outcome is not merely “passing a checklist,” but rather:

- understanding where the panel fails in concrete terms;
- prioritizing fixes based on real impact;
- preventing the same mistakes from reappearing in new components.

## Execution checklist

- [ ] Cover keyboard navigation and focus order.
- [ ] Inspect semantics for tables, charts, and forms.
- [ ] Verify contrast and visible-focus states.
- [ ] Require actionable backlog, not generic observations.

## Acceptance criteria

- There are clear findings with severity, evidence, and impact.
- The report includes rich components, not only simple pages.
- Recommendations are compatible with React and the defined design system.
- The result helps the team prevent recurrence instead of only fixing local fires.

## Common mistakes

- Auditing only static pages and ignoring modals, filters, and charts.
- Producing a report without severity or backlog.
- Reducing accessibility to contrast while ignoring keyboard, focus, and semantics.

## Next step

Move to `08-quality-monitoring-adr-commits-ci.md` to close the track with monitoring, documentary discipline, and quality gates.
