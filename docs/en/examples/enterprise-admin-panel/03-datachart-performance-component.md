# Enterprise Admin Panel — Example 03: performance-oriented DataChart component

## Goal

Build the `DataChart` component with clear separation between data fetching and presentation, avoiding unnecessary re-renders and structural coupling that makes future evolution painful.

## Step context

Corporate dashboards degrade quickly when visual components accumulate fetching, transformation, local state, legends, filters, and rendering in the same place. The pattern here is to build something predictable, measurable, and consistent with KISS.

## Expected inputs

- intended charting library;
- main dataset shape;
- current hooks or query strategy;
- minimum performance criterion (for example, avoiding recomputation on every render).

## Prompt

```text
Asset contract: EAP-CORE (see this directory's README.md, section "Prompt Asset Contract"). Step delta: explicitly apply the performance standard.
Copilot, create the DataChart component.
Consult docs/standards/performance.md to ensure the component causes
no unnecessary re-renders.
Apply the KISS principle and separate data-fetching logic from presentation.
```

## Expected generated artifacts

- `DataChart` component focused on presentation;
- separate hook, adapter, or container for data fetching;
- typed and stable props;
- explicit strategy for memoization, derived data, and profiling.

> Mapping note: in the marketplace, the source of truth for performance lives in `library/standards/performance-scalability.md`. In the target project, it may be materialized as `docs/standards/performance.md`.

## Expected result

By the end of this step, the component should demonstrate:

- separation between data responsibility and UI;
- a predictable strategy to avoid wasteful rendering;
- a safe base for future filters, drill-down, and empty/error states.

## Execution checklist

- [ ] Separate fetch/transform logic from visual rendering.
- [ ] Avoid creating unnecessary arrays/objects/functions on each render.
- [ ] Confirm whether the dataset already arrives in the right shape or needs an adapter.
- [ ] Cover loading, empty, and error states without bloating the component.

## Acceptance criteria

- `DataChart` does not mix remote calls and rendering in the same main block.
- There is explicit justification for `memo`, `useMemo`, or the absence of both.
- The component avoids preventable re-renders caused by unstable props.
- The design follows KISS and remains readable for future evolution.

## Common mistakes

- Putting `useQuery` and all visual logic in the same file without boundaries.
- Using `useMemo` everywhere “just in case” without explaining the trade-off.
- Turning the component into a super-widget with multiple responsibilities.

## Next step

Move to `04-design-system-tailwind-foundation.md` to consolidate the visual and semantic foundation that the rest of the dashboard should grow from.
