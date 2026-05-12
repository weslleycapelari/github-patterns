# Evaluation Coverage Sprint Prompt

## Objective

Execute a complete sprint cycle to expand evaluation coverage for AI-first repository governance: discover gaps in agent eval coverage, create missing test cases, validate registry coherence, and report new maturity state.

This is a **repeatable operational workflow** for deepening Nível 4 (Self-Auditable) maturity by closing gaps in evaluation case library.

---

## Context

**When to use this command:**
- After every 2–3 weeks of active agent development
- After major agent updates or new agent registration
- To identify which agents lack evaluation coverage
- To systematically build the eval case library until coverage reaches >80% of agents

**Prerequisites:**
- Repository has governance-maturity-model.md (five-level framework)
- registry.json and schema are already present and valid
- library/evals/ folder exists with structure per agent
- At least one reference eval case exists (e.g., project-auditor/case-01-bad-code.php)

---

## Input Contract

### Required Context
Provide this information before invoking the prompt:

```yaml
current_state:
  team_size: "solo|small (2–5)|medium (5–10)|enterprise"
  time_budget: "2–5 days|1 week|2+ weeks"
  agent_count: <number of registered agents in registry>
  eval_coverage: <number of agents with ≥2 eval cases>
  priority_agents: "[agent-name-1, agent-name-2, ...]"  # which agents to focus on if time-limited
  maturity_goal: "complete level 3|reach level 4|maintain level 4"

specific_gaps:
  known_missing: "[agent-name with no evals, ...]"
  recent_changes: "[new agents, major updates, ...]"
```

### Example Input

```yaml
current_state:
  team_size: "solo"
  time_budget: "1 week"
  agent_count: 15
  eval_coverage: 5
  priority_agents: "[project-auditor, security-infra-expert, asset-review-board, prompt-studio]"
  maturity_goal: "reach level 4"

specific_gaps:
  known_missing: "[security-infra-expert, asset-review-board, documentation-steward, context-steward, issue-ops-architect]"
  recent_changes: "[just created 8 evals for asset-factory, laravel-expert, vue-architect, registry-schema-governor]"
```

---

## Workflow

### Phase 1: Audit Current State (15–20 minutes)

**Tasks:**
1. Scan `registry.json` and count registered agents
2. Scan `library/evals/` directory tree
3. For each agent folder, count real case files (excluding `.gitkeep`, `README.md`)
4. Generate **Coverage Matrix**: agent name → case count → status (draft/active/none)

**Output:**
```
EVAL_COVERAGE_MATRIX
====================
agent-name              | cases | status
---                     |---    |---
project-auditor         | 1     | active
laravel-expert          | 2     | draft
vue-architect           | 2     | draft
asset-factory           | 2     | draft
registry-schema-governor| 2     | draft
... (remaining agents)  | 0     | none

AGENTS_WITHOUT_EVALS: [list of 10+ agents with 0 cases]
EVAL_COVERAGE_PCT: [covered agents / total agents] * 100
```

### Phase 2: Identify Next Priority Batch (10–15 minutes)

**Decision criteria** (in order):
1. **Agent criticality**: Is it in the core governance loop?
   - Tier 1 (critical): project-auditor, security-infra-expert, asset-factory, registry-schema-governor
   - Tier 2 (important): asset-review-board, prompt-studio, documentation-steward
   - Tier 3 (supporting): context-steward, issue-ops-architect, etc.

2. **Time estimate**: Can we complete 2 cases per agent in available budget?
   - If `time_budget: "2–5 days"` → pick 1–2 agents (2–4 new cases)
   - If `time_budget: "1 week"` → pick 2–3 agents (4–6 new cases)
   - If `time_budget: "2+ weeks"` → pick 3–4 agents (6–8 new cases)

3. **User priority**: Which agents does the team care about most right now?

**Output:**
```
PRIORITY_BATCH_SELECTION
========================
scope: [agent-1, agent-2, ...]
estimated_effort: "N–M days"
justification: "Why these agents + why this order"
expected_new_cases: N
```

### Phase 3: Create Evaluation Cases (N days, depends on scope)

**Execution:**
Invoke `@asset-factory` with this command:

```text
@asset-factory

Create evaluation cases for agents in priority batch.

Agents to cover: [agent-1, agent-2, ...]
Scope: 2 cases per agent minimum
  - case-01-bad-input.md (anti-pattern scenario with FAIL conditions)
  - case-02-expected-high-quality-output.md (ideal scenario with PASS conditions)

Each case must include:
  ✓ Clear scenario description
  ✓ Input/context
  ✓ PASS Criteria (objective, measurable)
  ✓ FAIL Conditions (explicit failure modes)
  ✓ Gate Decision (summary of evaluation logic)

Follow mandatory cycle: Develop → Review → Improve → Validate

Acceptance criteria:
  ✓ All N new cases present in library/evals/[agent]/
  ✓ Each case includes PASS/FAIL/Gate Decision sections
  ✓ No .gitkeep files in target folders
  ✓ Final report with risks, next agents to cover
```

