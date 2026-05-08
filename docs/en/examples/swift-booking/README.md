# Swift-Booking — Prompt Examples Pack

This directory separates, into dedicated files, the prompts used to start and evolve a new hospitality project with the `github-patterns` marketplace.

## Scenario context

`Swift-Booking` represents a reservation system with typical operational reliability requirements:

- real-time availability consistency;
- main branch protection from day one;
- CI baseline to avoid silent regressions;
- audit of critical transactions with emphasis on concurrency and race conditions.

## Recommended order

1. [01-onboarding-governance.md](01-onboarding-governance.md)
2. [02-phase-b-branch-protection.md](02-phase-b-branch-protection.md)
3. [03-project-audit.md](03-project-audit.md)
4. [04-domain-model-alembic.md](04-domain-model-alembic.md)
5. [05-availability-search-api.md](05-availability-search-api.md)
6. [06-reservation-workflow-api.md](06-reservation-workflow-api.md)
7. [07-concurrency-hardening.md](07-concurrency-hardening.md)
8. [08-quality-openapi-ci.md](08-quality-openapi-ci.md)

## How to use

- Execute **one prompt at a time**.
- Wait for implementation to finish before moving to the next one.
- Reuse the same project context throughout the sequence.
- Use each file's acceptance criteria to confirm completion.

## Expected inputs for the full sequence

Before starting, it helps to have:

- project name and main stack;
- actual default branch (`main` or otherwise);
- expected CI checks, especially `ci/test`;
- administrative permissions to configure Rulesets;
- actual audit scope (`app/`, `src/`, `database/`, etc.).

## Editorial convention

- Document in EN, with prompt blocks preserved in their original language when appropriate.
- The steps follow the real execution order of Scenario 2 in `README.md`.
- This pack focuses on initial governance, branch protection, and architectural audit.
- Steps `01` to `03` cover the base scenario track.
- Steps `04` to `08` form an extended track for implementation, safe concurrency, and quality.

## What each step produces

- `01-onboarding-governance.md`: bootstrap proposal, phase assets, and CI baseline.
- `02-phase-b-branch-protection.md`: Ruleset definition, branch protection validation, and status-check alignment.
- `03-project-audit.md`: audit findings with severity, evidence, and remediation plan.
- `04-domain-model-alembic.md`: domain modeling, schemas, migrations, and initial service layer.
- `05-availability-search-api.md`: availability/search endpoints with useful OpenAPI.
- `06-reservation-workflow-api.md`: main reservation workflow with states and domain errors.
- `07-concurrency-hardening.md`: concurrency hardening, idempotency, and integrity strategy.
- `08-quality-openapi-ci.md`: tests, quality gates, reviewed OpenAPI, and operational CI.

## Execution checklist

- [ ] Confirm the default branch name before Phase B.
- [ ] Verify whether `ci/test` already exists or will be created in CI.
- [ ] Execute the steps in `01 → 02 → 03` order.
- [ ] Validate acceptance criteria before moving on.
- [ ] Adapt audit scope to the real project layout.

## Common mistakes

- Assuming every default branch is named `main`.
- Marking `ci/test` as required before confirming the exact job/check name.
- Running the audit without a clear scope.
- Mixing onboarding with deep customizations too early.

## Next steps

After this track, the natural path is to:

1. consolidate `Phase C` with the real project pipeline;
2. turn audit findings into a prioritized backlog;
3. execute the extended `04–08` track to move from governance into implementation + quality;
4. materialize standards in the target project to reduce future ambiguity.

## Scope

The files below reflect a progressive track for a `Python + FastAPI` project, covering governance, audit, modeling, core APIs, safe concurrency, and operational quality.
