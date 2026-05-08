# Enterprise Admin Panel — Exemplo 07: auditoria de acessibilidade WCAG 2.2

## Objetivo

Executar uma auditoria prática de acessibilidade para o painel, convertendo exigência de WCAG 2.2 em findings priorizados e ações de remediação.

## Contexto do passo

Depois de criar o agente `A11y-Guardian` e consolidar parte da base visual, é hora de avaliar se a interface realmente funciona com teclado, foco visível, semântica correta, contraste adequado e feedback compreensível.

## Entradas esperadas

- escopo de páginas/componentes a auditar;
- exemplos de telas críticas (tabela, filtros, modal, gráfico, formulário);
- critérios internos de severidade;
- ferramentas ou abordagem preferida de avaliação (`axe`, testes manuais, reader support, etc.).

## Prompt

```text
Copilot, run an accessibility-oriented review plan for this enterprise admin panel with WCAG 2.2 in mind.
Use the A11y-Guardian perspective to inspect keyboard navigation, focus management, semantics, contrast, chart accessibility, form feedback, and reusable component patterns.
Return findings by severity, with evidence, likely impact, and a prioritized remediation backlog.
```

## Artefatos gerados esperados

- relatório de auditoria por severidade;
- evidências ou exemplos concretos por finding;
- backlog priorizado de correções;
- orientação para reuso das correções no design system.

## Resultado esperado

O resultado ideal não é “passar num checklist”, mas sim:

- saber onde o painel falha de forma concreta;
- priorizar correções com base em impacto real;
- evitar que os mesmos erros reapareçam em novos componentes.

## Checklist de execução

- [ ] Cobrir navegação por teclado e ordem de foco.
- [ ] Inspecionar semântica de tabelas, gráficos e formulários.
- [ ] Verificar contraste e estados de foco visível.
- [ ] Exigir backlog acionável, não apenas observações genéricas.

## Critérios de aceite

- Há findings claros com severidade, evidência e impacto.
- O relatório inclui pelo menos componentes ricos, não só telas simples.
- As recomendações são compatíveis com React e com o design system definido.
- O resultado ajuda o time a prevenir recorrência, e não só apagar incêndio local.

## Erros comuns

- Auditar apenas páginas estáticas e ignorar modais, filtros e gráficos.
- Produzir um relatório sem severidade ou sem backlog.
- Reduzir acessibilidade a contraste, ignorando teclado, foco e semântica.

## Próximo passo

Siga para `08-quality-monitoring-adr-commits-ci.md` para fechar a trilha com monitoramento, disciplina documental e quality gates.
