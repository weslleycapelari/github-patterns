# Exemplo 03 — Auditoria de projeto com foco em transações e race conditions

## Objetivo

Auditar o código existente do projeto com foco em concorrência, segurança e performance nas transações de reserva.

## Contexto da auditoria

Em sistemas de reserva, pequenos desvios de concorrência podem gerar problemas graves: dupla confirmação, disponibilidade incorreta, perda de integridade transacional e fluxos de pagamento inconsistentes. Por isso, a auditoria deve procurar evidência, severidade e remediação — não apenas listar problemas genéricos.

## Prompt

```text
Contrato de ativos: SB-CORE (ver README.md deste diretório, seção "Contrato de Ativos de Prompt"). Delta desta etapa: usar `@project-auditor` e os standards de segurança/performance do marketplace.
Call @project-auditor.
Scan the app/database/ folder and verify that reservation transactions follow
the Security and Performance standards from the marketplace.
If a Race Condition risk is found, classify it as CRITICAL and provide a
corrective prompt.
```

## Nota de mapeamento de standards

No repositório marketplace, os standards-fonte mais relevantes para este passo estão em:

- `library/standards/security-hardening.md`
- `library/standards/performance-scalability.md`

No projeto de destino, esses materiais podem ser materializados em `docs/standards/security.md` e `docs/standards/performance.md` durante o setup.

## Entradas esperadas

Antes da auditoria, vale explicitar:

- escopo real do código a auditar (`app/`, `src/`, `database/`, `services/`, etc.);
- prioridade de análise (`security`, `performance` ou ambos);
- necessidade de findings com severidade formal;
- expectativa de prompt corretivo ou checklist de remediação.

## Artefatos gerados esperados

- resumo do escopo auditado;
- standards aplicados;
- tabela de findings com severidade;
- evidência técnica por área ou arquivo;
- checklist de remediação e, quando pedido, prompt corretivo.

## Resultado esperado

- Auditoria de `app/database/` com foco em transações críticas.
- Identificação explícita de riscos de concorrência.
- Classificação de severidade, incluindo `CRITICAL` para race conditions quando aplicável.
- Prompt corretivo ou plano de remediação acionável.

## Checklist de execução

- [ ] Confirmar se o escopo `app/database/` reflete o layout real do projeto.
- [ ] Exigir avaliação explícita de segurança e performance.
- [ ] Solicitar evidência para cada risco classificado como relevante.
- [ ] Verificar se race conditions foram tratadas como risco de primeira classe.

## Erros comuns

- Auditar sem escopo realista do projeto.
- Marcar qualquer problema arquitetural como `CRITICAL` sem evidência.
- Ignorar fluxos concorrentes de reserva, confirmação e pagamento.
- Entregar findings genéricos demais para virar ação concreta.

## Critérios de aceite

- Segurança e performance avaliadas explicitamente.
- Race conditions tratadas como risco de primeira classe.
- Severidades claras e acionáveis.
- Saída final inclui recomendação verificável.

## Próximo passo

Transformar os findings em backlog priorizado, prompts corretivos ou PRs de remediação, antes de avançar para implementação mais profunda do domínio.
