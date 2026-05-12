# Zero Inertia Command: Operationalizing GitHub Patterns

## 1. Introduction

### What is the Zero Inertia Command?

The **Zero Inertia Command** is a fully operational workflow that keeps your AI-first repository evolving without manual overhead. It's a structured, repeatable system for:

- **Auditing** your governance maturity against a proven five-level model
- **Discovering** capability gaps before they block shipping
- **Planning** the next sprint with precision using specialized agents
- **Implementing** improvements through orchestrated agent workflows
- **Validating** progress and preparing for the next iteration

At its core, the Zero Inertia Command is a single prompt you paste into Copilot Chat. The Roadmap Steward agent returns a comprehensive analysis and an executable master prompt. You review findings, approve progress, and invoke the next agents in sequence. The repository evolves methodically without becoming a burden.

### Why It Matters

Manual repository governance is a tax on velocity:

- **Bottleneck**: Every improvement requires someone to identify gaps, research solutions, and shepherd changes through review.
- **Context Loss**: Knowledge about "why we built this agent" decays as teams grow and turn over.
- **Momentum Bleed**: Teams choose not to refactor or upgrade because the process feels heavyweight.

The Zero Inertia Command eliminates these friction points:

- **Automation**: Roadmap Steward scans your registry, standards, and agents automatically, producing an audit in minutes.
- **Clarity**: Every recommendation comes with acceptance criteria and integration points, not vague suggestions.
- **Momentum**: Once decisions are made, Asset Factory and Registry Governor execute improvements in coordinated sprints.
- **Traceability**: Every change creates mission files and decision logs, so you never lose context.

### Who Should Use It

- **Solo developers** building AI-first projects and wanting governance without bureaucracy.
- **Small teams** (2–5 engineers) using GitHub Patterns to structure their repository.
- **Enterprise teams** managing large codebases across multiple domains (e.g., Laravel backend + Vue frontend + iOS).
- **Open-source maintainers** coordinating contributions without centralized control.
- **Technical leaders** who want governance to be **invisible**—built into the workflow, not a separate process.

---

## 2. System Architecture

### The Four-Agent Orchestration

```
You (Developer / Team Lead)
    ↓
    │ "Run a maturity scan and recommend next actions"
    │ (Zero Inertia Command)
    ↓
Roadmap Steward Agent
    ├─→ Audit: Registry scan, structure check, standards alignment
    ├─→ Gap Analysis: What's missing vs. Maturity Model
    ├─→ Master Prompt: Ready-to-paste orchestration for next sprint
    ↓
You (Review & Approve)
    ├─→ Read Audit Report
    ├─→ Evaluate Gap Analysis
    ├─→ Approve scope for next sprint
    ↓
You (Paste Master Prompt)
    │ "Execute: Phase 1 — Create Laravel security standard eval"
    ↓
Asset Factory Agent
    ├─→ Draft: Generate eval content (subagent)
    ├─→ Review: Independent critique (subagent)
    ├─→ Improve: Apply findings
    ├─→ Validate: Syntax & consistency checks
    ├─→ Deliver: Updated eval file + registry entry
    ↓
Registry Governor Agent
    ├─→ Sync scan: Detect unregistered assets
    ├─→ Validation: Ensure registry.json conforms to schema
    ├─→ Reconciliation: Update registry with new assets
    ├─→ Deliver: Ready-to-merge registry snapshot
    ↓
You (Merge & Deploy)
    │ Review PRs, approve, merge to main
    ↓
Repository (Updated & Evolved)
    │ New evals, standards, agents, or prompts now live
```

### Purpose of Each Agent

| Agent | Role | Invocation | Output |
|-------|------|-----------|--------|
| **You** | Decision maker, approver, executor | Paste commands, review reports, approve sprints | Decisions, approval signals |
| **Roadmap Steward** | Strategic auditor and planner | "Run maturity scan" (Zero Inertia Command) | Audit Report, Gap Analysis, Master Prompt |
| **Asset Factory** | Implementation specialist | Delegated by Roadmap Steward or Master Prompt | New/updated agents, prompts, standards, docs |
| **Registry Governor** | Catalog integrity guardian | Delegated by Asset Factory or Roadmap Steward | Updated registry.json, schema validation, reconciliation |

### How They Interact: Input/Output Flow

**Step 1: Audit**
- **Input**: Current `registry.json`, `library/` structure, `ROADMAP.md`, `governance-maturity-model.md`
- **Process**: Roadmap Steward scans for presence, currency, and coherence of assets
- **Output**: Maturity Audit (per-level assessment)

**Step 2: Gap Analysis**
- **Input**: Audit findings + user context (team size, strategic direction)
- **Process**: Roadmap Steward cross-references Maturity Model to identify what's missing or stale
- **Output**: Gap Analysis (ranked list: blockers, high-impact items, nice-to-haves)

**Step 3: Master Prompt Generation**
- **Input**: Gap Analysis + user approval of scope
- **Process**: Roadmap Steward generates a sequence of orchestrated commands, one per sprint item
- **Output**: Master Prompt (copy-paste ready, invokes Asset Factory → Registry Governor → Validation)

**Step 4: Asset Implementation**
- **Input**: Master Prompt + user invocation + approved scope
- **Process**: Asset Factory creates/updates artifacts using Develop → Review → Improve → Validate cycle
- **Output**: New/updated asset files (agent, standard, eval, prompt, documentation)

**Step 5: Registry Reconciliation**
- **Input**: New/updated asset files + current registry.json
- **Process**: Registry Governor scans for unregistered files, validates schema, generates update snippets
- **Output**: Updated registry.json + validation report

---

## 3. The Maturity Model Foundation

### Five Levels, One Path Forward

The **Governance Maturity Model** defines five progressive levels of AI-first governance:

| Level | Name | State | Focus |
|-------|------|-------|-------|
| 1 | **Foundation** ✅ | Complete | Structure, docs, license, folder hierarchy |
| 2 | **Controlled** ✅ | Complete | Branch protection, CI pipelines, automation |
| 3 | **AI-Driven** 🚧 | In Progress | Agents, standards, decision-making |
| 4 | **Self-Auditable** 🎯 | Next Goal | Continuous audit, traceability, evolution |
| 5 | **Autonomous Evolution** 🚀 | Vision | Adaptive roadmap, multi-locale sync |

Each level builds on the previous one. You can mature *within* a level without advancing to the next—and that's often the right call.

### Key Concept: Maturity vs. Progression

- **Maturity (Depth)**: How deeply you implement practices within the current level. A level is mature when:
  - All its artifacts are present and documented
  - Practices are applied consistently across the team
  - Risks and edge cases are handled explicitly
  - Decisions are traceable

- **Progression (Advancement)**: Moving to the next level. **Do not advance until the current level is mature enough to support the dependencies of the next level.**

**Example**: You might stay at Level 3 for 6 months, steadily maturing your agents, standards, and prompts. Only when agents are reliable and standards are proven do you progress to Level 4 (Self-Auditable).

### How Roadmap Steward Uses the Model

The Roadmap Steward agent performs this logic at the start of every maturity scan:

1. **Scan Artifacts**: Check what exists in your registry and library.
2. **Assess Maturity**: For each level, mark which artifacts are present, current, and functional.
3. **Identify Gaps**: What's needed to mature the current level? What's needed to progress?
4. **Recommend Path**: Suggest either DEEPEN (improve current level) or ADVANCE (move to next level).
5. **Rank Scope**: Prioritize gap items by impact and effort.

### Connection to Strategic Decision-Making

The Maturity Model is **not prescriptive**—it's a diagnostic tool. You decide:

- **Pace**: Advance to Level 4 in 8 weeks, or stay at Level 3 for a year while deepening it?
- **Scope**: Focus on one standard or build three agents in parallel?
- **Risk**: Accept technical debt to ship faster, or invest time in proper governance?

The Zero Inertia Command surfaces these trade-offs in writing, so decisions are intentional and auditable.

---

## 4. Passo 1: The Zero Inertia Command (Core Workflow)

### What to Do: Exact Command

Copy this command exactly and paste it into **Copilot Chat** (in VS Code or on GitHub.com):

```text
@roadmap-steward

I need a maturity scan of the github-patterns repository.

Please analyze:
1. Current governance maturity (against the five-level model)
2. Capability gaps vs. strategic direction
3. Recommended sprint items (2–3, ranked by impact)
4. A master prompt I can execute to implement the recommendations

Output format:
- Audit Report (current maturity per level)
- Gap Analysis (what's missing, why it matters, effort estimate)
- Master Prompt (ready to paste command for next agent in chain)

Context: [Provide any user context here: team size, tech stack, strategic priorities, timeline constraints]
Example: "5-person team, Laravel + Vue shop, targeting Level 4 maturity by Q3"
```

### What Roadmap Steward Will Return

You'll receive a structured response in three parts:

#### Part 1: Audit Report (5–10 minutes of reading)

A per-level assessment like:

```
MATURITY AUDIT REPORT
======================

Level 1: Foundation ✅ MATURE
  - README.md: ✓ Present, current, complete
  - CONTRIBUTING.md: ✓ Detailed, followed
  - LICENSE: ✓ MIT declared
  - structure.md: ✓ Comprehensive
  Status: READY TO MAINTAIN

Level 2: Controlled ✅ MATURE
  - Branch protection: ✓ Main branch protected
  - CI pipeline: ✓ Lint + test suite passes
  - Issue templates: ✓ 6 templates in use
  Status: READY TO MAINTAIN

Level 3: AI-Driven 🚧 IN PROGRESS (85% mature)
  - Agents present: ✓ 6 agents in registry
  - Standards present: ✓ 8 standards documented
  - Stacks present: ✓ Laravel (1), Vue.js (1), missing: iOS Swift
  - copilot-instructions.md: ✓ Complete
  - Evals present: ✓ 4 evals, missing: Vue performance, Laravel migration patterns
  Status: ADVANCING — Missing evals are the primary blocker

Level 4: Self-Auditable 🎯 NOT STARTED (0% mature)
  - Mission file protocol: ✗ Not enforced
  - Decision logs: ✗ Not systematic
  - Continuous audit: ✗ No automation
  Status: PREREQUISITE FOR LEVEL 4 = Mature Level 3

Level 5: Autonomous Evolution 🚀 VISION (0% mature)
  - Adaptive roadmap: ✗ Not implemented
  - Multi-locale sync: ✗ Partially done
  Status: DEPENDS ON LEVEL 4
```

#### Part 2: Gap Analysis (Critical decision input)

A prioritized list of gaps with business impact:

```
GAP ANALYSIS
============

BLOCKER (Must address before Level 4 advancement):
1. Laravel Performance Eval
   - Why: 4 agents exist (Laravel expert, security, reactivity, etc.)
      but no eval for performance tuning scenarios.
   - Impact: Teams can't validate Laravel expert recommendations.
   - Effort: Medium (3–4 days)
   - Owner: Recommend @asset-factory → Laravel expert stack agent

HIGH IMPACT (Improves current level maturity):
1. Vue.js Performance Audit Agent
   - Why: Vue architect exists; performance debugging is a core gap.
   - Impact: Complete the Vue stack; enable full-stack audits.
   - Effort: Large (2–3 weeks)
   - Owner: Recommend @asset-factory → new agent

2. Eval for Migration Patterns (Laravel)
   - Why: Teams upgrading Laravel versions need standard guidance.
   - Impact: Reusable, high-demand eval.
   - Effort: Small (2–3 days)
   - Owner: Recommend @asset-factory → extend Laravel stack

NICE-TO-HAVE (Improves process, not critical path):
1. Automated Registry Drift Detection
   - Why: Manual sync scans are error-prone.
   - Impact: Reduces operational overhead.
   - Effort: Medium (1 week)
   - Owner: Recommend @registry-governor → new CI workflow
```

#### Part 3: Master Prompt (Your execution blueprint)

A ready-to-paste command sequence:

```
MASTER PROMPT - EXECUTE IN SEQUENCE
===================================

PHASE 1: Create Laravel Performance Eval (Priority: BLOCKER)

@asset-factory

Create a comprehensive eval case for Laravel performance auditing.

File: library/evals/laravel-expert/performance-optimization.md
Scope:
- 3 realistic Laravel app scenarios (e-commerce, SaaS, content site)
- Performance anti-patterns (N+1 queries, unoptimized routes, memory leaks)
- Expected expert recommendations per scenario
- Pass/fail criteria for eval validation

Validation: Ensure consistency with existing eval structure
            (see: library/evals/laravel-expert/README.md)

Success Criteria:
✓ Eval file is markdown with at least 3 scenarios
✓ Anti-patterns are realistic (drawn from production issues)
✓ Expected outputs are testable (not subjective)

---

PHASE 2: Update Registry

@registry-governor

Sync the registry after asset creation.

Tasks:
1. Scan library/ for unregistered assets
2. Validate registry.json against registry.schema.json
3. Generate ready-to-paste registry.json update

Success Criteria:
✓ registry.json is valid JSON
✓ All paths in registry exist
✓ All new assets are registered with proper metadata

---

PHASE 3: Validate & Summarize

After Phase 2 completes, you will:
1. Review new registry entries
2. Merge the registry update
3. Mark sprint item as COMPLETE in ROADMAP.md
4. Run local validation: 
   python -c "import json; from jsonschema import Draft202012Validator; 
   data=json.load(open('registry.json')); schema=json.load(open('docs/schemas/registry.schema.json')); 
   Draft202012Validator(schema).validate(data); print('✓ VALID')"

---

NEXT SPRINT (Execute after Phase 3 is merged):

@roadmap-steward

Run maturity scan again to identify the next priority.
```

### How to Interpret Results

**Audit Report**: Use this to understand your *current state*. Focus on the "Status" line for each level.

**Gap Analysis**: Use this to understand *what's missing and why*. Ignore items marked "NICE-TO-HAVE" if you're in a hurry. Focus on "BLOCKER" and "HIGH IMPACT" items first.

**Master Prompt**: Use this as a *template for execution*. You don't have to follow it exactly—but it's designed to be copy-paste ready. If you disagree with a recommendation, edit the scope or skip the phase.

### Confirmation Gate Before Starting Work

**Stop here. Before you invoke the Master Prompt, answer these questions:**