**Parallel task**: Have `@registry-schema-governor` validate registry/schema integrity while cases are being created.

### Phase 4: Validate Registry Coherence (10 minutes)

**Execution:**
Invoke `@registry-schema-governor`:

```text
@registry-schema-governor

Validate registry integrity after eval creation.

Tasks:
1. Run --sync scan (detect unregistered assets)
2. Validate registry.json against schema
3. Verify all referenced paths exist
4. Report schema drift (if any)

Output:
  - Schema validation: PASS/FAIL
  - Path validation: count missing/valid
  - Unregistered assets summary (in library/evals, library/standards, agents/)
  - Recommendation: register evals formally or keep external (policy call)
```

### Phase 5: Execute Mini Maturity Scan (20–30 minutes)

**Execution:**
Invoke `@roadmap-steward`:

```text
@roadmap-steward

Execute a mini maturity scan focused on Level 4 evolution.

Analyze:
1. Nível 4 (Self-Auditable) state:
   - How many agents now have ≥2 eval cases? (before vs. after)
   - What percentage of agents have eval coverage?
   - Can we run automated eval execution yet? (yes/no + blocker if no)

2. Did Nível 4 maturity improve? By how much?
   - Was it <50% covered? Now how much?
   - Estimate % to next "80% coverage" milestone

3. Identify next priority gap:
   - Which 3–4 agents should we cover next?
   - Effort to close next gap?
   - Expected impact on Nível 4?

Output:
  - Current Nível 4 state (% eval coverage)
  - Maturity delta (before → after)
  - Progress to "80% coverage" milestone (e.g., 35% → 55%)
  - Recommended next priority batch + effort
  - Master prompt template for next sprint cycle
```

---

## Expected Output Contract

After completing all 5 phases, you should have:

### 1. Coverage Summary (required)
```
FINAL_EVAL_COVERAGE
===================
agents_total: N
agents_with_evals: M
coverage_percent: M/N * 100 = X%

New additions this sprint:
  - [agent-1]: 2 new cases (total now: N)
  - [agent-2]: 2 new cases (total now: N)
  ...

Status of Nível 4 maturity:
  before: X% (Z agents covered)
  after: Y% (W agents covered)
  delta: +% or "maintained at %"
  milestone_progress: "N steps from 80% threshold"
```

### 2. Files Created/Updated (required)
```
FILES_CHANGED
=============
library/evals/agent-1/case-01-bad-input.md [NEW]
library/evals/agent-1/case-02-expected-high-quality-output.md [NEW]
library/evals/agent-2/case-01-bad-input.md [NEW]
library/evals/agent-2/case-02-expected-high-quality-output.md [NEW]
library/evals/README.md [UPDATED - new rows in coverage matrix]

registry.json: [NO CHANGE | UPDATED with N new eval asset entries]
docs/schemas/registry.schema.json: [NO CHANGE | UPDATED to support eval cataloging]
```

### 3. Validation Results (required)
```
VALIDATIONS
===========
✓ schema_valid: yes|no (reason if no)
✓ paths_valid: yes (N/N paths exist)
✓ eval_cases_complete: yes (all PASS/FAIL/Gate Decision present)
✓ no_gitkeep_in_target_dirs: yes
✓ all_cases_in_git_status: yes
```

### 4. Next Steps & Risks (required)
```
RESIDUAL_RISKS
==============
- Risk 1 (example: not all new cases are promoted from draft to active)
- Risk 2 (example: no automated runner to execute evals yet)
- Risk 3 (example: coverage still below 80% threshold)

NEXT_PRIORITY_BATCH
===================
agents: [agent-a, agent-b, agent-c]
scope: 2 cases per agent = 6 new cases
effort: "2–4 days"
impact: "would bring coverage from X% → Y%"

MASTER_PROMPT_FOR_NEXT_SPRINT
==============================
[ready-to-paste command for next cycle]
```

### 5. Locale Sync Declaration (PR-Required)
```yaml
doc_name: eval-coverage-sprint.prompt.md
en_status: done
pt_br_status: pending
pending_sync_tasks: [create pt-br equivalent with Portuguese context]
```

---

## How to Invoke This Prompt

### Simple Mode (Single Command)
Copy and paste this into Copilot Chat:

