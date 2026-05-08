# Example 04 — Domain Modeling and Alembic Baseline

## Goal

Structure the reservation domain foundation with `Python 3.11`, `FastAPI`, `SQLAlchemy`, `Alembic`, and clear layers, preparing the project for availability, reservations, and safe concurrency.

## Step context

After bootstrap, governance, and audit, this step turns the scenario into an implementable base. The goal here is not to “ship endpoints quickly”, but to set up entities, schemas, migrations, and services consistently.

## Expected inputs

Before running this step, it helps to define:

- project folder layout (`app/`, `src/`, `services/`, etc.);
- naming convention for models and schemas;
- minimum timestamp and audit strategy;
- initial domain scope (hotel, room type, inventory, guest, reservation).

## Prompt

```text
Asset contract: SB-CORE (see this directory's README.md, section "Prompt Asset Contract").
You are working on the project "Swift-Booking", a hotel reservation system in Python 3.11 with FastAPI.

CONTEXT AND CONSTRAINTS
- Required stack: Python 3.11, FastAPI, SQLAlchemy, Alembic, OpenAPI.
- All new code must use complete type hints.
- Keep a layered architecture: models, schemas, repositories/CRUD, services/use-cases, API routers.
- Avoid business logic directly inside endpoints.
- Prepare the foundation for concurrency-safe reservations; do not treat availability as a naive calculation inside a router.
- Preserve clear documentation for OpenAPI and keep naming consistent.
- Do not introduce unnecessary dependencies outside the project's main ecosystem.

TASK
Structure the reservation domain foundation focusing on consistency and extensibility:

1) Model the core domain entities, covering at minimum:
   - Hotel / Property (if the project supports multiple units)
   - RoomType or room category
   - RoomInventory or capacity by date/type
   - Guest
   - Reservation
   - ReservationStatus
   - optionally PaymentAttempt or BookingEvent, if it helps organize the flow without overloading the first delivery

2) Define FastAPI/OpenAPI-aligned input and output schemas:
   - typed requests and responses
   - validation for dates, occupancy, and minimum ranges
   - enums and useful examples where appropriate

3) Organize SQLAlchemy and Alembic to support:
   - tables with useful constraints
   - indexes suited for availability and reservation queries
   - minimal audit columns (created_at, updated_at)
   - conventions that favor future evolution without rework

4) Structure the persistence/service layer:
   - repositories/CRUD separated from the API
   - service layer for reservation rules
   - explicit session dependency handling
   - clear contracts between layers

5) Also generate short documentation of the design created:
   - entity overview
   - responsibilities by layer
   - risks not yet solved that depend on the next steps

EXPECTED DELIVERABLES
- Initial domain structure ready to grow
- Alembic migrations coherent with the model
- Aligned schemas and models
- Foundation prepared for availability and reservation endpoints
- Final summary with architectural decisions, trade-offs, and open items

QUALITY CRITERIA
- Idiomatic Python 3.11
- Consistent type hints
- No critical logic hidden in routers
- Constraints and indexes designed for the domain
- Final output explaining how the model supports safe reservations
```

## Expected generated artifacts

- central domain models and enums;
- OpenAPI-aligned request/response schemas;
- initial Alembic migrations;
- service layer and persistence separated from routers;
- short architectural summary with trade-offs and open items.

## Expected result

- domain foundation ready to grow;
- clear reservation and inventory entities;
- base prepared for the next availability and reservation steps;
- minimum documentation of the design created.

## Execution checklist

- [ ] Confirm core entities were modeled.
- [ ] Verify useful constraints and indexes for availability/reservations.
- [ ] Validate separation between router, service, and persistence.
- [ ] Confirm consistent type-hint usage.

## Acceptance criteria

- Core reservation entities modeled coherently.
- Alembic and SQLAlchemy aligned.
- Schemas ready for OpenAPI.
- Service layer without improper router coupling.
- Base prepared for later search and reservation steps.

## Common mistakes

- Putting business rules inside FastAPI endpoints.
- Creating migrations without thinking about domain indexes.
- Treating availability as a static field instead of a derived/inventory concern.
- Adding unnecessary dependencies too early.

## Next step

Move to `05-availability-search-api.md` to build the public search and availability surface.
