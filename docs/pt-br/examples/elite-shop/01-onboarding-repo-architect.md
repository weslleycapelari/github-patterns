# Exemplo 01 — Onboarding com Repo Architect

## Objetivo

Iniciar o projeto `Elite-Shop` com stack Laravel, fases A→E e geração de script para Windows.

## Pré-requisitos

- Acesso ao repositório deste marketplace.
- Uso do agente `Repo Architect`.
- Contexto de projeto definido (nome, stack, visibilidade, fases, OS).

## Prompt

```text
Act as Repo Architect.
Use:
- https://raw.githubusercontent.com/weslleycapelari/github-patterns/main/registry.json
- https://raw.githubusercontent.com/weslleycapelari/github-patterns/main/agents/setup-orchestrator.agent.md
Start onboarding for a project called 'Elite-Shop', stack 'laravel',
visibility 'private', phases 'all', OS 'Windows'.
```

## Resultado esperado

- Formulário de intake preenchido.
- Proposta de assets por fase (A→E).
- Tabela com origem, destino e fase.
- Solicitação explícita de `CONFIRM` para gerar script.

## Critérios de aceite

- Todos os assets vêm do `registry.json`.
- Não há paths inventados/hardcoded.
- A proposta diferencia fase obrigatória x recomendada por stack.
