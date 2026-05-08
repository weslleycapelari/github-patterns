# Enterprise Admin Panel — Exemplo 02: criação do agente A11y-Guardian

## Objetivo

Criar um agente especialista em acessibilidade para revisar componentes React com critérios operacionais claros, evitando um agente genérico demais para ser útil.

## Contexto do passo

O cenário exige WCAG 2.2. Em dashboards corporativos, problemas de foco, navegação por teclado, contraste e semântica costumam aparecer cedo e se multiplicar rápido. Criar um agente específico reduz regressões e melhora a qualidade das revisões futuras.

## Entradas esperadas

- contexto do projeto já inicializado;
- padrão esperado para arquivos `.agent.md`;
- regra de colaboração multiagente;
- política de registro de novos assets ou agentes no projeto-alvo.

## Prompt

```text
Contrato de ativos: EAP-CORE (ver README.md deste diretório, seção "Contrato de Ativos de Prompt"). Delta desta etapa: usar explicitamente `@agent-factory` e standard de colaboração.
Use @agent-factory to create a new agent called 'A11y-Guardian'.
It must specialize in accessibility review for React components,
following docs/standards/ai-collaboration.md.
Register it in the local registry.json.
```

## Artefatos gerados esperados

- arquivo `A11y-Guardian` em `.github/agents/`;
- descrição clara de missão, workflow, anti-patterns e output contract;
- regra de atuação voltada a React + acessibilidade real, não revisão genérica;
- atualização coerente do `registry.json` do projeto-alvo.

> Nota de mapeamento: no marketplace, a fonte de verdade para colaboração está em `library/standards/ai-collaboration-governance.md`. No projeto-alvo, ela pode aparecer como `docs/standards/ai-collaboration.md` ou equivalente.

## Resultado esperado

O projeto passa a ter um especialista capaz de:

- revisar componentes React com foco em WCAG 2.2;
- devolver findings verificáveis por severidade;
- orientar correções sem invadir escopo de design system, segurança ou produto.

## Checklist de execução

- [ ] Verificar frontmatter com `name` e `description`.
- [ ] Garantir que o agente tenha Primary Intent, Workflow, Anti-Patterns e Output Contract.
- [ ] Confirmar que os exemplos e critérios são específicos para React components.
- [ ] Validar que o registro local do agente seja resolvível e consistente.

## Critérios de aceite

- O agente não é descrito como “ajuda com acessibilidade”; ele define entregas auditáveis.
- O handoff esperado para revisões inclui missão, contexto, restrições e saída esperada.
- O registro local aponta para um caminho válido e está em formato coerente com o projeto.
- O agente não promete ações destrutivas nem automações fora do escopo de review.

## Erros comuns

- Criar um agente de acessibilidade sem citar React, WCAG ou tipos de evidência.
- Registrar o agente sem padronizar nome, descrição e path.
- Misturar auditoria de segurança com auditoria de acessibilidade no mesmo agente.

## Próximo passo

Siga para `03-datachart-performance-component.md` para usar standards de performance na criação do primeiro componente rico do dashboard.