1. **Do I agree with the priority ranking?** (If not, reorder phases or ask Roadmap Steward to re-prioritize.)
2. **Do I have capacity for this sprint?** (Typical sprint: 1–3 weeks. If not, ask Roadmap Steward to reduce scope.)
3. **Are there blockers preventing this work?** (Unclear requirements, team conflict, external dependencies. Surface them now.)
4. **Have I reviewed the references in Master Prompt?** (Ensure you understand the files being modified.)

Once you've answered "yes" to all four, you're ready to execute the Master Prompt.

---

## 5. Passo 2: Signal Intake (Real-World Examples)

### When to Use Signal Intake

Signal Intake is a variant of the Zero Inertia Command. Use it when you have external input:

- **Job description**: "We're hiring a full-stack Laravel engineer; what gaps does that reveal?"
- **Customer feedback**: "Multiple clients asked for performance auditing in Vue; what should we build?"
- **Team retrospective**: "We struggled to migrate Laravel versions; should we create a standard for this?"
- **Technology shift**: "Swift/iOS is a new platform for our team; how does that affect governance?"

Signal Intake tells you: "Given this new constraint or opportunity, what should we prioritize in our next sprint?"

### Example Command

```text
@roadmap-steward

I'm seeing a market signal and want to understand the governance impact.

Signal: We're hiring for a "Full-Stack Laravel + Vue Developer" role.
         Job description requires: Laravel 11, Vue 3, PostgreSQL, Docker, Redis caching.

Please analyze:
1. Does our current registry cover these technologies?
2. What gaps might prevent us from effectively onboarding this hire?
3. Should this signal change our sprint priorities?

Output: Gap Analysis focused on onboarding capability, not general maturity.
```

### How to Extract Job Description and Analyze Gaps

**Workflow:**

1. **Paste the job description** into the Signal Intake command (full text or summary).
2. **Ask Roadmap Steward** to align it to existing standards and stacks.
3. **Roadmap Steward returns** a mapping like:

```
SIGNAL ANALYSIS: Full-Stack Laravel + Vue Developer
====================================================

Technology Alignment:
- Laravel 11: ✓ Covered by laravel-expert agent + stack
- Vue 3: ✓ Covered by vue-architect agent + stack
- PostgreSQL: ✓ Covered in database standards
- Docker: ✓ Covered in infrastructure baseline
- Redis caching: ✗ NOT COVERED — Gap identified

Gap Identified: Redis Caching Patterns
- Why it matters: Candidate will use Redis from day 1; no guidance exists.
- Impact: High (performance optimization, production critical)
- Effort to close: Medium (create eval + extend Laravel stack with caching patterns)
- Recommendation: Add to next sprint as HIGH PRIORITY item

This signal should elevate "Laravel Caching Eval" from NICE-TO-HAVE to HIGH PRIORITY.
```

### Practical Example: "Fullstack Laravel/Vue Developer"

**Scenario**: Your team is hiring. The job description says:

> "5+ years Laravel and Vue.js, expert in performance optimization, familiar with Docker and microservices, strong in testing practices."

**You submit to Signal Intake:**

```text
@roadmap-steward

Job Description Signal: We're hiring a full-stack Laravel/Vue expert.

Requirements:
- Laravel 11 + advanced patterns (migrations, optimization, queues)
- Vue 3 + Composition API
- Docker, microservices architecture
- Performance optimization (both backend and frontend)
- Testing expertise (unit, integration, e2e)

Questions:
1. Can our current agents and standards guide this hire effectively?
2. What onboarding gaps exist?
3. Should this hiring signal change our sprint priorities?
```

**Roadmap Steward returns:**

```
JOB SIGNAL ANALYSIS
===================

Aligned Coverage:
✓ Laravel 11: laravel-expert agent + eval cases
✓ Vue 3: vue-architect agent + component patterns
✓ Docker: infrastructure in github-baseline
✓ Testing: testing-excellence standard

Gaps Identified:
1. Laravel Microservices Patterns: NONE EXIST
   - Candidate will ask "How do we structure service-to-service calls?"
   - Current state: Generic Laravel standards, no microservices guidance
   - Impact: HIGH (onboarding will struggle)
   - Fix: Extend laravel-expert agent with microservices eval

2. Performance Optimization (Full-Stack): PARTIAL
   - Laravel expert exists; Vue performance agent DOES NOT exist
   - Candidate will ask "How do we optimize bundle size and Core Web Vitals?"
   - Current state: Vue architect exists; no performance-specific guidance
   - Impact: HIGH (full-stack performance is core to role)
   - Fix: Create vue-performance-optimizer agent + eval

Recommended Action:
REPRIORITIZE next sprint to include:
1. Laravel microservices eval (2 days)
2. Vue performance optimizer agent (3 weeks)
3. Full-stack performance standard (5 days)

Timeline: If you need to hire in 6 weeks, start Phase 1 immediately.
```

---

## 6. Passo 3: Interpreting Results

### How to Read Maturity Audit Output

The audit report uses this format per level:

```
Level [N]: [Name] [Status Emoji]
  - [Artifact 1]: [Presence Check] [Description]
  - [Artifact 2]: [Presence Check] [Description]
  Status: [Human-readable next action]
```

**Decode the symbols:**

| Symbol | Meaning |
|--------|---------|
| ✓ | Artifact exists and is current (last update ≤ 2 sprints) |
| ✗ | Artifact missing or severely outdated (>2 sprints) |
| ⚠ | Artifact exists but incomplete or inconsistent |
| ✅ | Level is mature and ready to maintain |
| 🚧 | Level is in progress; advancing but not yet stable |
| 🎯 | Next logical milestone after current level |
| 🚀 | Aspirational goal; depends on prior levels maturing |

**What "mature" actually means:**

A level is mature when:
- All its critical artifacts exist and are current
- Team practices are consistent
- Risks are explicitly managed
- Edge cases are documented

A level is "in progress" when:
- Most artifacts exist, but some are incomplete
- Adoption is uneven across the team
- Decisions are still being validated
- The model works but needs refinement

### Understanding Gap Analysis

The Gap Analysis is structured by impact tier:

| Tier | Meaning | Action |
|------|---------|--------|
| BLOCKER | Prevents progression or creates production risk | Must fix before advancing to next level |
| HIGH IMPACT | Improves maturity significantly; high ROI | Prioritize next sprint |
| MEDIUM | Valuable but can wait; lower urgency | Plan for future sprints |
| NICE-TO-HAVE | Improves process, not critical | Do if capacity allows |

**When you see "BLOCKER", stop.** Do not advance to the next maturity level until blockers are resolved.

**When you see "HIGH IMPACT", plan it.** This is your next sprint.

### Reading the Master Prompt

The Master Prompt is your execution blueprint. It contains:

1. **PHASE descriptions**: What agent to invoke, what scope to give.
2. **Success Criteria**: Testable acceptance criteria for each phase.
3. **Command sequences**: Copy-paste ready, in execution order.
4. **Validation steps**: How to confirm each phase worked.

**Use the Master Prompt like a recipe.** You don't have to follow it exactly, but:

- Don't skip validation steps
- Don't reorder phases without understanding dependencies
- Don't assume an agent will "figure it out"—provide explicit scope

