# Enterprise Admin Panel — Example 05: hardening the React Query data layer

## Goal

Turn the `React Query` decision into a consistent operational strategy for caching, invalidation, retries, async states, and typed hooks.

## Step context

After the ADR and the first component, the next risk is every screen using React Query differently. In a corporate dashboard, that turns into inconsistent UX, unpredictable cache behavior, and bugs that are painful to diagnose.

## Expected inputs

- main dashboard endpoints;
- shared request/response types;
- minimum retry and stale-time policy;
- convention for error handling and visual feedback.

## Prompt

```text
Copilot, harden the React Query data layer for this enterprise admin panel.
Define a practical pattern for typed query hooks, cache keys, staleTime, retries, invalidation, and error handling.
Keep it consistent with the ADR that chose React Query over Redux and with a dashboard UX that must remain predictable.
```

## Expected generated artifacts

- query-key and invalidation pattern;
- typed hooks by domain or resource;
- explicit policy for cache, retry, stale, and refetch behavior;
- convention for loading, skeleton, error, and empty states.

## Expected result

The project gains a data layer with:

- predictable behavior across screens;
- less duplication of async logic;
- compatibility with performance, observability, and corporate UX expectations.

## Execution checklist

- [ ] Define query-key conventions before multiplying hooks.
- [ ] Make explicit when to use query, mutation, and invalidation.
- [ ] Review whether retries make sense for authorization or validation failures.
- [ ] Ensure async states align with the design system.

## Acceptance criteria

- The proposed pattern does not depend on Redux for remote-state control.
- Query keys, invalidation, and retries follow clear criteria.
- Typed hooks reduce duplication and ambiguity.
- The result is reusable across future dashboard modules.

## Common mistakes

- Giving everything the same `staleTime` without considering data volatility.
- Over-refetching and blaming React for the re-renders.
- Mixing server state and purely local UI state without boundaries.

## Next step

Move to `06-phase-d-pii-security-hardening.md` to apply security controls focused on PII and access boundaries.
