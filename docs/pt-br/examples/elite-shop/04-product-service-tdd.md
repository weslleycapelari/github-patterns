# Exemplo 04 — Implementação orientada por standards (TDD primeiro)

## Objetivo

Gerar testes antes da implementação de `ProductService`, alinhando `llms.txt` e standards de design/testing.

## Prompt

```text
Copilot, using this project's llms.txt, implement the ProductService class.
Follow the Immutability and Early Return rules from docs/standards/code-design.md.
Before writing logic, generate the Pest test file following docs/standards/testing.md.
```

## Nota de mapeamento de standards

No marketplace, os arquivos-fonte desses standards são:

- `library/standards/code-design-logic.md`
- `library/standards/testing-excellence.md`

No projeto de destino, normalmente são materializados como `docs/standards/code-design.md` e `docs/standards/testing.md`.

## Resultado esperado

- Arquivo de testes Pest criado primeiro (fase RED).
- `ProductService` implementado após testes (fase GREEN).
- Regras de Immutability e Early Return respeitadas.

## Critérios de aceite

- Ordem TDD comprovada (testes antes do serviço).
- Transações e validações em pontos críticos de escrita.
- Execução de testes e correção de regressões do escopo.
