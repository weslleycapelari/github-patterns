# Example 05 — Availability Search API

## Goal

Implement the first functional product surface: availability lookup and lodging search with clear HTTP contracts and useful OpenAPI documentation.

## Step context

With domain and persistence in place, this step opens the project to UI and integration consumption. Availability search must be explicit, auditable, and prepared for future concurrency protection.

## Expected inputs

- main availability filters (`check-in`, `check-out`, guests, category);
- pagination and sorting policy;
- minimum definition of how availability is calculated;
- HTTP error strategy for invalid input.

## Prompt

```text
Asset contract: SB-CORE (see this directory's README.md, section "Prompt Asset Contract").
You are evolving the project "Swift-Booking" already structured with FastAPI, SQLAlchemy, and Alembic.

OBJECTIVE
Implement the first functional product surface: availability search and booking option discovery.

CONSTRAINTS
- Keep Python 3.11, FastAPI, SQLAlchemy, Alembic, and 100% type hints in all new code.
- Endpoints must stay thin; rules belong in services/use-cases.
- OpenAPI must remain readable and useful for consumers.
- Availability calculation must be explicit, auditable, and compatible with future concurrency hardening.
- Avoid N+1 and improvised database loops.
- Do not introduce definitive reservation logic yet; focus on search/availability.

TASK
Create the availability query layer covering at minimum:

1) Health/readiness endpoint, if it does not already exist, to support CI and operations.
2) Availability search endpoint with filters such as:
   - check-in
   - check-out
   - guest count
   - room type/category
   - pagination and sorting where appropriate
3) Typed response model containing:
   - room type
   - capacity
   - price range or base price
   - available quantity or availability signal
   - useful metadata for UI/integrations
4) Validation rules:
   - check-out greater than check-in
   - valid guest count
   - plausible date ranges
5) Logic organization:
   - query/service separated from the router
   - encapsulated database access
   - consistent HTTP error handling for invalid input
6) OpenAPI:
   - useful summaries and descriptions
   - request/response examples
   - clear operation names

ALSO DELIVER
- a brief explanation of how availability is calculated
- points where concurrency will still need to be hardened in the next step
- performance risks to watch if volume grows

EXPECTED QUALITY
- readable and typed code
- no unnecessary duplication
- efficient and reasonable queries for the domain
- OpenAPI documentation ready for frontend and integrations
```

## Expected generated artifacts

- health/readiness endpoint;
- availability/search endpoint(s);
- typed response models;
- dedicated availability query/service layer;
- OpenAPI documentation with examples.

## Expected result

- first functional API surface for clients;
- clear date and occupancy validation;
- explained availability calculation;
- foundation ready to move into the reservation workflow.

## Execution checklist

- [ ] Verify date and occupancy validation.
- [ ] Check separation between router and service.
- [ ] Confirm minimum OpenAPI documentation with examples.
- [ ] Review N+1 and inefficient query risks.

## Acceptance criteria

- Functional and validated availability endpoint.
- Useful typed responses for external consumers.
- Coherent and readable OpenAPI.
- Availability calculation explicitly described.
- No obvious signs of scattered logic or fragile queries.

## Common mistakes

- Calculating availability directly in the router.
- Failing to validate `check-out > check-in`.
- Returning payloads too weak for UI or integrations.
- Ignoring potential query cost at higher scale.

## Next step

Proceed to `06-reservation-workflow-api.md` to implement reservation creation, retrieval, cancellation, and confirmation.
