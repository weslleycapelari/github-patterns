# Enterprise Admin Panel — Exemplo 01: onboarding de governança + ADR inicial

## Objetivo

Iniciar o projeto com governança forte desde o começo e registrar formalmente a decisão arquitetural de usar `React Query` em vez de `Redux`.

## Contexto do passo

O cenário descreve um painel corporativo com compliance, monitoramento e múltiplos níveis de acesso. Nesse tipo de projeto, a decisão de camada de dados não é detalhe: ela impacta complexidade, previsibilidade de cache, ergonomia do front-end e durabilidade da arquitetura.

## Entradas esperadas

- nome do projeto;
- URL do repositório, se existir;
- visibilidade do repositório;
- fases desejadas do modelo GitHub 100%;
- SO do time principal;
- política de conflito para arquivos já existentes.

## Prompt

```text
Contrato de ativos: EAP-CORE (ver README.md deste diretório, seção "Contrato de Ativos de Prompt"). Delta desta etapa: usar `Repo Architect` e registrar ADR inicial.
Act as Repo Architect.
Configure this Dashboard project.
Beyond the baseline, inject agent-factory into .github/agents/.
Create an ADR using the pattern from docs/standards/documentation.md
explaining why React Query was chosen over Redux for this project.
```

## Artefatos gerados esperados

- proposta de onboarding por fases;
- assets resolvidos a partir de `registry.json`;
- plano de bootstrap com instruções de instalação;
- ADR inicial comparando React Query vs Redux;
- baseline de CI e instruções de próximos passos.

> Nota de mapeamento: no marketplace, a fonte de verdade para ADR está em `library/standards/documentation-adr.md`. No projeto-alvo, ela pode ser materializada como `docs/standards/documentation.md`.

## Resultado esperado

Ao final, o projeto deve sair do estado “front-end sem contexto operacional” para um estado com:

- trilha de governança definida por fases;
- rationale documentado da escolha de gerenciamento de dados;
- preparo para evoluir para agentes especializados e controles de segurança.

## Checklist de execução

- [ ] Confirmar stack principal como `Node.js & TypeScript` na resolução do registry.
- [ ] Garantir que `agent-factory` foi incluído de forma explícita no plano.
- [ ] Verificar se o ADR registra contexto, decisão, alternativas e consequências.
- [ ] Confirmar que a proposta não extrapola para código de negócio.

## Critérios de aceite

- O onboarding segue o fluxo do `Repo Architect` e não inventa assets fora do `registry.json`.
- O ADR trata uma única decisão: `React Query` vs `Redux`.
- Os trade-offs de performance, complexidade e ergonomia estão explícitos.
- Há um próximo passo operacional claro após o bootstrap.

## Erros comuns

- Pular o ADR e apenas “assumir” React Query.
- Misturar Redux Toolkit, Zustand e React Query na mesma decisão sem foco.
- Pedir para o `Repo Architect` gerar código de dashboard, saindo do escopo dele.

## Próximo passo

Siga para `02-agent-factory-a11y-guardian.md` para criar o agente especialista de acessibilidade que sustentará a revisão contínua dos componentes React.