```text
/eval-coverage-sprint

Current state:
  - team: solo
  - time_budget: 1 week
  - agent_count: 15
  - eval_coverage: 5 agents (out of 15)
  - priority_agents: [project-auditor, security-infra-expert, asset-review-board, prompt-studio]
  - maturity_goal: reach level 4

Gaps:
  - known_missing: [security-infra-expert, asset-review-board, documentation-steward, context-steward, issue-ops-architect]
  - recent: [just completed 8 evals for 4 agents]
```

### Advanced Mode (Parallel Execution)
If you want to parallelize phases 1–2 and 4 while 3 is running:

```text
@roadmap-steward

Execute Phase 1 (Audit) and Phase 2 (Identify Priority) in parallel while Asset Factory runs Phase 3.

[context from above]
```

Then separately:

```text
@asset-factory

[Phase 3 command above]
```

And in parallel:

```text
@registry-schema-governor

[Phase 4 command above]
```

Finally:

```text
@roadmap-steward

[Phase 5 command above]
```

---

## Acceptance Criteria

A sprint is complete when:

- ✅ All new eval cases are created (minimum 2 per target agent)
- ✅ Each case includes PASS Criteria, FAIL Conditions, Gate Decision (measurable)
- ✅ Registry and schema validation passes (or policy decision documented for no-change)
- ✅ Nível 4 maturity improved (coverage % increased)
- ✅ Next priority batch is identified and effort estimated
- ✅ Master prompt template for next sprint is ready
- ✅ No `.gitkeep` files introduced in target eval folders

---

## Anti-Patterns to Avoid

❌ **Creating evals without measurable PASS/FAIL criteria** → Cases become subjective, defeating the purpose  
❌ **Spreading coverage too thinly** → Picking 10 agents with 1 case each rather than 2–3 agents with 2 cases each  
❌ **Skipping registry validation** → Leads to drift between what exists and what registry says  
❌ **Mixing eval creation with registry schema changes** → Two orthogonal tasks; do them sequentially, not in parallel  
❌ **Not promoting cases from draft to active** → Cases remain theoretical, not used as actual gates  

---

## Timeline Reference

### Typical Sprint (solo team, 1 week budget)
- **Day 1 (2 hours)**: Audit + Priority selection
- **Day 2–4 (3–4 days)**: Create eval cases (2–3 agents, 2 cases each)
- **Day 5 (4 hours)**: Validate registry, run mini maturity scan, document next steps

### Quick Sprint (solo team, 2–5 days budget)
- **Day 1 (1.5 hours)**: Audit + Priority selection
- **Day 2–3 (2 days)**: Create eval cases (1–2 agents, 2 cases each)
- **Day 4 (3 hours)**: Validate, scan, document

### Extended Sprint (solo team, 2+ weeks budget)
- **Days 1–14**: Multiple batches (aim for 4–5 agents, 8–10 new cases total)
- **Weekly checkpoints**: Run mini maturity scan every 3–4 days
- **Final day (5 hours)**: Full validation, final roadmap update

---

## Success Indicators

**Quantitative:**
- Eval coverage % increased by ≥20 percentage points per sprint
- All new cases are in active (not draft) status by end of sprint
- Zero schema validation errors after each update

**Qualitative:**
- Team can identify failing agents by reading eval cases (criteria are clear)
- Next agent batch is predictable (priority is justified)
- Registry/schema state is coherent (no drift, no ambiguity)

---

## Version & Maintenance

**Prompt Version**: 1.0.0  
**Last Updated**: 2026-05-12  
**Status**: Stable  
**Review Cycle**: Bi-weekly after initial adoption; quarterly thereafter

### When to Update This Prompt
- After schema changes (add new section, adjust field structure)
- After major agent additions (>3 agents) to repo
- After evaluation framework changes (new PASS/FAIL criteria)
- After team feedback (simplify sections, add context)

---

## Quick Reference: Full Command Copy-Paste

```text
@roadmap-steward
@asset-factory
@registry-schema-governor

Execute the complete Evaluation Coverage Sprint cycle:

CONTEXT:
Team: solo
Time Budget: 1 week
Current State: 15 agents registered, 5 with evals, targeting Level 4

PHASES:
1. Audit current eval coverage (roadmap-steward)
2. Identify next priority batch (roadmap-steward)
3. Create eval cases for priority batch (asset-factory)
4. Validate registry/schema (registry-schema-governor)
5. Execute mini maturity scan (roadmap-steward)

EXPECTED OUTPUT:
- Coverage matrix (before → after)
- All new eval case files (with PASS/FAIL/Gate)
- Registry validation report
- Updated Nível 4 maturity state
- Master prompt for next sprint

DEADLINE: 5 working days
```

---

**Document Version**: 1.0.0  
**Status**: Production-Ready  
**Locale**: English (American)