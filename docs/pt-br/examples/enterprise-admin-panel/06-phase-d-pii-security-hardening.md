# Enterprise Admin Panel — Exemplo 06: endurecimento de segurança e PII na Phase D

## Objetivo

Aplicar os princípios da `Phase D (Advanced Security)` ao painel administrativo com foco em proteção de PII, fronteiras de acesso e exposição segura de dados no front-end.

## Contexto do passo

Um painel corporativo frequentemente mostra dados que não deveriam aparecer integralmente em todas as telas, logs ou componentes. Sem uma estratégia explícita, o front-end vaza PII em tabelas, tooltips, exportações, telemetry e screenshots de suporte.

## Entradas esperadas

- definição mínima de PII do produto;
- papéis e níveis de acesso existentes;
- fluxos com maior sensibilidade (`billing`, `employees`, `customers`, etc.);
- política de auditoria e observabilidade.

## Prompt

```text
Contrato de ativos: EAP-CORE (ver README.md deste diretório, seção "Contrato de Ativos de Prompt"). Delta desta etapa: aplicar explicitamente referência de segurança da Phase D.
Copilot, apply a Phase D security hardening plan for this enterprise admin panel.
Focus on PII protection, role-based UI boundaries, safe logging, masking/redaction, and secure handling of sensitive fields in React screens.
Keep the plan actionable for a React 18 + TypeScript dashboard and aligned with governance-first repository standards.
```

## Artefatos gerados esperados

- matriz ou inventário de dados sensíveis;
- regras de masking/redaction por contexto;
- critérios para renderização condicionada por papel/permissão;
- recomendações para logging, telemetry e exportação segura.

> Nota de mapeamento: no marketplace, a fonte de verdade para segurança está em `library/standards/security-hardening.md`. No projeto-alvo, ela pode ser materializada como `docs/standards/security.md`.

## Resultado esperado

Ao final, o time deve ter um plano claro para:

- reduzir exposição acidental de PII na UI;
- diferenciar dados visíveis, parcialmente mascarados e ocultos;
- reforçar confiança entre front-end, back-end e compliance.

## Checklist de execução

- [ ] Identificar os campos que realmente configuram PII.
- [ ] Separar autorização de API de autorização de interface.
- [ ] Cobrir logs, toasts, exportações e tabelas, não só formulários.
- [ ] Registrar riscos residuais e pontos que dependem do back-end.

## Critérios de aceite

- Existe pelo menos um inventário prático de dados sensíveis.
- O plano inclui masking/redaction com critérios verificáveis.
- Fronteiras de acesso na UI não são tratadas como substitutas do backend auth.
- Há orientações para observabilidade sem vazamento de dados.

## Erros comuns

- Achar que esconder um campo na UI resolve segurança por si só.
- Esquecer que logs e erros também podem carregar PII.
- Tratar Phase D como checklist genérico, sem mapeamento de fluxos reais.

## Próximo passo

Siga para `07-wcag-22-accessibility-audit.md` para transformar acessibilidade em auditoria concreta com evidências e backlog.