### Success Metrics Per Level

| Level | Success Looks Like | How to Measure |
|-------|-------------------|-----------------|
| **Level 1** | All docs are current; onboarding works | New contributor can set up repo in <30 min |
| **Level 2** | All PRs pass automation; zero manual gate errors | CI catches issues before review; zero failing merges |
| **Level 3** | Agents make consistent recommendations; standards are applied | Agents return same recommendation across multiple uses; zero standard violations |
| **Level 4** | Audit findings are consistent; traceability is automatic | Scan results match previous scan for same query; all changes have mission files |
| **Level 5** | Registry improves autonomously; codebase evolves without human direction | Roadmap advances automatically; locale sync is automatic |

---

## 7. Passo 4: Weekly Workflow

### Day-by-Day Breakdown

**Monday**: Maturity Scan
- Time: 15 minutes (copy command, paste, wait for response)
- You do: Review Audit Report and Gap Analysis. Socialize findings with team if needed.
- Outcome: Understand current state; identify priorities.

**Tuesday**: Approval Gate
- Time: 30 minutes (read findings, ask questions, approve scope)
- You do: 
  - Answer: "Do I agree with this priority?"
  - Answer: "Do I have capacity?"
  - Answer: "Are there blockers?"
- Outcome: Approved sprint scope; Master Prompt ready to execute.

**Wednesday–Friday**: Asset Implementation
- Time: Varies (typically 8–16 hours spread across 3 days)
- You do:
  - Paste Phase 1 of Master Prompt
  - Wait for Asset Factory to return draft
  - Review and approve (or request changes)
  - Paste Phase 2 (Registry Governor)
  - Review merged registry
  - Paste Phase 3 (Validation)
- Outcome: New/updated assets; registry synchronized.

**Next Monday**: Merge & Celebrate
- Time: 30 minutes (review PR, merge, run sanity check)
- You do: Final review of merged changes; ensure no conflicts with ongoing work.
- Outcome: Changes are live; team benefits from improvements.

**Following Monday**: Repeat
- Time: 15 minutes (next maturity scan)
- You do: Run Zero Inertia Command again; identify next priority.
- Outcome: Continuous improvement cycle begins again.

### Your Role at Each Stage

| Stage | Your Role | Decision Gate |
|-------|-----------|---------------|
| **Discover** | Passive observer | None; Roadmap Steward scans automatically |
| **Analyze** | Active reviewer | Approve audit findings; agree with gap ranking |
| **Plan** | Active approver | Confirm scope is achievable; check capacity |
| **Implement** | Active reviewer | Review drafts; approve/request changes per phase |
| **Validate** | Active gate-keeper | Confirm validation passed; merge to main |
| **Repeat** | Strategic input | Run next scan; signal new market changes if any |

### Expected Turnaround Times

| Activity | Typical Duration | Owner |
|----------|------------------|-------|
| Maturity Scan (Audit + Gap Analysis) | 15 min | Roadmap Steward (automated) |
| Your review of findings | 30 min | You |
| Approval/scope discussion | 30 min | You + team |
| Asset Factory Phase (draft + review + improve) | 8–16 hours | Asset Factory |
| Your review of Asset Factory output | 30 min | You |
| Registry Governor Phase (sync + validation) | 2–4 hours | Registry Governor |
| Your review of registry merge | 30 min | You |
| Final validation + merge | 30 min | You |
| **Total cycle (Scan → Live)** | **1–2 weeks** | Team + Agents |

### When to Intervene

**Intervene immediately if:**

- Asset Factory output doesn't match the scope you approved (out of bounds).
- Registry Governor reports a validation error (schema mismatch).
- A phase takes longer than 2 weeks (likely a blocker; surface it).

**Intervene proactively if:**

- You discover a new market signal or strategic shift (pause current sprint, run Signal Intake).
- Team capacity drops (pause sprint, extend timeline).
- Review finds a better alternative to what was proposed (discuss with Roadmap Steward for next cycle).

**Do NOT intervene if:**

