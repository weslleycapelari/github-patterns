# Enterprise Admin Panel — Exemplo 05: endurecimento da camada de dados com React Query

## Objetivo

Transformar a decisão por `React Query` em uma estratégia operacional consistente para cache, invalidação, retries, estados assíncronos e hooks tipados.

## Contexto do passo

Depois do ADR e do primeiro componente, o próximo risco é cada tela usar React Query de um jeito diferente. Em painel corporativo isso vira inconsistência de UX, cache imprevisível e bugs difíceis de diagnosticar.

## Entradas esperadas

- endpoints principais do dashboard;
- tipos compartilhados para requests/responses;
- política mínima de retry e stale time;
- convenção para tratamento de erro e feedback visual.

## Prompt

```text
Copilot, harden the React Query data layer for this enterprise admin panel.
Define a practical pattern for typed query hooks, cache keys, staleTime, retries, invalidation, and error handling.
Keep it consistent with the ADR that chose React Query over Redux and with a dashboard UX that must remain predictable.
```

## Artefatos gerados esperados

- padrão de query keys e invalidação;
- hooks tipados por domínio ou recurso;
- política explícita para cache, retry, stale e refetch;
- convenção para loading, skeleton, error e empty states.

## Resultado esperado

O projeto passa a ter uma camada de dados com:

- comportamento previsível entre telas;
- menor duplicação de lógica assíncrona;
- compatibilidade com performance, observabilidade e UX corporativa.

## Checklist de execução

- [ ] Definir convenção de query keys antes de multiplicar hooks.
- [ ] Explicitar quando usar query, mutation e invalidação.
- [ ] Revisar se retries fazem sentido para erros de autorização ou validação.
- [ ] Garantir alinhamento entre estados assíncronos e o design system.

## Critérios de aceite

- O padrão proposto não depende de Redux para controle de estado remoto.
- Query keys, invalidação e retries seguem critérios claros.
- Hooks tipados reduzem duplicação e ambiguidade.
- O resultado é reutilizável nos próximos módulos do dashboard.

## Erros comuns

- Configurar o mesmo `staleTime` para tudo sem considerar volatilidade dos dados.
- Revalidar em excesso e culpar o React por re-renders.
- Misturar estados de servidor e estados puramente locais sem fronteiras.

## Próximo passo

Siga para `06-phase-d-pii-security-hardening.md` para aplicar controles de segurança voltados a PII e fronteiras de acesso.
