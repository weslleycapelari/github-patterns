# Enterprise Admin Panel — Exemplo 03: componente DataChart orientado por performance

## Objetivo

Criar o componente `DataChart` com separação entre busca de dados e apresentação, evitando re-renders desnecessários e acoplamentos que dificultem evolução.

## Contexto do passo

Dashboards corporativos degradam rápido quando componentes visuais acumulam fetch, transformação, estado local, legendas, filtros e renderização no mesmo lugar. O padrão aqui é construir um componente previsível, fácil de medir e coerente com KISS.

## Entradas esperadas

- biblioteca de gráficos pretendida;
- formato do dataset principal;
- estratégia existente de hooks ou queries;
- critério mínimo de performance (por exemplo, evitar recomputação a cada render).

## Prompt

```text
Contrato de ativos: EAP-CORE (ver README.md deste diretório, seção "Contrato de Ativos de Prompt"). Delta desta etapa: aplicar explicitamente standard de performance.
Copilot, create the DataChart component.
Consult docs/standards/performance.md to ensure the component causes
no unnecessary re-renders.
Apply the KISS principle and separate data-fetching logic from presentation.
```

## Artefatos gerados esperados

- componente `DataChart` focado em apresentação;
- hook, adapter ou container separado para data-fetching;
- props tipadas e estáveis;
- estratégia explícita para memoização, derivação de dados e profiling.

> Nota de mapeamento: no marketplace, a fonte de verdade para performance está em `library/standards/performance-scalability.md`. No projeto-alvo, ela pode ser materializada como `docs/standards/performance.md`.

## Resultado esperado

Ao final, o componente deve demonstrar:

- separação entre responsabilidade de dados e UI;
- estratégia previsível para evitar renderizações inúteis;
- base segura para evolução com filtros, drill-down e estados vazios/erro.

## Checklist de execução

- [ ] Separar fetch/transform de renderização visual.
- [ ] Evitar criação desnecessária de arrays/objetos/funções a cada render.
- [ ] Confirmar se o dataset já chega no formato ideal ou precisa de adapter.
- [ ] Prever estados de loading, empty e error sem inflar o componente.

## Critérios de aceite

- O `DataChart` não mistura chamada remota e renderização no mesmo bloco principal.
- Existe justificativa explícita para `memo`, `useMemo` ou ausência deles.
- O componente não causa re-render por props instáveis evitáveis.
- O design segue KISS e continua legível para evolução futura.

## Erros comuns

- Colocar `useQuery` e toda a lógica visual no mesmo arquivo sem fronteiras.
- Usar `useMemo` em tudo “por precaução”, sem justificar custo/benefício.
- Transformar o componente em um “super widget” com múltiplas responsabilidades.

## Próximo passo

Siga para `04-design-system-tailwind-foundation.md` para consolidar a base visual e semântica sobre a qual o restante do painel deve crescer.