- You disagree with a recommendation but are not sure (ask Roadmap Steward to explain; don't override).
- A phase is slow but progressing (let it run; aggressively iterating causes rework).

---

## 8. Passo 5: Professional Decision Making

### When to ADVANCE to the Next Level (All 5 Must Be True)

You are ready to advance to the next maturity level only when:

1. **Current Level is Mature** (≥80% artifact presence, ≥1 successful sprint applying the level's practices)
   - Example: At Level 3, you have working agents, standards are proven, team has used them successfully at least once.

2. **Next Level Dependencies Are Understood** (You've read the Maturity Model for next level; no surprises)
   - Example: Before advancing to Level 4, you understand that Level 4 requires mission files and decision logs, which will change your workflow.

3. **Team Capacity Exists** (The transition sprint is realistic; not overloading team)
   - Example: Advancing to Level 4 takes 4 weeks. If your team is firefighting, wait 2 sprints.

4. **Strategic Alignment Is Clear** (Leadership has agreed this is the next priority; not just "nice to do")
   - Example: "We're advancing to Level 4 to improve auditability for compliance requirements" (clear why).

5. **Risks Are Documented** (You've identified transition risks and have a mitigation plan)
   - Example: "Transition risk: team resistance to mission files. Mitigation: 1-hour onboarding workshop + paired demos."

**Decision Logic:**

```
IF (current_level_maturity >= 80%)
   AND (next_level_dependencies_understood)
   AND (team_capacity > 0)
   AND (strategic_alignment == YES)
   AND (risks_documented)
THEN: ADVANCE
ELSE: DEEPEN current level or address blocker
```

### When to DEEPEN Current Level (4 Indicators)

Deepen (maturity without progression) when:

1. **Artifact Coverage < 80%**: Some critical artifacts are missing or incomplete.
   - Example: At Level 3, you have agents but evals are thin. Deepen by adding 4 more evals.

2. **Adoption Is Uneven**: Some team members use the practices; others don't.
   - Example: One person writes good agents; another doesn't follow agent structure. Deepen by training + standards audit.

3. **Quality Issues Emerge**: In practice, artifacts have bugs or incomplete features.
   - Example: An agent returns inconsistent recommendations. Deepen by refining agent logic and adding evals.

4. **Process Hasn't Stabilized**: Teams still argue about "how to do this". Practices aren't routine yet.
   - Example: Still debating how to structure evaluation cases. Deepen by finalizing the eval standard and training.

**Decision Logic:**

```
IF (any of the 4 deepening indicators are TRUE)
THEN: Run Maturity Scan with focus="DEEPEN", not "ADVANCE"
ELSE: Evaluate advancement readiness
```

### Common Anti-Patterns to Avoid

**Anti-Pattern 1: "Advancing Too Fast"**
- **Looks like**: "We've been at Level 3 for 2 weeks; let's jump to Level 4."
- **Risk**: Mission files are new; if not adopted, Level 4 audit automation fails.
- **Prevention**: Follow the 5-gate advancement rule. Stay at Level 3 for ≥8 weeks.

**Anti-Pattern 2: "Ignoring Audit Findings"**
- **Looks like**: "Roadmap Steward said we have a blocker, but we'll ignore it and ship features."
- **Risk**: Blocker usually prevents progression or creates operational debt. Ignoring causes larger failure later.
- **Prevention**: If you don't agree with a finding, discuss it explicitly with Roadmap Steward. Don't silently skip.

**Anti-Pattern 3: "Over-Customizing Agent Outputs"**
- **Looks like**: "Asset Factory returned a standard, but we heavily modified it because 'our team is special'."
- **Risk**: Drift from repository standards; future team members confused; harder to maintain.
- **Prevention**: Use Agent outputs as-is unless there's a documented exception. Request Roadmap Steward review before customizing.

**Anti-Pattern 4: "Assuming the System Is Hands-Off"**
- **Looks like**: "We set up Zero Inertia Command and assumed it would run itself."
- **Risk**: Agents need human gates (approval, scope confirmation, strategic alignment). Missing gates cause runaway scope.
- **Prevention**: Treat Roadmap Steward as a strategic advisor, not a robot. Review findings; make conscious approvals.

**Anti-Pattern 5: "Registry Drift"**
- **Looks like**: "We created a new agent locally but didn't register it."
- **Risk**: Other agents don't know about it; asset discovery fails; documentation is stale.
- **Prevention**: Always run Registry Governor after Asset Factory. Make registry sync a non-negotiable part of the workflow.

### Risk Management Guidelines

**Operational Risk**: Governance practices break down; team stops using agents/standards.
- **Mitigation**: Run Maturity Scans monthly (not ad-hoc). Make adoption visible (metrics: agent usage, standard adherence). Train new team members explicitly.

**Technical Risk**: New agent or standard is low-quality; team finds it unreliable.
- **Mitigation**: Asset Factory always includes independent review. Evals validate agent outputs. Never ship untested agents.

**Organizational Risk**: Governance feels like bureaucracy; team resists it.
- **Mitigation**: Focus on *benefit*, not *compliance*. Agents save time; standards reduce arguments. Measure outcomes (faster reviews, fewer bugs, smoother onboarding).

**Timeline Risk**: Advancement takes longer than expected; team gets demoralized.
- **Mitigation**: Break advancement into smaller milestones. Celebrate wins. Be realistic about timelines (8 weeks per level is not a sprint; it's a quarter).

---

## 9. Passo 6: Success Indicators

### Key Performance Indicators (KPIs) by Level

| KPI | Level 1 | Level 2 | Level 3 | Level 4 | Level 5 |
|-----|---------|---------|---------|---------|---------|
| **Maturity Scan Time** | N/A | N/A | 15 min | 15 min | 15 min |
| **Artifact Freshness** | ≥1 mo | ≥2 wk | ≥1 wk | ≥3 d | Daily |
| **Audit Accuracy** | Manual spot-check | Manual | Semi-auto | Full auto | Continuous |
| **Gap Identification Cycle** | Manual (weeks) | Manual (weeks) | Semi-auto (days) | Full-auto (hours) | Real-time |
| **Asset Creation Cycle** | 2–4 wk | 1–2 wk | 3–5 d | 1–2 d | Hours |
| **Team Adoption Rate** | 100% (mandatory) | 100% | 80%+ | 80%+ | 90%+ |
| **Registry Coherence** | Manual check | Manual check | Semi-auto | Automated | Real-time |
| **Onboarding Friction** | High (30 min) | Medium (20 min) | Low (10 min) | Minimal (5 min) | Zero (auto) |

### What "Success" Looks Like at Each Level

**Level 1 Success**:
- New team member can clone repo and have local setup in <30 minutes
- Contribution rules are crystal clear; zero pull requests rejected for "unclear intent"
- License and legal compliance are in order; no ambiguity

**Level 2 Success**:
- Every PR is tested automatically before human review
- Zero merged PRs with failing tests or style violations
- Triage (labeling, routing) is 80% automated; humans focus on decisions, not classification

**Level 3 Success**:
- Agents are trusted to make recommendations; team acts on them without debate
- New standards are adopted within 1 sprint; no "we'll do it our way" pushback
- Asset creation is repeatable; same agent invoked for similar problems yields similar quality

**Level 4 Success**:
- Every change is traceable to a decision; governance is auditable
- Maturity Scans reveal no surprises; findings are consistent week-to-week
- Continuous improvement requires zero manual orchestration; agents invoke other agents automatically

**Level 5 Success**:
- Repository improves without explicit human direction; roadmap advances autonomously
- Multi-locale documentation stays synchronized automatically
- New standards and agents emerge in response to team signals (hiring, market feedback) with zero manual effort

### How to Measure Progress

**Quantitative Metrics:**

- Track Maturity Scan results over time. Graph: "% artifact presence per level" (should increase or stabilize).
- Count "asset creation cycles": How many assets were created/improved per sprint? (should stabilize at a predictable rate)
- Measure "audit feedback loop": How many findings from one scan are resolved before the next scan? (should be >80%)

**Qualitative Signals:**

- **Ease of Use**: "Did an agent recommendation feel natural or jarring?" (ask team monthly)
- **Confidence**: "Do you trust this agent?" (1–5 scale, track over time)
- **Friction**: "What's the most annoying part of our governance process?" (surface top 3 blockers)

**Example Dashboard (run monthly):**

```
GOVERNANCE HEALTH DASHBOARD
===========================
Current Maturity Level: 3 (In Progress)
Level 3 Coverage: 85% (8/9 artifacts present and current)

Assets Created This Sprint: 2 (Laravel eval, Vue standard)
Avg Asset Creation Cycle: 5 days (down from 7 days last month ✓)
Registry Sync: 100% (no drift) ✓

Team Adoption Metrics:
- Agent usage: 8/8 team members used at least 1 agent (100%)
- Standard adherence: 95% (1 outlier flagged for discussion)
- Maturity Scan frequency: Monthly (on schedule)

Upcoming Milestones:
- Level 3 maturity target: 95% coverage by end of Q2
- Level 4 advancement: Q3 (conditional on Level 3 deepening)
```

---

## 10. Passo 7: Running Your First Scan

### Exact Command to Paste (Copy-Ready)

Open **Copilot Chat** and paste this exactly:

```text
@roadmap-steward

I'm running my first maturity scan for the github-patterns repository.

Please audit the current state and provide:
1. A maturity assessment against the five-level Governance Maturity Model
2. Capability gaps, ranked by impact
3. A master prompt for implementing the top priority gap

Context: 
[Team Size]: 1–2 engineers (solo/small team, shared responsibilities)
[Tech Stack]: Polyglot (agents are technology-agnostic; evals vary by domain)
[Timeline]: 6–12 months to mature. No hard deadline.
[Strategic Priority]: Establish AI-first governance; avoid manual overhead.

Please format the response as:
- AUDIT REPORT (per-level assessment)
- GAP ANALYSIS (ranked, with effort estimates)
- MASTER PROMPT (ready to paste)
```

### Expected Time Investment

**Before the scan (setup)**: 5 minutes
- Open Copilot Chat
- Paste the command
- Wait for response (usually <2 minutes)

**Reviewing findings (reading)**: 15 minutes
- Read Audit Report (5 min)
- Understand Gap Analysis (5 min)
- Preview Master Prompt (5 min)

**Deciding next steps (thinking)**: 10 minutes
- Do I agree with priorities? (Yes/No/Discuss)
- Do I have capacity? (Yes/No/Defer)
- Any blockers? (Yes/No/Escalate)

**Total for first scan**: ~30 minutes

### What to Expect in the Output

You'll receive a structured document (usually 2–4 pages) with:

- **Audit Report** (numbered per level, with ✓/✗/⚠ symbols)
- **Gap Analysis** (tiered by BLOCKER/HIGH/MEDIUM/NICE-TO-HAVE)
- **Master Prompt** (phase-by-phase executable commands)
- **Appendix** (optional: detailed explanation of any ambiguous findings)

**Tone**: Professional, clear, no surprises. Roadmap Steward is designed to give you reliable, auditable analysis.

### Next Steps After First Scan

**Step 1: Share with team** (if relevant)
- Forward findings to anyone affected by the recommendations
- Discuss: "Do we agree with this priority? Do we have capacity?"

**Step 2: Approve scope**
- Decide: "Are we advancing or deepening?"
- Decide: "Which phase of Master Prompt should we execute first?"

**Step 3: Execute Master Prompt** (or plan for next sprint)
- If capacity exists: Paste Phase 1 immediately
- If capacity doesn't exist: Schedule Phase 1 for next sprint, document decision

**Step 4: After Phase 1 completes, continue to Phase 2 and Phase 3**
- Phase 2: Registry Governor handles registry sync
- Phase 3: Validation step (ensure everything is coherent)

**Step 5: Merge & celebrate**
- Review the PR
- Merge to main
- Run next maturity scan in 1 week (to validate the cycle works)

---

## 11. Common Questions & Troubleshooting

### "What If Roadmap Steward Suggests Something I Disagree With?"

**Response**: Disagreement is valid. You have options:

1. **Ask for explanation**: "Why did you prioritize [Item X] as HIGH IMPACT? I think it's lower value."
   - Roadmap Steward will explain the reasoning. You might change your mind, or you might have better context.

2. **Request re-prioritization**: "I'd like to deprioritize [Item X] and focus on [Item Y] instead. What would that change?"
   - Roadmap Steward can recalculate impact assuming a different priority.

3. **Override silently**: (Not recommended, but it happens.)
   - You can choose to work on something else. But then you lose traceability: next Maturity Scan might surface the same gap again.

**Best practice**: If you disagree, discuss *why*. Often, Roadmap Steward has data-driven reasons (e.g., "X blocks 3 agents; Y blocks 0"). Document your override in the MEMORY.md file so future you and future team know why.

### "How Do I Prioritize Between Competing Gaps?"

**Method**: Use the Master Prompt as a starting point, but you can reorder.

1. **Strategic alignment**: Does this gap align with your team's current focus?
2. **Effort vs. impact**: Is the ROI worth the effort? (High impact, low effort = do first)
3. **Dependencies**: Does fixing Gap A unblock Gap B? (Fix A first if yes)
4. **Team capacity**: Do you have people skilled enough to do this gap?
5. **Time sensitivity**: Is there a deadline? (Hiring timeline, customer deadline, etc.)

**Example reordering:**

```
Roadmap Steward suggests: BLOCKER, then HIGH #1, then HIGH #2

You reorder as:
- HIGH #1 (aligns with hiring plan; easier; unblocks BLOCKER)
- BLOCKER (now you have capacity and knowledge from HIGH #1)
- HIGH #2 (nice-to-have; defer to next sprint)
```

**Go for it.** The Master Prompt is a suggestion, not gospel.

### "Can I Skip a Level?"

**Short answer: No.** The levels build on each other. Skipping creates fragility.

**Why**: Level 4 (Self-Auditable) requires Level 3 (AI-Driven) to work. If you haven't matured agents and standards, Level 4's mission files and audit automation will feel like overhead, not help.

**What you CAN do**: Stay at a level for a very long time while deepening it. E.g., stay at Level 3 for 2 years, building a massive library of evals and standards. That's fine.

**But DO NOT**: Jump from Level 2 to Level 4. Too much will break.

### "What If Team Capacity Is Low?"

**Option 1: Defer the sprint**
- Don't run a sprint if you don't have capacity to execute it. Wait 2–3 weeks.
- Run Maturity Scan again at that time.

**Option 2: Reduce scope**
- Ask Roadmap Steward to suggest a "mini-sprint" (just 1 item, < 1 week effort).
- Execute that, then reassess.

**Option 3: Hire or delegate**
- If governance is bottlenecking you, consider hiring a specialist (even part-time) to focus on agents/standards.
- Or nominate a team member to own governance for one sprint.

### "How Often Should I Run Maturity Scans?"

**Recommended cadence:**

- **Minimum**: Once per quarter (every 3 months). If less frequent, drift accumulates.
- **Typical**: Once per month (every 4 weeks). Gives you a steady rhythm; findings are usually small deltas.
- **Aggressive**: Every 2 weeks. Only if you're rapidly advancing levels (e.g., Level 2 → Level 3 transition).

**At minimum, run one scan when:**

- You're considering advancing to the next level
- Team composition changes significantly
- A new market signal emerges (hiring, customer request, technology shift)
- A sprint completes, and you want to validate progress

---

## 12. Anti-Patterns & Gotchas

### Gotcha 1: Advancing Too Fast Without Maturity

**Symptom**: "We've been using agents for 3 weeks; let's advance to Level 4!"

**Problem**: Advancing without 8+ weeks at current level means you skip the process of *refining* agents, proving their value, and training the team.

**Result**: Level 4's automation (continuous audit, mission files) feels like busywork. Adoption fails; you're stuck with overhead.

**Prevention**: Follow the 5-gate advancement rule. Minimum stay at a level = 8 weeks (2 months) of active use.

### Gotcha 2: Ignoring Audit Findings

**Symptom**: "Roadmap Steward said we have 3 blockers, but we'll ship features instead."

**Problem**: Blockers exist because they prevent something important (e.g., Level 4 advancement, production risk, onboarding friction).

**Result**: Next Maturity Scan will surface the same blocker again. Morale drops because "governance is pointless; nothing improves."

**Prevention**: If you don't agree a finding is a blocker, discuss it explicitly with Roadmap Steward (or team). Document your decision in MEMORY.md. Don't silently ignore.

### Gotcha 3: Over-Customizing Agent Outputs

**Symptom**: "Asset Factory created a standard, but we've customized it 60% because 'our team is special'."

**Problem**: Drift from repository standards. Future hires see a non-standard artifact; codebase feels chaotic.

**Result**: Standards lose authority. New people follow custom pattern, not official one. Governance erodes.

**Prevention**: Use Agent outputs as-is. If you need to customize, discuss with the team and Roadmap Steward *first*. Document exceptions clearly.

### Gotcha 4: Assuming the System Is Fully Automated

**Symptom**: "We set up Zero Inertia Command and now the system should run itself, right?"

**Problem**: Zero Inertia removes *repetitive* work (scanning, analysis), but it doesn't remove *strategic* decisions (what to prioritize, whether to advance, how to handle risks).

**Result**: Scope creep. Agents propose too much; nothing ships. Or, decisions are made without human input; org resistance grows.

**Prevention**: Treat Roadmap Steward as a strategic advisor. You are always in the decision loop:
- You approve scope before Asset Factory starts
- You review findings before acting
- You decide "advance or deepen" based on your context

### Gotcha 5: Registry Drift

**Symptom**: "We created a new agent and eval locally, but haven't registered them yet."

**Problem**: Other tools don't know about these assets. Discovery breaks. Documentation is stale.

**Result**: Next team member looks at registry, doesn't see the new agent, recreates it (duplication). Time wasted.

**Prevention**: Registry sync is **non-negotiable** after Asset Factory creates anything. Run Registry Governor as Phase 2 of every Master Prompt.

### Gotcha 6: Missing Context in Maturity Scans

**Symptom**: You run Maturity Scan without providing context (team size, tech stack, strategic priorities).

**Problem**: Roadmap Steward makes default assumptions (small team, generic tech, long timeline). Recommendations don't fit your actual situation.

**Result**: Gap Analysis feels irrelevant. You don't implement recommendations. System seems broken.

**Prevention**: Always include context in the scan command:
- Team size and composition
- Tech stacks and domains
- Strategic priorities (hiring? expansion? stabilization?)
- Timeline constraints (do you need to advance in 3 months or 12?)

---

## 13. Integration with Other Systems

### Connection to `copilot-instructions.md`

[copilot-instructions.md](.github/copilot-instructions.md) defines the **mandatory workflow for all Copilot-driven changes**.

Zero Inertia Command leverages this workflow:

- **Discover**: Roadmap Steward reads existing registry and standards
- **Develop**: Asset Factory generates drafts (with subagent cycle)
- **Review**: Independent subagent critique (non-negotiable)
- **Improve**: Findings applied
- **Validate**: Schema checks, path validation, consistency checks
- **Summarize**: Decision logs created

Every asset created through Zero Inertia Command follows this gate. You don't have to manually enforce it; the workflow is built-in.

### Connection to `agent-mission-protocol.md`

[agent-mission-protocol.md](.github/standards/agent-mission-protocol.md) defines how agents delegate to other agents.

Zero Inertia Command is orchestrated through mission files:

- **Phase 1**: Roadmap Steward creates a mission file for Asset Factory (`.github/MISSIONS/sprint-xxx.md`)
- **Phase 2**: Asset Factory creates a mission file for Registry Governor
- **Phase 3**: Registry Governor validates and reports back

Each mission file includes:
- Parent and child agents
- Objective (what to build and why)
- Context links (files to read)
- Success criteria (testable)
- Result payload (expected output structure)

This traceability means you always know *why* an agent made a decision.

### Connection to `governance-maturity-model.md`

[governance-maturity-model.md](library/standards/governance-maturity-model.md) is the **reference framework** for all Maturity Scans.

Roadmap Steward uses the model to:
- Assess your current level
- Identify what's needed to mature the current level
- Recommend whether to deepen or advance
- Suggest blockers and dependencies

You understand the model, so you understand the scan results.

### Connection to `MEMORY.md`

[MEMORY.md](library/github-baseline/MEMORY.md) tracks operational decisions and lessons learned.

After each Maturity Scan, you (or Roadmap Steward) should record:
- Findings (what was discovered)
- Decision (what you chose to do and why)
- Impact (what changed as a result)

This creates a persistent memory of your governance evolution. Future you can look back and see: "In May, we advanced to Level 4. Here's what triggered that decision."

---

## 14. Real-World Examples

### Example 1: Advancing from Level 3 to Level 4

**Context**: Your team has been at Level 3 for 3 months. Agents are proven; standards are adopted. You want to improve auditability and enable autonomous improvements.

**You run**:

```text
@roadmap-steward

We've been at Level 3 for 3 months. Agents are stable; standards are followed.
We want to advance to Level 4 (Self-Auditable) to improve governance visibility 
and enable continuous improvement.

Please audit:
1. Is Level 3 mature enough to advance?
2. What Level 4 blockers exist?
3. What's the realistic path from Level 3 to Level 4?
4. What timeline should we plan for?
```

**Roadmap Steward returns**:

```
ADVANCEMENT ASSESSMENT: Level 3 → Level 4
==========================================

Level 3 Maturity: 92% (READY FOR ADVANCEMENT)
✓ 6 agents, all current and tested
✓ 8 standards documented and adopted
✓ 2 evals per standard; quality validated
✓ copilot-instructions.md defines workflows
✓ Team adoption is 100% (all engineers use agents)

Level 4 Blockers: NONE IDENTIFIED

Dependencies for Level 4:
1. Mission File Protocol (agent delegation tracking) — NOT YET IMPLEMENTED
2. Decision Logging (record *why* changes were made) — NOT YET IMPLEMENTED
3. Continuous Audit (weekly scans, not manual) — NOT YET IMPLEMENTED

Recommendation: ADVANCE TO LEVEL 4
Timeline: 6–8 weeks (transition sprint to implement mission files, 
          then steady-state with weekly audits)

Master Prompt:
[Phase 1] Implement mission file protocol in all agents
[Phase 2] Create decision logging standard
[Phase 3] Automate weekly maturity scans
[Phase 4] Validate continuous audit for 2 weeks
[Phase 5] Declare Level 4 readiness
```

**You decide**: "Yes, this aligns with our goals. Start Phase 1 next sprint."

**Outcome**: 6–8 weeks later, you reach Level 4. Governance is now auditable; every change is traceable.

### Example 2: New Job Description Reveals Security Gaps

**Context**: You're hiring a "Security-focused DevOps Engineer." Job description requires Docker, Kubernetes, IAM, compliance knowledge.

**You run Signal Intake**:

```text
@roadmap-steward

Job Description Signal: Hiring for Security-focused DevOps Engineer.

Requirements:
- Docker & Kubernetes expert
- IAM and authentication (OAuth2, SAML, LDAP)
- Compliance knowledge (SOC2, HIPAA awareness)
- Infrastructure-as-code (Terraform, CloudFormation)

Our repository currently covers: Laravel, Vue.js, general GitHub baseline.
We do NOT have infrastructure-specific agents or standards.

Questions:
1. What gaps does this hiring signal reveal?
2. Should this change our sprint priorities?
3. How urgent is it to close these gaps before hiring?
```

**Roadmap Steward returns**:

```
SIGNAL ANALYSIS: Security-focused DevOps Engineer
=================================================

Coverage Assessment:
✗ Docker: Mentioned in github-baseline; no deep guidance
✗ Kubernetes: NOT COVERED
✗ IAM/Auth: Mentioned in security-hardening standard; incomplete
✗ Compliance: NOT COVERED
✗ IaC: NOT COVERED

Gaps Identified (Ranked by Urgency):
1. BLOCKER: Kubernetes Best Practices Agent
   - Why: Candidate will ask "How do we structure K8s manifests?"
   - Impact: CRITICAL (infrastructure is core to role)
   - Effort: Large (4 weeks)
   - Recommendation: Build before hire

2. HIGH: IAM/Authentication Standard
   - Why: Partially covered; candidate will find gaps
   - Impact: HIGH (security is critical)
   - Effort: Medium (2 weeks)
   - Recommendation: Deepen existing standard

3. HIGH: Compliance Playbook
   - Why: Not covered; compliance is a core responsibility
   - Impact: HIGH (production risk)
   - Effort: Medium (2–3 weeks)
   - Recommendation: Create new standard

Recommended Action:
If you want this hire to be productive immediately:
- Sprint 1 (2 weeks): IAM standard + Compliance playbook
- Sprint 2 (4 weeks): Kubernetes agent
- Hiring timeline: Start recruiting in 8 weeks (after both sprints complete)

If you can't wait 8 weeks:
- Hire now; invest 2 weeks after hire for onboarding-specific documentation
- Plan K8s agent development in parallel with their first project

This hiring signal should reprioritize your roadmap.
```

**You decide**: "We can't wait 8 weeks. Hire now, invest heavily in onboarding. Plan K8s agent development for Q3."

**Outcome**: You hire the engineer; they're productive faster because you invest in documentation upfront. K8s agent becomes a Q3 priority.

### Example 3: Maturity Scan Finds 3 Blockers; Prioritize & Execute

**Context**: It's been 2 months since your last scan. You run Zero Inertia Command again.

**You run**:

```text
@roadmap-steward

Routine maturity scan. Last scan was 8 weeks ago at Level 3.
Current context: Team is stable; no major changes.
Run full audit and report findings.
```

**Roadmap Steward returns**:

```
MATURITY AUDIT: Level 3 (85% → 82% — SLIGHT DECAY)
====================================================

Key Changes Since Last Scan:
✓ Agents: All 6 agents present, current
✓ Standards: 8/8 present; 1 is stale (updated >2 months ago)
⚠ Evals: 3 evals added (great!); 1 eval is incomplete (missing 2 test cases)
✗ copilot-instructions.md: Current version matches; no issues

Blockers (Prevent Level 4 Advancement):
1. Incomplete Eval (Laravel Performance)
   - Test cases 2 and 3 are missing; breaks validation
   - Status: 50% complete
   - Fix: 2 hours (add 2 test cases, validate)

2. Stale Standard (Architecture Patterns)
   - Last updated >2 months ago; example code references old agent version
   - Status: 80% current
   - Fix: 1 day (update examples, validate with team)

3. Eval Coverage Gap (Vue Reactivity)
   - vue-reactivity-optimizer agent exists; no eval to validate its outputs
   - Status: 0% complete
   - Fix: 4 days (create 3 test scenarios, validate)

Recommendation:
Fix all 3 blockers before attempting Level 4 advancement.
Timeline: 1 week (blocker 1: 2 hrs, blocker 2: 1 day, blocker 3: 4 days)

Master Prompt:
[Phase 1] Complete Laravel Performance eval (2 hours)
[Phase 2] Update Architecture Patterns standard (1 day)
[Phase 3] Create Vue Reactivity eval (4 days)
[Phase 4] Registry Governor sync + validation
[Phase 5] Declare Level 3 blockers resolved; reassess Level 4 readiness

Estimated Total: 1 week. Next advancement attempt: 2 weeks from now.
```

**You decide**: "All 3 blockers are valid. Start Phase 1 immediately; allocate 1 engineer for 1 week."

**Outcome**: 1 week later, all blockers are resolved. Next Maturity Scan shows 92% coverage. You're ready for Level 4.

---

## 15. Closing: The Path Forward

### Weekly Cadence Summary

```
WEEK 1: Maturity Scan
  Mon:   Run Zero Inertia Command (15 min)
  Tue:   Review findings; approve scope (30 min)
  Wed–Fri: Implement Phase 1 (Asset Factory)
  
WEEK 2: Asset Factory + Registry Governor
  Mon:   Review Phase 1 output; approve or iterate
  Tue–Thu: Execute Phase 2 & 3 (Registry, validation)
  Fri:   Final review; merge to main

WEEK 3: Monitor & Stabilize
  Mon:   Run quick validation (is the new asset being used?)
  Rest:  Team uses new agent/standard in real work
  
WEEK 4: Preparation for Next Cycle
  Mon:   Run next Maturity Scan
  Repeat
```

**Total time per cycle**: ~2 hours hands-on from you; agents do the heavy lifting.

### How the System Becomes Autonomous Over Time

The Zero Inertia Command is **progressive**:

**Today (Level 3)**:
- You run scans manually
- You review and approve findings
- You invoke agents
- You merge PRs

**Next (Level 4)**:
- You run scans manually (same)
- Agents suggest next items more intelligently
- Agents create missions automatically
- You review and approve (less overhead than before)

**Eventually (Level 5)**:
- Scans are continuous (run weekly automatically)
- Roadmap advances based on team signals (hiring, feedback)
- New agents and standards emerge in response to signals
- You review outcomes, not inputs
- The repository *evolves itself*

**You don't have to do anything differently.** As you progress levels, the system naturally becomes more autonomous because:
- More automation is in place (Level 4's audit)
- More history exists (decisions are traceable)
- More patterns are stable (standards are proven)

### Vision: A Repository That Evolves Itself

Imagine this future state:

- **Every Monday**: Maturity Scan runs automatically. Findings are posted to a Slack channel (notification, not action).
- **Every Friday**: If gaps are found, Asset Factory prepares a draft PR with recommendations.
- **Decision gates are human**: You approve the draft or request changes.
- **Merges are continuous**: Changes land to main as soon as approved.
- **Registry is always coherent**: Registry Governor ensures no drift.
- **Documentation is in sync**: Locale sync is automatic across en and pt-br.
- **Team evolves naturally**: New hires trigger Signal Intake; hiring gaps are detected automatically.

**This is not a future fantasy.** It's the natural evolution of the system as you mature. You don't have to build it all at once. Maturity Scans and the Master Prompt methodology will guide you there incrementally.

### When to Revisit This Documentation

Revisit this document when:

- You've completed your first full cycle (Maturity Scan → Implementation → Live). You'll have concrete questions this doc doesn't address.
- You're transitioning between levels. This doc explains the path; you'll need to confirm timelines and scope.
- Team composition changes. New engineers need this document for context.
- You're building new agents or standards and want to align with the governance model.

**This documentation is a blueprint, not gospel.** Adapt it to your context. If something in this doc doesn't fit your team, discuss it explicitly (don't silently ignore). The goal is governance that serves your team, not governance that serves itself.

---

## Appendix A: References

- [Governance Maturity Model](../library/standards/governance-maturity-model.md) — Full 5-level framework with detailed expectations per level
- [Roadmap Steward Agent](.github/agents/roadmap-steward.agent.md) — Agent specification and workflows
- [Asset Factory Agent](.github/agents/asset-factory.agent.md) — How new assets are created
- [Registry Governor Agent](.github/agents/registry-schema-governor.agent.md) — How registry is managed
- [Agent Mission Protocol](../library/standards/agent-mission-protocol.md) — Delegation traceability standard
- [Copilot Instructions](.github/copilot-instructions.md) — Mandatory workflow for all changes
- [MEMORY.md](../library/github-baseline/MEMORY.md) — Operational decision tracking

---

**Document Version**: 1.0.0  
**Last Updated**: 2026-05-11  
**Locale**: English (American)  
**Status**: Stable, ready for production use
