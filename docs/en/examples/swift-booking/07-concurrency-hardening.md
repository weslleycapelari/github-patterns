# Example 07 — Concurrency and Integrity Hardening

## Goal

Reinforce the reservation flow against race conditions, overbooking, duplicate confirmations, and inventory/availability inconsistencies.

## Step context

This is the most sensitive point in the domain. Without an explicit concurrency strategy, the system may look correct locally and still fail under load, retries, or simultaneous operations.

## Expected inputs

- already known critical points in the reservation flow;
- database and transaction guarantees used by the project;
- expectations around idempotency and retries;
- minimum criteria to consider overbooking mitigated.

## Prompt

```text
You are hardening the "Swift-Booking" project, whose reservation API already exists.

OBJECTIVE
Review and reinforce the reservation flow to prevent race conditions, duplicate confirmations, and inventory/availability inconsistencies.

MANDATORY CONSTRAINTS
- Keep Python 3.11, FastAPI, SQLAlchemy, Alembic, and type hints.
- Treat concurrency as a central domain requirement.
- Do not solve this with vague comments; apply an explicit technical strategy.
- Every decision must consider transactional safety and behavior under simultaneous requests.
- If the strategy depends on the database, clearly document the guarantees being assumed.

TASK
Harden the reservation flow covering:

1) Review critical race points:
   - simultaneous reservation creation for the same inventory
   - repeated confirmation
   - cancellation/expiration competing with confirmation
   - request retries/resubmissions by clients or external integrations

2) Choose and implement an explicit integrity strategy appropriate for the project:
   - transactional locking
   - useful constraints
   - versioning/optimistic locking
   - idempotency keys
   - combination of approaches where necessary

3) Define service policies for:
   - idempotency in sensitive operations
   - conflict handling
   - stable client-facing error messages
   - safe rollback in partial failures

4) Reinforce modeling/documentation:
   - make clear what “available” means
   - specify which business invariants are protected
   - identify which operations require stronger isolation

5) Produce a final technical summary containing:
   - mitigated risks
   - remaining risks
   - strategy used
   - assumptions about database/isolation/transactions

IMPORTANT
If you find any overbooking or race condition risk, treat it as the highest priority and make explicit how the solution avoids the problem under real concurrency.
```

## Expected generated artifacts

- technical review of race-condition points;
- explicit transactional integrity strategy;
- idempotency and conflict-handling behavior;
- documentation of protected invariants;
- final summary with guarantees and limitations.

## Expected result

- reservation flow hardened against concurrent scenarios;
- overbooking and duplication explicitly addressed;
- more predictable retry behavior;
- technical decisions clearly documented.

## Execution checklist

- [ ] Review simultaneous creation, repeated confirmation, and competing cancellation.
- [ ] Confirm the selected strategy (locking, constraint, optimistic locking, idempotency key, etc.).
- [ ] Validate error messages and rollback behavior for partial failures.
- [ ] Check whether domain invariants were documented.

## Acceptance criteria

- Explicit strategy to avoid overbooking and duplication.
- Idempotency considered for sensitive operations.
- Conflicts handled predictably.
- Guarantees and limits documented in the final summary.
- Remaining risks clearly acknowledged.

## Common mistakes

- Claiming the flow is “safe” without explaining why.
- Relying only on application-level validation without considering the database.
- Ignoring retries from clients or external integrations.
- Failing to define what availability means under concurrency.

## Next step

Close the track with `08-quality-openapi-ci.md`, consolidating tests, OpenAPI, and CI quality gates.
