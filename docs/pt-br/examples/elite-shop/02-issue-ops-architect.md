# Exemplo 02 — Estratégia de Issues (Agile/Scrum)

## Objetivo

Instalar templates de issue da estratégia `agile-scrum` e criar um Epic inicial para checkout.

## Prompt

```text
Invoke agent @issue-ops-architect.
Select model '3. Agile / Scrum'.
Generate the script to install the Issue templates.
After installing, create an Issue of type 'Epic' for the 'Checkout System'.
```

## Resultado esperado

- Script de instalação de templates em `.github/ISSUE_TEMPLATE`.
- Arquivos instalados: `config.yml`, `bug.yml`, `epic.yml`, `task.yml`, `user-story.yml`.
- Criação de issue Epic para `Checkout System`.

## Critérios de aceite

- Templates resolvidos via `registry.json`.
- Epic criada com escopo e critérios de sucesso.
- Fluxo não sobrescreve arquivos existentes sem confirmação.
