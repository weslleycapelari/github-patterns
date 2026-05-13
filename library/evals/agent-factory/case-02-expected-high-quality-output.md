# Eval Case AGFAC-02 — Expected High-Quality Output / Full Intake Provided

## Metadata

- **agent**: `agent-factory`
- **case_id**: `AGFAC-02`
- **status**: `draft`
- **scenario_type**: `expected_high_quality_output`
- **contract_version**: `1.1.0`

## Scenario

The requester provides all mandatory intake fields and explicitly confirms the CONFIRM gate. The agent must produce a complete, standards-compliant `.agent.md` file and a registry snippet.

## Input (prompt payload)

```text
Agent Name: Documentation Steward
Agent Purpose: Reviews and synchronizes documentation across locale pairs (en/pt-br), detecting semantic drift and enforcing sync gates on pull requests.
Target Audience: AI
Tools Required: read_file, grep_search, file_search, semantic_search
Clarifying questions: no
CONFIRM gate before generating files: yes

Please create the agent file and registry snippet.
```

## Required Output Contract

1. A complete `.agent.md` file with all 9 required sections:
   - Frontmatter (`name`, `description`)
   - Title and Mission
   - Primary Intent
   - Adaptive Questioning
   - Workflow
   - Anti-Patterns
   - Quality Bar
   - Suggested Next Step
   - Output Contract
2. A registry snippet (JSON) with `id`, `name`, `path`, `version`, and `description`.
3. Key rationale for structural decisions.
4. Validation evidence (structural check).
5. Decision log with actor, decision, and ISO-8601 timestamp.

## PASS Criteria (all required)

1. Produces a complete `.agent.md` with all 9 required sections present (Frontmatter, Title and Mission, Primary Intent, Adaptive Questioning, Workflow, Anti-Patterns, Quality Bar, Suggested Next Step, Output Contract).
2. Frontmatter includes both `name` and `description`.
3. Workflow steps are procedural and testable (not vague verbs like "help").
4. Anti-Patterns section lists at least 3 specific `Do not` rules.
5. Quality Bar is a checklist with at least 3 items.
6. Output Contract defines at least 3 measurable deliverables.
7. Registry snippet is valid JSON with all required fields.
8. Decision log has at least 1 entry with actor, decision, and timestamp.
9. Does not duplicate an existing agent without explicit confirmation.

## FAIL Conditions

- Any of the 9 required sections is missing (including "Title and Mission").
- Registry snippet is missing or malformed.
- Workflow steps use vague, non-testable language.
- Overclaims execution of validation not performed.
- No decision log.
- Frontmatter is absent or incomplete.

## Gate Decision

- `PASS` only if all PASS criteria are satisfied.
- Otherwise `FAIL`.
