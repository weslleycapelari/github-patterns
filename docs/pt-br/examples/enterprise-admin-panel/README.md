# Enterprise Admin Panel — Pacote de Exemplos de Prompts

Este diretório separa, em arquivos dedicados, os prompts usados para iniciar e evoluir um painel administrativo corporativo com o marketplace `github-patterns`.

## Contexto do cenário

O `Enterprise Admin Panel` representa um front-end corporativo com exigências de durabilidade técnica e governança forte desde o início:

- múltiplos níveis de acesso e dados sensíveis com PII;
- acessibilidade WCAG 2.2 como requisito de produto, não como retrofit;
- decisões arquiteturais que precisam sobreviver à rotatividade da equipe;
- forte disciplina de performance para dashboards e componentes ricos em visualização.

## Ordem recomendada

1. `01-onboarding-governance-adr.md`
2. `02-agent-factory-a11y-guardian.md`
3. `03-datachart-performance-component.md`
4. `04-design-system-tailwind-foundation.md`
5. `05-react-query-data-layer-hardening.md`
6. `06-phase-d-pii-security-hardening.md`
7. `07-wcag-22-accessibility-audit.md`
8. `08-quality-monitoring-adr-commits-ci.md`

## Como usar

- Execute **um prompt por vez**.
- Aguarde a implementação terminar antes do próximo.
- Reutilize o mesmo contexto de projeto ao longo da sequência.
- Use os critérios de aceite de cada arquivo para confirmar a conclusão.

## Entradas esperadas para a sequência

Antes de iniciar, vale ter em mãos:

- nome do projeto e stack principal;
- branch principal real do repositório (`main` ou outra);
- biblioteca de gráficos pretendida (`recharts`, `visx`, `nivo` ou equivalente);
- política de autenticação/autorização e papéis existentes;
- definição mínima do que conta como PII no produto;
- checks de CI esperados para lint, testes, acessibilidade e build.

## Convenção editorial

- Documento em PT-BR, com prompts preservados no idioma original quando fizer sentido.
- Os passos seguem a ordem real do Scenario 3 no `README.md`.
- O foco deste pacote é governança inicial, agente especialista, performance de componente e endurecimento operacional.
- Os passos `01` a `03` cobrem a trilha base do cenário.
- Os passos `04` a `08` formam uma trilha estendida de design system, data layer, segurança, acessibilidade e qualidade.

## O que cada etapa gera

- `01-onboarding-governance-adr.md`: proposta de bootstrap, ADR inicial e baseline de governança.
- `02-agent-factory-a11y-guardian.md`: agente especialista de acessibilidade e critérios de atuação.
- `03-datachart-performance-component.md`: componente `DataChart` com separação entre data-fetching e apresentação.
- `04-design-system-tailwind-foundation.md`: base do design system em Tailwind para uso consistente no dashboard.
- `05-react-query-data-layer-hardening.md`: política de cache, invalidação e hooks tipados para dados corporativos.
- `06-phase-d-pii-security-hardening.md`: controles de proteção de PII, masking e fronteiras de acesso.
- `07-wcag-22-accessibility-audit.md`: auditoria WCAG 2.2 com backlog de remediação.
- `08-quality-monitoring-adr-commits-ci.md`: quality gates, monitoramento, ADRs atualizadas e disciplina de conventional commits.

## Checklist de execução

- [ ] Confirmar a branch principal e os checks reais antes de configurar governança.
- [ ] Definir qual decisão arquitetural será registrada no ADR inicial.
- [ ] Garantir que o agente `A11y-Guardian` tenha escopo verificável e não genérico.
- [ ] Medir risco de re-render antes de otimizar o componente `DataChart`.
- [ ] Validar requisitos de PII e acessibilidade com exemplos concretos da UI.
- [ ] Fechar a trilha com CI e convenções de operação contínua.

## Erros comuns

- Tratar acessibilidade apenas como revisão visual tardia.
- Misturar responsabilidade de fetch, transformação e renderização no mesmo componente.
- Assumir React Query por hábito sem registrar a decisão e os trade-offs.
- Falar em Phase D sem mapear os dados realmente sensíveis do produto.
- Definir quality gates sem confirmar quais checks existirão no pipeline.

## Próximos passos

Depois dessa trilha, o caminho natural é:

1. expandir o dashboard com módulos orientados por domínio;
2. transformar findings de acessibilidade e segurança em backlog priorizado;
3. materializar os standards no projeto-alvo para reduzir ambiguidades futuras;
4. adicionar observabilidade de UX/performance em produção com alertas úteis.

## Escopo

Os arquivos abaixo refletem uma trilha progressiva para um projeto `React 18 + TypeScript`, cobrindo onboarding, ADR, agente especialista, performance de componente, design system, segurança de PII, acessibilidade e qualidade operacional.
