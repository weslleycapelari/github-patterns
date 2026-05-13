# Mission File: roadmap-2026-05-12-sprint-n4-hardening

Parent_Agent: roadmap-steward
Child_Agent: asset-factory
Mission_Objective: Executar hardening de maturidade N4 em 1 sprint, reduzindo retrabalho via cobertura de evals, auditoria contínua e memória operacional com evidência.
Context_Links:

- ROADMAP.md
- registry.json
- .github/workflows/marketplace-integrity.yml
- .github/scripts/validate-mission-protocol.sh
- library/standards/governance-maturity-model.md
- library/github-baseline/MEMORY.md

Success_Criteria:

- Cobertura de diretórios de eval com casos >= 90% (14 diretórios, mínimo 13 com ≥1 caso).
- Auditoria contínua em PR com sinalização por severidade e bloqueio para severidade alta.
- MEMORY.md com ao menos 2 entradas reais do sprint (ID, data, owner, impacto, evidência, status).
- Atualização de ROADMAP.md com no máximo 3 itens ativos e critérios testáveis em CI.

Result_Payload:

- Ajustes em library/evals/\* para agentes sem suíte (agent-factory, issue-ops-architect, rule-distiller).
- Evidência de auditoria contínua integrada ao workflow de PR (resumo de severidade, OR bloqueador).
- Entradas de MEMORY.md do ciclo com template correto.
- ROADMAP.md atualizado refletindo foco em N4.
- Resumo final do Roadmap Steward com trade-offs, riscos residuais e checkpoints próximos.

---

## Decision Log Summary

- **Priorização coerente**: consolidar N4 antes de expandir para Swift/automações avançadas reduz risco de fragmentação.
- **Foco operacional**: 3 itens (evals + auditoria + memória) são escopo realista para 1 sprint com 1–2 pessoas.
- **Rastreabilidade**: mission protocol gate já existe; esta sprint materializa a prática com missão explícita.
- **Trade-off aceito**: curto prazo: menos velocidade em features novas; longo prazo: menos retrabalho e maior confiança operacional.

---

## Risks & Trade-offs

| Risco                                             | Severidade | Mitigação                                                                        |
| ------------------------------------------------- | ---------- | -------------------------------------------------------------------------------- |
| Sobrecarga operacional em time small              | Média      | Critérios binários em CI; não exigir perfeccionismo em evals de primeira versão. |
| Cobertura de evals pode ser genérica inicialmente | Média      | Review gate obrigatório; iteração rápida em ciclo seguinte com feedback real.    |
| MEMORY.md requer disciplina contínua              | Baixa      | Atribuir ownership ao context-steward; review semanal enxuta (15 min max).       |
| Auditoria pode gerar falsos positivos             | Média      | Usar regras simples na primeira versão; refinar baseado em experience.           |

---

## Delivery Target

- **Draft desta missão**: 2026-05-12
- **Execução esperada**: 2026-05-19 a 2026-05-26 (1 sprint)
- **Próximo checkpoint (validação)**: 2026-05-26
- **Próxima varredura de maturidade**: 2026-06-09 (pós-sprint + stabilização)
