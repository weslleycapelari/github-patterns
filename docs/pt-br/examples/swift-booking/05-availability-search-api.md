# Exemplo 05 — API de busca e disponibilidade

## Objetivo

Implementar a primeira superfície funcional do produto: consulta de disponibilidade e busca de opções de hospedagem com contratos HTTP claros e documentação OpenAPI útil.

## Contexto do passo

Com o domínio e persistência prontos, este passo abre a porta para consumo por UI e integrações. A busca de disponibilidade precisa ser clara, auditável e preparada para futura proteção contra concorrência.

## Entradas esperadas

- filtros principais de disponibilidade (`check-in`, `check-out`, hóspedes, categoria);
- política de paginação e ordenação;
- definição mínima do cálculo de disponibilidade;
- estratégia de erros HTTP para entrada inválida.

## Prompt

```text
Contrato de ativos: SB-CORE (ver README.md deste diretório, seção "Contrato de Ativos de Prompt").
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

## Artefatos gerados esperados

- endpoint de health/readiness;
- endpoint(s) de disponibilidade e busca;
- response models tipados;
- query/service dedicado para disponibilidade;
- documentação OpenAPI com exemplos.

## Resultado esperado

- primeira API funcional para consumo por clientes;
- validações de datas e ocupação bem definidas;
- cálculo de disponibilidade explicado;
- base pronta para avançar ao fluxo de reserva.

## Checklist de execução

- [ ] Conferir validação de datas e ocupação.
- [ ] Verificar separação entre router e service.
- [ ] Confirmar documentação OpenAPI mínima com exemplos.
- [ ] Revisar riscos de N+1 e consultas improdutivas.

## Critérios de aceite

- Endpoint de disponibilidade funcional e validado.
- Responses úteis e tipadas para consumo externo.
- OpenAPI coerente e legível.
- Cálculo de disponibilidade explicitado.
- Sem sinais óbvios de lógica espalhada ou consultas frágeis.

## Erros comuns

- Calcular disponibilidade diretamente no router.
- Não validar `check-out > check-in`.
- Retornar payloads pobres demais para UI ou integrações.
- Ignorar custo potencial de queries em volume maior.

## Próximo passo

Avançar para `06-reservation-workflow-api.md` para implementar o fluxo principal de criação, consulta, cancelamento e confirmação de reservas.
