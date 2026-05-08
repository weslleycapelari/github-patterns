# Example 08 — Quality, OpenAPI, and CI Gates

## Goal

Close the track with operational quality, covering tests, static validation, OpenAPI consistency, and CI quality gates aligned with the domain.

## Step context

After domain modeling, availability, workflow, and concurrency hardening, this step turns the scenario into a fuller engineering track, ready for continuous integration and consumption by other teams.

## Expected inputs

- chosen test suite;
- lint and type-checking tools used in the project;
- key endpoints that require documentation and examples;
- job/check names that should protect merges.

## Prompt

```text
Asset contract: SB-CORE (see this directory's README.md, section "Prompt Asset Contract"). Step delta: align quality gates with branch-governance checks.
Project: Swift-Booking
Current state: domain, availability, reservation flow, and concurrency hardening are already structured.

FINAL TASK
Close the package with engineering quality and readiness for continuous integration.

CONSTRAINTS
- Stack remains Python 3.11 + FastAPI + SQLAlchemy + Alembic.
- Type hints are mandatory and verified.
- The API must remain coherent with OpenAPI.
- The CI pipeline must reflect real and useful quality gates.
- Include validation for concurrency and contract regressions, not just trivial tests.

SCOPE
1) Automated tests
   - unit tests for services and critical rules
   - integration tests for main endpoints
   - error scenarios
   - tests directed to concurrency/duplication/idempotency where applicable

2) Static quality
   - lint
   - type checking
   - import/structure validation
   - minimum style and quality consistency

3) OpenAPI and documentation
   - review schemas, examples, and descriptions
   - ensure responses and errors are coherent
   - document main endpoints and critical flows
   - include an operational summary on how to run, migrate, and validate the application

4) CI quality gates
   - pipeline for lint + type check + tests
   - mandatory failure on regression
   - validation of Alembic/migrations
   - clear job/check names compatible with branch protection governance

5) Final summary
   - what is covered
   - what is still residual risk
   - which checks should be required on the main branch
   - how the whole track now connects from onboarding to final quality

OUTPUT CRITERIA
- no generic checklist; provide project-applicable deliverables
- highlight safe concurrency coverage
- highlight coherence between API, OpenAPI, and CI
- highlight which quality gates should protect merges
```

## Expected generated artifacts

- more robust automated test suite;
- static validation setup;
- reviewed OpenAPI surface;
- CI pipeline with clear jobs and checks;
- operational summary for running and validating the application.

## Expected result

- complete track with explicit operational quality;
- coverage for happy path, errors, and concurrency;
- OpenAPI and CI aligned with API contracts;
- quality gates compatible with branch protection.

## Execution checklist

- [ ] Confirm test coverage for happy path, errors, and concurrency.
- [ ] Verify lint and type checking as real gates.
- [ ] Review examples and responses in OpenAPI.
- [ ] Ensure check names stay consistent with main-branch governance.

## Acceptance criteria

- Tests cover core cases and relevant risks.
- Lint, type checking, and tests are present in the pipeline.
- OpenAPI stays coherent with the expected implementation.
- CI is ready to protect merges.
- Final summary connects onboarding, governance, implementation, and quality.

## Common mistakes

- Building a generic CI that does not reflect domain risks.
- Leaving OpenAPI outdated compared to real endpoints.
- Skipping concurrency from the most critical tests.
- Using check names incompatible with the main branch Ruleset.

## Next step

Use this full track as the basis for roadmap planning, technical backlog, or the initial setup of a real reservation project.
