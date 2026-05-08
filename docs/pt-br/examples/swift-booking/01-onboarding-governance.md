# Exemplo 01 — Onboarding e governança inicial

## Objetivo

Iniciar o projeto `Swift-Booking` com stack Python/FastAPI, priorizando as fases A, B e C e garantindo baseline de CI desde o começo.

## Contexto do cenário

Neste cenário, o onboarding não é apenas um passo de scaffolding. Ele define a fundação de colaboração, merge governance e qualidade para um projeto que lida com reservas, disponibilidade e fluxos sensíveis a concorrência.

## Pré-requisitos

- Acesso ao marketplace `github-patterns`.
- Uso do agente `Repo Architect`.
- Definição prévia do nome do projeto, stack, fases-alvo e sistema operacional.

## Entradas esperadas

Para obter uma proposta melhor, tenha claro:

- nome final do repositório;
- stack principal (`Python/FastAPI`);
- fases desejadas (`A`, `B`, `C`);
- sistema operacional para geração do script;
- política inicial para conflitos de arquivos, se aplicável.

## Prompt

```text
Contrato de ativos: SB-CORE (ver README.md deste diretório, seção "Contrato de Ativos de Prompt").
Act as Repo Architect.
Install the ecosystem for a Python/FastAPI project called 'Swift-Booking'.
Ensure phases A, B, and C are configured first, including ci-pipeline-base
to validate code on every commit.
```

## Artefatos gerados esperados

- proposta de assets por fase;
- distinção entre assets obrigatórios e recomendados;
- inclusão explícita do `ci-pipeline-base`;
- plano de bootstrap ou script pronto para o repositório alvo.

## Resultado esperado

- Descoberta inicial do contexto do projeto.
- Proposta de assets para as fases A, B e C.
- Inclusão explícita do `ci-pipeline-base` no plano.
- Sequência de bootstrap pronta para o repositório alvo.

## Checklist de execução

- [ ] Confirmar que o onboarding ficou limitado às fases `A`, `B` e `C`.
- [ ] Verificar se o `ci-pipeline-base` entrou no plano final.
- [ ] Revisar se os assets foram resolvidos a partir do catálogo do marketplace.
- [ ] Confirmar que a proposta separa colaboração, merge governance e CI.

## Critérios de aceite

- Assets resolvidos a partir do catálogo do marketplace.
- Fases A, B e C claramente diferenciadas.
- CI baseline incluído no resultado.
- Nenhum path hardcoded fora do modelo do repositório.

## Erros comuns

- Pedir o onboarding sem informar o sistema operacional de destino.
- Ampliar o escopo para todas as fases quando o cenário foca em `A–C`.
- Aceitar a proposta sem revisar a separação por fase.
- Ignorar se o baseline de CI realmente apareceu na resposta.

## Próximo passo

Depois de confirmar o bootstrap, siga para `02-phase-b-branch-protection.md` para endurecer a governança de merge da branch principal.
