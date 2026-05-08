# Exemplo 06 — Workflow principal de reservas

## Objetivo

Implementar o fluxo central de reservas com criação, consulta, cancelamento e confirmação, usando estados explícitos e boundaries transacionais claros.

## Contexto do passo

Depois de expor disponibilidade, o sistema precisa transformar intenção de reserva em fluxo de negócio consistente. Este passo fecha o “happy path” do domínio, mas já prepara o terreno para confirmação segura e integração futura com pagamento.

## Entradas esperadas

- modelo de estados da reserva;
- payload mínimo de criação;
- política básica de cancelamento;
- mapeamento de erros de domínio para HTTP.

## Prompt

```text
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

## Artefatos gerados esperados

- endpoints principais do fluxo de reserva;
- service layer com regras transacionais;
- máquina de estados simples e explícita;
- mapeamento de erros de domínio;
- documentação OpenAPI para os fluxos principais.

## Resultado esperado

- workflow funcional mínimo de reservas;
- contratos claros para criação, consulta, cancelamento e confirmação;
- estados e transições visíveis;
- boundary pronto para futura integração de pagamento.

## Checklist de execução

- [ ] Confirmar se os estados da reserva foram modelados claramente.
- [ ] Verificar se cancelamento e confirmação bloqueiam transições inválidas.
- [ ] Revisar a separação entre API, serviço e persistência.
- [ ] Conferir responses de erro coerentes no OpenAPI.

## Critérios de aceite

- Fluxo principal de reserva implementado com clareza.
- Estados e transições definidos e compreensíveis.
- Erros de domínio mapeados para HTTP de forma consistente.
- OpenAPI refletindo corretamente o contrato.
- Pendências de concorrência explicitadas no resumo final.

## Erros comuns

- Confirmar reserva sem modelar estado intermediário.
- Misturar regras de cancelamento diretamente no endpoint.
- Esquecer conflitos de disponibilidade no create.
- Tratar confirmação como se já fosse pagamento final.

## Próximo passo

Seguir para `07-concurrency-hardening.md` para reforçar integridade transacional e prevenir overbooking ou confirmações duplicadas.
