# Exemplo 02 — Hardening de branch protection na Phase B

## Objetivo

Configurar a governança de merge da branch principal com duas aprovações obrigatórias e validação do check `ci/test`.

## Por que isso importa

A `Phase B` protege o fluxo de merge contra problemas silenciosos, como:

- pushes diretos na branch principal;
- merges sem revisão;
- force-push e deleção acidental;
- divergência entre governança documentada e governança realmente aplicada.

## Entradas esperadas

Antes de executar este passo, confirme:

- repositório alvo (`owner/repo`);
- nome real da branch protegida;
- número mínimo de approvals;
- nome exato do status check (`ci/test` ou equivalente);
- owners/teams que devem participar de revisão;
- se admins também devem obedecer às regras.

## Prompt

```text
Contrato de ativos: SB-CORE (ver README.md deste diretório, seção "Contrato de Ativos de Prompt"). Delta desta etapa: usar explicitamente `prompts/start-phase-b.prompt.md`.
Use the governance prompt at:
https://raw.githubusercontent.com/weslleycapelari/github-patterns/main/prompts/start-phase-b.prompt.md
Help me configure the Ruleset for the 'main' branch.
Require 2 approvals and mandate that the 'ci/test' check passes.
```

## Artefatos gerados esperados

- configuração de Ruleset para a branch principal;
- regra de `required_approving_review_count = 2`;
- bloco de required status checks com `ci/test`;
- orientação para `CODEOWNERS`, quando aplicável;
- passo explícito de validação pós-configuração.

## Resultado esperado

- Regras de proteção propostas para `main`.
- Exigência de 2 approvals.
- Status check `ci/test` como obrigatório antes de merge.
- Orientação de validação da Ruleset configurada.

## Checklist de execução

- [ ] Confirmar se a branch principal é mesmo `main`.
- [ ] Validar o nome exato do check `ci/test` no GitHub Actions.
- [ ] Revisar se a Ruleset inclui proteção contra deletion e non-fast-forward.
- [ ] Verificar se a configuração cobre owners e admins conforme esperado.

## Pontos de validação

- `2 approvals` realmente configurados.
- `ci/test` presente como required status check.
- branch protegida corretamente identificada.
- resultado coerente com o prompt oficial `start-phase-b.prompt.md`.

## Critérios de aceite

- Branch alvo explicitamente `main`.
- Requisito de duas aprovações representado na configuração.
- Check `ci/test` incluído como obrigatório.
- Resultado coerente com o prompt oficial `start-phase-b.prompt.md`.

## Erros comuns

- Usar um nome de check que não existe de fato no repositório.
- Assumir `main` sem confirmar a branch padrão real.
- Tratar `CODEOWNERS` como detalhe opcional quando a regra exige revisão estruturada.
- Configurar governança sem validar enforcement ativo depois.

## Próximo passo

Com a branch principal protegida, siga para `03-project-audit.md` para auditar os fluxos críticos do domínio de reservas.
