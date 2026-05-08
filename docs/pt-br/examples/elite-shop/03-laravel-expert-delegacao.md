# Exemplo 03 — Delegação aninhada com @laravel-expert

## Objetivo

Analisar o CRUD de produtos com variações de estoque, obrigando delegação para subagentes de schema e segurança.

## Prompt

```text
Act as @laravel-expert.
Analyze the requirement for a product CRUD with stock variations.
MUST invoke subagent @eloquent-optimizer to design the table schema
and subagent @laravel-security to ensure the checkout flow has no
authorization gaps, following docs/standards/architecture.md.
```

## Nota de mapeamento de standards

No repositório marketplace, o equivalente de arquitetura está em:

- `library/standards/architecture-patterns.md`

No projeto de destino, esse standard pode ser materializado como `docs/standards/architecture.md` durante o setup.

## Resultado esperado

- Evidência de execução das duas delegações obrigatórias.
- Lista de riscos críticos e altos (IDOR, mass assignment, validações de pagamento, webhook).
- Plano incremental de remediação por sprint.

## Critérios de aceite

- Delegações executadas de forma explícita.
- Decisões de segurança prevalecem em conflito arquitetural.
- Plano final inclui ações testáveis e priorizadas.
