# Enterprise Admin Panel — Example 04: Tailwind design-system foundation

## Goal

Consolidate a component-oriented design-system foundation so the admin panel can grow with visual, semantic, and operational consistency.

## Step context

After the first rich component, the next risk is a flood of ad hoc styles, spacing drift, inconsistent states, and visual decisions that nobody can reuse. In a corporate product, that increases maintenance cost and usually harms accessibility.

## Expected inputs

- desired visual theme;
- minimum token set for colors, typography, and spacing;
- current base-component convention;
- dark-mode policy, if any.

## Prompt

```text
Copilot, establish the initial Tailwind-based design system foundation for this enterprise admin panel.
Create a practical token and component strategy for layout, cards, tables, filters, badges, and status states.
Keep the system accessible, easy to scale, and aligned with WCAG 2.2 expectations.
Document the guardrails so future components stay visually and semantically consistent.
```

## Expected generated artifacts

- initial token and utility strategy;
- conventions for core dashboard components;
- criteria for visual states (`loading`, `empty`, `error`, `success`, `warning`);
- guardrails for accessibility consistency.

## Expected result

The project gains an explicit base for:

- predictable visual reuse;
- consistent semantics in recurring components;
- lower risk of divergence across teams and modules.

## Execution checklist

- [ ] Define minimum tokens before multiplying components.
- [ ] Cover the operational states most common in the dashboard.
- [ ] Include conventions that help tables and filters, not just pretty cards.
- [ ] Ensure accessibility is present in the guardrails from the beginning.

## Acceptance criteria

- There is a clear strategy for tokens, base components, and states.
- The result avoids becoming a design system too abstract to use.
- The guardrails help future `A11y-Guardian` reviews.
- The material is reusable across the rest of the track.

## Common mistakes

- Creating only a color palette and calling it a design system.
- Ignoring tables, filters, and feedback states, which are central to admin panels.
- Deferring accessibility until “after the components are ready.”

## Next step

Move to `05-react-query-data-layer-hardening.md` to harden the data layer in a way that remains consistent with the initial ADR.
