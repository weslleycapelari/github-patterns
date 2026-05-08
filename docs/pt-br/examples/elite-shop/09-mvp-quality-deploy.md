# MVP Prompt 05 — Qualidade, CI/CD, documentação e deploy readiness

## Objetivo

Fechar o MVP com cobertura de qualidade operacional: testes complementares, notificações, jobs, policies, CI e documentação de execução.

## Prompt

```text
Projeto: Elite-Shop (Laravel 13.8). Estado atual: API + Frontend + Services implementados.

TAREFA FINAL: Gere os artefatos de qualidade e deployment:

1) Testes Feature complementares (CheckoutFlow, AdminOrderManagement, StockAdjustment)
2) Notificações de pedido confirmado e enviado
3) Job assíncrono para confirmação (fila notifications)
4) Policies de Order e Product + registro no provider
5) .env.example atualizado (APP_NAME, DB, QUEUE_CONNECTION, MAIL, SESSION_DRIVER)
6) README completo (instalação, endpoints, arquitetura, testes)
7) Workflow CI com lint/test/security, matrix PHP 8.3/8.4, cache e artifacts
8) Makefile para setup/test/lint/serve

Após gerar tudo, rode `php artisan test` e corrija qualquer falha de importação ou namespace antes de finalizar.
```

## Critérios de aceite

- Arquivos de qualidade e deploy criados/atualizados.
- Testes executados e falhas de namespace/import resolvidas.
- CI preparado para validação automatizada de lint, teste e segurança.
