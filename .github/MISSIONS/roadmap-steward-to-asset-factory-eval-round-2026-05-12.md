# Mission File: roadmap-steward-to-asset-factory-eval-round-2026-05-12

Parent_Agent: roadmap-steward
Child_Agent: asset-factory
Mission_Objective: Consolidar a rodada de cobertura de evals com 8 casos materializados (2 por agente) em asset-review-board, documentation-steward, prompt-studio e context-steward, preservando rastreabilidade e compatibilidade com o gate strict one-hop.
Context_Links:

- ROADMAP.md
- library/evals/README.md
- library/evals/asset-review-board/case-01-bad-input.md
- library/evals/asset-review-board/case-02-expected-high-quality-output.md
- library/evals/documentation-steward/case-01-bad-input.md
- library/evals/documentation-steward/case-02-expected-high-quality-output.md
- library/evals/prompt-studio/case-01-bad-input.md
- library/evals/prompt-studio/case-02-expected-high-quality-output.md
- library/evals/context-steward/case-01-bad-input.md
- library/evals/context-steward/case-02-expected-high-quality-output.md
- .github/MISSIONS/README.md

Success_Criteria:

- Child_Agent contém exatamente um único valor (`asset-factory`) compatível com a regra strict one-hop.
- Os 8 arquivos de eval listados em Context_Links existem por caminho relativo exato no repositório.
- library/evals/README.md contém linhas de cobertura para asset-review-board, documentation-steward, prompt-studio e context-steward com case_count igual a 2.
- O mission file possui todos os 6 campos mandatórios com conteúdo não vazio e sem placeholders.

Result_Payload:

- Mission file criado em .github/MISSIONS/ com contrato obrigatório completo e auditável.
- Lista explícita dos 8 evals materializados em Context_Links para rastreabilidade da rodada.
- Evidência de validação local via script .github/scripts/validate-mission-protocol.sh para execução antes de PR.

## Decision Log Summary

- Mantido 1 hop explícito (roadmap-steward -> asset-factory) para aderência estrita ao gate.
- Escopo da missão focado em consolidação e rastreabilidade da rodada já materializada.

## Risks & Trade-offs

- Risco: divergência futura entre contagem no README e arquivos reais de eval.
- Trade-off: missão enxuta (consolidação) em vez de expansão de cobertura na mesma entrega.

## Delivery Target

- 2026-05-12
