# Exemplo 04 — Modelagem de domínio e baseline com Alembic

## Objetivo

Estruturar a base do domínio de reservas com `Python 3.11`, `FastAPI`, `SQLAlchemy`, `Alembic` e camadas claras, preparando o projeto para disponibilidade, reserva e concorrência segura.

## Contexto do passo

Depois de bootstrap, governança e auditoria, este passo transforma o cenário em uma base implementável. A meta aqui não é “criar endpoints rápido”, mas montar entidades, schemas, migrations e services de forma consistente.

## Entradas esperadas

Antes de executar, é útil já ter definido:

- layout de pastas do projeto (`app/`, `src/`, `services/`, etc.);
- convenção de naming para models e schemas;
- estratégia mínima de timestamps e auditoria;
- escopo do domínio inicial (hotel, room type, inventory, guest, reservation).

## Prompt

```text
Contrato de ativos: SB-CORE (ver README.md deste diretório, seção "Contrato de Ativos de Prompt").
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

## Artefatos gerados esperados

- models e enums centrais do domínio;
- schemas de request/response coerentes com OpenAPI;
- migrations Alembic iniciais;
- service layer e persistência separadas do router;
- breve resumo arquitetural com trade-offs e pendências.

## Resultado esperado

- fundação do domínio pronta para crescer;
- entidades de reserva e inventário bem delimitadas;
- base adequada para os próximos passos de disponibilidade e reserva;
- documentação mínima do desenho criado.

## Checklist de execução

- [ ] Confirmar se as entidades centrais foram modeladas.
- [ ] Verificar constraints e índices úteis para disponibilidade/reserva.
- [ ] Validar a separação entre router, service e persistência.
- [ ] Conferir uso consistente de type hints.

## Critérios de aceite

- Entidades centrais do domínio modeladas com coerência.
- Alembic e SQLAlchemy alinhados.
- Schemas prontos para OpenAPI.
- Service layer sem acoplamento indevido ao router.
- Base preparada para passos posteriores de busca e reserva.

## Erros comuns

- Jogar regra de negócio dentro de endpoints FastAPI.
- Criar migrations sem pensar em índices do domínio.
- Tratar disponibilidade como campo estático, e não como regra derivada/inventário.
- Adicionar dependências desnecessárias cedo demais.

## Próximo passo

Seguir para `05-availability-search-api.md` para construir a superfície pública de busca e disponibilidade.
