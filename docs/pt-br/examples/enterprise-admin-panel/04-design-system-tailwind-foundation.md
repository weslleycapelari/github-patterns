# Enterprise Admin Panel — Exemplo 04: fundação do design system com Tailwind

## Objetivo

Consolidar uma base de design system orientada a componentes e estados para que o painel cresça com consistência visual, semântica e operacional.

## Contexto do passo

Depois do primeiro componente rico, o risco passa a ser a proliferação de estilos ad hoc, variações de espaçamento, estados inconsistentes e decisões visuais pouco reutilizáveis. Em produto corporativo, isso aumenta custo de manutenção e piora acessibilidade.

## Entradas esperadas

- tema visual desejado;
- tokens mínimos de cor, tipografia e spacing;
- convenção atual de componentes base;
- política de dark mode, se existir.

## Prompt

```text
Contrato de ativos: EAP-CORE (ver README.md deste diretório, seção "Contrato de Ativos de Prompt").
Copilot, establish the initial Tailwind-based design system foundation for this enterprise admin panel.
Create a practical token and component strategy for layout, cards, tables, filters, badges, and status states.
Keep the system accessible, easy to scale, and aligned with WCAG 2.2 expectations.
Document the guardrails so future components stay visually and semantically consistent.
```

## Artefatos gerados esperados

- estratégia inicial de tokens e utilitários;
- convenções para componentes base do dashboard;
- critérios para estados visuais (`loading`, `empty`, `error`, `success`, `warning`);
- guardrails para consistência com acessibilidade.

## Resultado esperado

O projeto passa a ter uma base explícita para:

- reutilização visual previsível;
- semântica consistente em componentes recorrentes;
- menor risco de divergência entre times e módulos.

## Checklist de execução

- [ ] Definir tokens mínimos antes de multiplicar componentes.
- [ ] Cobrir os estados operacionais mais frequentes do painel.
- [ ] Incluir convenções que ajudem tabelas e filtros, não apenas cartões bonitos.
- [ ] Garantir alinhamento com acessibilidade desde os guardrails.

## Critérios de aceite

- Há uma estratégia clara para tokens, componentes base e estados.
- O resultado evita design system abstrato demais para ser usado.
- Os guardrails ajudam futuras revisões do `A11y-Guardian`.
- O material é reaproveitável no restante da trilha.

## Erros comuns

- Criar apenas uma paleta de cores e chamar isso de design system.
- Não cobrir tabelas, filtros e feedback states, que são centrais em painéis administrativos.
- Adiar acessibilidade para “quando os componentes estiverem prontos”.

## Próximo passo

Siga para `05-react-query-data-layer-hardening.md` para endurecer a camada de dados com React Query de forma compatível com o ADR inicial.
