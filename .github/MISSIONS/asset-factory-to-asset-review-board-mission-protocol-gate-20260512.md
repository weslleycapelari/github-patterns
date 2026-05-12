# Mission File: asset-factory-to-asset-review-board-mission-protocol-gate-20260512

Parent_Agent: asset-factory
Child_Agent: asset-review-board
Mission_Objective: Implementar e validar gate de Mission Protocol end-to-end com bloqueio de PR não trivial sem missão válida.
Context_Links:

- .github/copilot-instructions.md
- library/standards/agent-mission-protocol.md
- .github/standards/agent-observability.md
- .github/standards/agent-error-contract.md
- .github/workflows/marketplace-integrity.yml
  Success_Criteria:
- Criar README e template em .github/MISSIONS com contrato obrigatório explícito.
- Criar script de validação e integrá-lo no workflow de integridade.
- Bloquear PR não trivial quando não houver mission file válido alterado.
- Atualizar docs en/pt-br com fluxo prático de conformidade.
  Result_Payload:
- .github/MISSIONS/README.md e .github/MISSIONS/\_template.md
- .github/scripts/validate-mission-protocol.sh
- workflow atualizado com lint/syntax/run do novo script
- documentação en/pt-br atualizada

## Decision Log Summary

- Escopo focado em enforcement auditável e mensurável em CI.
- Heurística de PR não trivial definida com exceção explícita para alterações apenas em .github/MISSIONS/\*\*.

## Risks & Trade-offs

- Risco de falso positivo em classificação de PR não trivial.
- Trade-off aceito: gate mais rígido para elevar rastreabilidade antes de expansão de stack.

## Delivery Target

- 2026-05-12
