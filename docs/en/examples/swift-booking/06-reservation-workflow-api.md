# Example 06 — Main Reservation Workflow API

## Goal

Implement the core reservation flow with creation, retrieval, cancellation, and confirmation, using explicit states and clear transactional boundaries.

## Step context

After exposing availability, the system must turn booking intent into a consistent business flow. This step closes the domain happy path while preparing the ground for safe confirmation and future payment integration.

## Expected inputs

- reservation state model;
- minimum creation payload;
- basic cancellation policy;
- domain-error to HTTP mapping.

## Prompt

```text
Asset contract: SB-CORE (see this directory's README.md, section "Prompt Asset Contract").
You are in the "Swift-Booking" project after the availability step.

OBJECTIVE
Implement the main reservation flow consistently and in a way that is prepared for future evolution (payments, notifications, cancellation policies).

CONSTRAINTS
- Python 3.11 + FastAPI + SQLAlchemy + Alembic.
- 100% type hints in all new code.
- Explicit transactional flow.
- Endpoints must not concentrate business logic.
- Reservation states need to be modeled clearly.
- OpenAPI must correctly reflect API contracts.
- Do not use shortcuts that may cause double booking under concurrent scenarios.

FUNCTIONAL SCOPE
Implement the API and service layer for:

1) Creating a reservation
   - receive guest and stay data
   - validate dates, occupancy, and offer/room eligibility
   - return reservation identifier and initial status

2) Retrieving a reservation
   - recover essential reservation details
   - expose status, dates, guest data, and relevant information

3) Cancelling a reservation
   - apply a minimally consistent rule set
   - prevent invalid status transitions

4) Confirming a reservation
   - structure the flow to stay compatible with future payment integration
   - make the boundary between business confirmation and external event explicit

5) Modeling a simple state machine
   - for example: pending, confirmed, cancelled, expired
   - document allowed and forbidden transitions

6) Organizing domain errors
   - availability conflicts
   - missing reservation
   - invalid transition
   - invalid payload

7) Documenting OpenAPI contracts
   - correct status codes
   - well-described error responses
   - examples for creation and confirmation

DELIVERABLES
- main reservation flow endpoints
- service/use-case centralizing transaction rules
- clearly modeled status transitions
- final summary with implemented flows and natural domain open items

IMPORTANT
At the end, explain which parts still depend on concurrency hardening and which guarantees already exist in the current flow.
```

## Expected generated artifacts

- main reservation flow endpoints;
- service layer holding transaction rules;
- simple, explicit state machine;
- domain-error mapping;
- OpenAPI documentation for key flows.

## Expected result

- minimum functional reservation workflow;
- clear contracts for create, retrieve, cancel, and confirm;
- visible states and transitions;
- boundary prepared for future payment integration.

## Execution checklist

- [ ] Confirm reservation states are clearly modeled.
- [ ] Verify cancellation and confirmation block invalid transitions.
- [ ] Review separation between API, service, and persistence.
- [ ] Check coherent error responses in OpenAPI.

## Acceptance criteria

- Core reservation flow implemented clearly.
- States and transitions defined and understandable.
- Domain errors mapped consistently to HTTP.
- OpenAPI reflects the expected contract.
- Remaining concurrency concerns explicitly documented in the final summary.

## Common mistakes

- Confirming a reservation without an intermediate state model.
- Mixing cancellation rules directly into the endpoint.
- Forgetting availability conflicts during creation.
- Treating confirmation as if it were already final payment.

## Next step

Continue to `07-concurrency-hardening.md` to harden transactional integrity and prevent overbooking or duplicate confirmations.
