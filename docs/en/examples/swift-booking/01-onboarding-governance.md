# Example 01 — Onboarding and Initial Governance

## Goal

Start the `Swift-Booking` project with a Python/FastAPI stack, prioritizing phases A, B, and C and ensuring a CI baseline from the beginning.

## Scenario context

In this scenario, onboarding is not just a scaffolding step. It defines the collaboration, merge governance, and quality foundation for a project that handles reservations, availability, and concurrency-sensitive flows.

## Prerequisites

- Access to the `github-patterns` marketplace.
- Use of the `Repo Architect` agent.
- Prior definition of project name, stack, target phases, and operating system.

## Expected inputs

To get a better proposal, be clear about:

- final repository name;
- main stack (`Python/FastAPI`);
- desired phases (`A`, `B`, `C`);
- target operating system;
- initial file-conflict policy, if applicable.

## Prompt

```text
Asset contract: SB-CORE (see this directory's README.md, section "Prompt Asset Contract").
Act as Repo Architect.
Install the ecosystem for a Python/FastAPI project called 'Swift-Booking'.
Ensure phases A, B, and C are configured first, including ci-pipeline-base
to validate code on every commit.
```

## Expected generated artifacts

- asset proposal by phase;
- distinction between mandatory and recommended assets;
- explicit inclusion of `ci-pipeline-base`;
- bootstrap plan or ready-to-apply script for the target repository.

## Expected result

- Initial discovery of project context.
- Asset proposal for phases A, B, and C.
- Explicit inclusion of `ci-pipeline-base` in the plan.
- Bootstrap sequence ready for the target repository.

## Execution checklist

- [ ] Confirm onboarding stayed limited to phases `A`, `B`, and `C`.
- [ ] Verify that `ci-pipeline-base` appears in the final plan.
- [ ] Review whether assets were resolved from the marketplace catalog.
- [ ] Confirm the proposal separates collaboration, merge governance, and CI.

## Acceptance criteria

- Assets resolved from the marketplace catalog.
- Phases A, B, and C clearly differentiated.
- CI baseline included in the result.
- No hardcoded paths outside the repository model.

## Common mistakes

- Requesting onboarding without informing the target operating system.
- Expanding the scope to all phases when the scenario focuses on `A–C`.
- Accepting the proposal without reviewing phase separation.
- Ignoring whether the CI baseline actually appeared in the answer.

## Next step

After confirming bootstrap, continue to `02-phase-b-branch-protection.md` to harden merge governance for the main branch.
