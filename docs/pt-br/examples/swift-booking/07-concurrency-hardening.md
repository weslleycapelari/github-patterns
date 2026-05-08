# Exemplo 07 — Endurecimento de concorrência e integridade

## Objetivo

Reforçar o fluxo de reservas contra race conditions, overbooking, confirmações duplicadas e inconsistências de inventário/disponibilidade.

## Contexto do passo

Este é o ponto mais sensível do domínio. Sem uma estratégia explícita de concorrência, o sistema pode parecer correto em ambiente local e ainda assim falhar sob carga, retries ou operações simultâneas.

## Entradas esperadas

- pontos críticos já conhecidos do fluxo de reserva;
- banco de dados e garantias de transação usadas pelo projeto;
- expectativa sobre idempotência e retries;
- critérios mínimos para considerar overbooking mitigado.

## Prompt

```text
Contrato de ativos: SB-CORE (ver README.md deste diretório, seção "Contrato de Ativos de Prompt"). Delta desta etapa: reforçar estratégia explícita para concorrência, idempotência e invariantes.
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

## Artefatos gerados esperados

- revisão técnica dos pontos de corrida;
- estratégia explícita de integridade transacional;
- tratamento de idempotência e conflitos;
- documentação das invariantes protegidas;
- resumo final com garantias e limitações.

## Resultado esperado

- fluxo de reserva endurecido contra cenários simultâneos;
- overbooking e duplicidade tratados de forma explícita;
- comportamento de retry mais previsível;
- decisões técnicas claramente documentadas.

## Checklist de execução

- [ ] Revisar criação simultânea, confirmação repetida e cancelamento competitivo.
- [ ] Confirmar a estratégia escolhida (lock, constraint, optimistic locking, idempotency key, etc.).
- [ ] Validar mensagens de erro e rollback em falhas parciais.
- [ ] Conferir se as invariantes do domínio foram documentadas.

## Critérios de aceite

- Estratégia explícita para evitar overbooking e duplicidade.
- Idempotência considerada nas operações sensíveis.
- Conflitos tratados de forma previsível.
- Garantias e limites documentados no resumo final.
- Riscos remanescentes claramente assumidos.

## Erros comuns

- Dizer que o fluxo é “seguro” sem explicar por quê.
- Confiar apenas em validação de aplicação sem considerar o banco.
- Ignorar retries de cliente ou integrações externas.
- Não explicitar o significado de disponibilidade sob concorrência.

## Próximo passo

Fechar a trilha com `08-quality-openapi-ci.md`, consolidando testes, OpenAPI e quality gates de CI.
