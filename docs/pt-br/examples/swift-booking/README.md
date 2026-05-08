# Swift-Booking — Pacote de Exemplos de Prompts

Este diretório separa, em arquivos dedicados, os prompts usados para iniciar e evoluir um projeto novo de hotelaria com o marketplace `github-patterns`.

## Contexto do cenário

O `Swift-Booking` representa um sistema de reservas com requisitos típicos de confiabilidade operacional:

- consistência de disponibilidade em tempo real;
- proteção da branch principal desde o início;
- baseline de CI para evitar regressões silenciosas;
- auditoria de transações críticas com foco em concorrência e race conditions.

## Ordem recomendada

1. [01-onboarding-governance.md](01-onboarding-governance.md)
2. [02-phase-b-branch-protection.md](02-phase-b-branch-protection.md)
3. [03-project-audit.md](03-project-audit.md)
4. [04-domain-model-alembic.md](04-domain-model-alembic.md)
5. [05-availability-search-api.md](05-availability-search-api.md)
6. [06-reservation-workflow-api.md](06-reservation-workflow-api.md)
7. [07-concurrency-hardening.md](07-concurrency-hardening.md)
8. [08-quality-openapi-ci.md](08-quality-openapi-ci.md)

## Como usar

- Execute **um prompt por vez**.
- Aguarde a implementação terminar antes do próximo.
- Reutilize o mesmo contexto de projeto ao longo da sequência.
- Use os critérios de aceite de cada arquivo para confirmar a conclusão.

## Entradas esperadas para a sequência

Antes de iniciar, vale ter em mãos:

- nome do projeto e stack principal;
- branch principal real do repositório (`main` ou outra);
- checks de CI esperados, especialmente `ci/test`;
- permissões administrativas para configurar Rulesets;
- escopo real do código a ser auditado (`app/`, `src/`, `database/`, etc.).

## Convenção editorial

- Documento em PT-BR, com prompts preservados no idioma original quando fizer sentido.
- Os passos seguem a ordem real do Scenario 2 no `README.md`.
- O foco deste pacote é governança inicial, proteção de branch e auditoria arquitetural.
- Os passos `01` a `03` cobrem a trilha base do cenário.
- Os passos `04` a `08` formam uma trilha estendida de implementação, concorrência segura e qualidade.

## O que cada etapa gera

- `01-onboarding-governance.md`: proposta de bootstrap, assets por fase e baseline de CI.
- `02-phase-b-branch-protection.md`: definição de Ruleset, validação de branch protection e alinhamento de status checks.
- `03-project-audit.md`: achados de auditoria com severidade, evidência e plano de remediação.
- `04-domain-model-alembic.md`: modelagem de domínio, schemas, migrations e service layer inicial.
- `05-availability-search-api.md`: endpoints de disponibilidade e busca com OpenAPI útil.
- `06-reservation-workflow-api.md`: fluxo principal de reservas com estados e erros de domínio.
- `07-concurrency-hardening.md`: endurecimento de concorrência, idempotência e integridade.
- `08-quality-openapi-ci.md`: testes, quality gates, OpenAPI revisada e CI operacional.

## Checklist de execução

- [ ] Confirmar o nome da branch principal antes da Phase B.
- [ ] Verificar se o check `ci/test` existe ou será criado no fluxo de CI.
- [ ] Executar os passos na ordem `01 → 02 → 03`.
- [ ] Validar os critérios de aceite antes de avançar.
- [ ] Adaptar o escopo de auditoria ao layout real do projeto.

## Erros comuns

- Assumir que toda branch principal se chama `main`.
- Configurar `ci/test` como required check antes de confirmar o nome exato do job.
- Rodar auditoria sem escopo claro do código sensível.
- Misturar decisões de onboarding com customizações profundas cedo demais.

## Próximos passos

Depois dessa trilha, o caminho natural é:

1. consolidar a `Phase C` com o pipeline real do projeto;
2. transformar findings de auditoria em backlog priorizado;
3. executar a trilha estendida `04–08` para sair de governança e chegar em implementação + qualidade;
4. materializar standards no projeto-alvo para reduzir ambiguidades futuras.

## Escopo

Os arquivos abaixo refletem uma trilha progressiva para um projeto `Python + FastAPI`, cobrindo governança, auditoria, modelagem, APIs principais, concorrência segura e qualidade operacional.
