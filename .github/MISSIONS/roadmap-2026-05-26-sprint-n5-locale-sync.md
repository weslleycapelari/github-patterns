# Mission File — Sprint N5: Locale Sync & L4 Stabilization

**Mission ID:** `MISSION-N5-2026-05-26`  
**Sprint:** N5 — Locale Sync & L4 Stabilization  
**Duration:** 2026-05-26 to 2026-06-09 (2 weeks)  
**Status:** Approved & Active

Parent_Agent: roadmap-steward
Child_Agent: documentation-steward
Mission_Objective: Stabilize Level 4 (Self-Auditable) by eliminating locale drift between English and Portuguese documentation, operationalizing sync automation in CI, and updating governance docs to reflect current maturity status.
Context_Links:
- ROADMAP.md
- .github/MISSIONS/roadmap-2026-05-12-sprint-n4-hardening.md
- .github/workflows/marketplace-integrity.yml
- library/github-baseline/MEMORY.md
Success_Criteria:
- PT-BR documentation in sync with EN (0 content divergences)
- Locale-specific issues corrected
- Governance docs reflect L4 as "In Progress"
- Locale sync validation in CI
- PR declaration requirement for locale sync enforced
Result_Payload:
- List of divergences found and fixed
- Updated governance documentation blocks
- CI locale sync validation evidence
- Decision log with traceable rationale

---

## Mission Objective

Stabilize **Level 4 (Self-Auditable)** by eliminating locale drift between English and Portuguese documentation, operationalizing sync automation in CI, and updating governance docs to reflect current maturity status.

**Why This Matters:**

- Post-N4 audit identified documentação PT-BR dessincronizada (typos in Spanish, stale L4 references)
- Sync automation (`sync-locales.prompt.md`) exists but was never operationalized
- Docs claim "L4 is Next Goal" even though it's now "In Progress"
- Without automated sync validation, drift will accumulate with every PR

**Outcome:** Repositories and teams can trust documentation as source of truth; locale sync is automated and validated.

---

## Parent Agent & Delegation

- **Parent Agent:** `@roadmap-steward`
- **Child Agents:**
  - `@documentation-steward` — Tasks 1 & 2
  - `@project-auditor` — Task 3

---

## Success Criteria (Definition of Done)

- ✅ PT-BR documentation is fully in sync with EN (0 content divergences)
- ✅ All locale-specific issues corrected ("Ejecute" → "Execute", L4 status updated, etc.)
- ✅ Governance docs (governance-maturity-model.md, zero-inertia-command.md) reflect L4 as "In Progress"
- ✅ Locale sync validation step deployed in CI (marketplace-integrity.yml or new workflow)
- ✅ CI blocks PRs that lack valid locale sync declaration
- ✅ Manual testing confirms sync step works as specified
- ✅ ROADMAP.md updated: N5 marked "✅ Completed", next sprint (N6) outlined
- ✅ MEMORY.md receives entry: MEM-20260513-01 documenting N5 approval & completion

---

## Context Links

- **Audit Report:** Generated 2026-05-13 post-N4 completion
- **Gap Analysis:** 2 HIGH gaps (PT-BR drift, sync automation missing) + 2 MEDIUM gaps
- **Maturity Status:** L4 threshold met (100% eval coverage, CI audit operational); entering stabilization phase
- **Previous Mission:** [N4 Hardening](roadmap-2026-05-12-sprint-n4-hardening.md)

---

## Tasks Breakdown

### Task 1: Execute sync-locales & Validate PT-BR Coherence

**Owner:** `@documentation-steward`  
**Acceptance Gate:** Before Task 2 starts

**What to do:**

1. Run comprehensive audit of `docs/en/` vs `docs/pt-br/` using sync-locales.prompt.md
2. Identify and fix all divergences (content, structure, locale-specific issues)
3. Correct known issues:
   - "Ejecute" (Spanish) → "Execute" (Portuguese) in zero-inertia-command.md
   - L4 status references update: "🎯 Next Goal" → "🚧 In Progress"
4. Validate structure mirrors: EN examples ↔ PT-BR examples

**Output Contract:**

- List of all divergences found (with locations)
- Corrected file blocks (ready to paste)
- Validation table (File | Status: Aligned/Fixed)
- Decision log (each change + reasoning)

**PASS Criteria:**

- No Spanish words in PT-BR locale
- All L4 references show "In Progress" (not "Next Goal")
- EN and PT-BR structures identical
- All links valid
- Decision log complete

---

### Task 2: Update Governance Docs to Reflect L4 Status

**Owner:** `@documentation-steward`  
**Prerequisite:** Task 1 complete  
**Acceptance Gate:** Before Task 3 starts

**What to do:**

1. Update L4 status in `library/standards/governance-maturity-model.md`:
   - Change "🎯 Next Goal" → "🚧 In Progress"
   - Add note: "Eval coverage 100%, CI audit operational, entering stabilization phase"
2. Update `docs/en/zero-inertia-command.md` (and sync PT-BR):
   - Mention L4 achievement in appropriate section
   - Update any stale references to L4 timeline
3. Update `ROADMAP.md`:
   - Add closure note for N4 sprint
   - Clearly mark N5 as current sprint
   - Outline N6 in backlog (as placeholder)

**Output Contract:**

- Updated content blocks for each file
- Before/after comparison
- Grep confirmation: "Next Goal" removed, "In Progress" inserted
- Timestamp: 2026-05-13 (decision date)
- Decision log

**PASS Criteria:**

- All 3 files updated
- L4 shows "In Progress", L5 stays "Vision"
- Timestamp + decision note in each file
- No broken Markdown syntax
- No new broken references

---

### Task 3: Operationalize Locale Sync Validation in CI

**Owner:** `@project-auditor`  
**Prerequisite:** Task 2 complete  
**Acceptance Gate:** Manual test confirms functionality

**What to do:**

1. Extend `.github/workflows/marketplace-integrity.yml` with new step: "Locale Sync Validation (PR)"
   - Or create new workflow if appropriate
2. Step should validate:
   - Files in `docs/en/` have PT-BR equivalents (and vice versa)
   - No Spanish text in EN locale (sanity check)
   - Files contain valid locale sync declaration block
3. Report divergences as PR annotations (specific paths)
4. Behavior:
   - **PASS:** All checks clear → exit code 0
   - **FAIL:** Divergence or missing declaration → exit code 1 (blocks PR)

**Output Contract:**

- YAML step definition (ready to paste)
- Shell/Python script for checks (inline or as .github/scripts/)
- Example PASS/FAIL run output
- Test evidence (actual run results)

**PASS Criteria:**

- Step runs on every PR touching `docs/` or `library/examples/`
- Detects missing PT-BR equivalents
- Detects stale locale declarations
- Blocks PR on HIGH divergences
- Manual test run confirms works correctly
- Decision log complete

---

## Risk Mitigation

| Risk                                                | Severity | Mitigation                                                                                    |
| --------------------------------------------------- | -------- | --------------------------------------------------------------------------------------------- |
| PT-BR sync uncovers more drift than expected        | Medium   | Work in parallel (Tasks 1 & 2); cap extra findings at 2h, defer rest to N6                    |
| CI validation step has edge cases                   | Medium   | Thorough testing on branch; fallback: disable on initial merge, re-enable after manual review |
| Locale declaration format becomes point of friction | Low      | Standardize early (YAML comment block), document in contributing guidelines                   |

---

## Delivery Target

**Delivery Date:** 2026-06-09  
**Merge Criteria:**

- All 3 tasks PASS
- ROADMAP.md updated (N5 "✅ Completed", N6 outlined)
- MEMORY.md entry created (MEM-20260513-01)
- PR approved by roadmap-steward + documentation-steward

---

## Decision Log

| Date       | Agent           | Decision                               | Context                                                                                                                       |
| ---------- | --------------- | -------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| 2026-05-13 | roadmap-steward | **Sprint N5 approved**                 | Post-N4 audit identified 2 HIGH gaps (PT-BR sync, sync automation). N5 addresses both + updates docs. Master prompt provided. |
| 2026-05-13 | roadmap-steward | **Sync automation priority elevated**  | Was in backlog; moved to current sprint due to HIGH impact on trust/docs quality.                                             |
| 2026-05-13 | roadmap-steward | **L4 status updated to "In Progress"** | 100% eval coverage achieved, CI audit operational. Level 4 threshold met; now in maturation phase.                            |
| 2026-05-13 | roadmap-steward | **Entry gate for Swift clarified**     | Defer until 2 stable sprints post-L4 (N5 + N6). Reduces ambiguity; explicit criteria: "zero regressions in L4 gates."         |

---

## Next Actions (After N5 Completion)

1. **Sprint N6 Planning** (2026-06-09):
   - Re-audit maturity post-N5
   - Evaluate Swift readiness (has 2-sprint stabilization gate been met?)
   - Plan N6 scope (documentation automation, Swift expansion, or other)

2. **Ongoing:**
   - Maintain MEMORY.md entries (≥1 per sprint)
   - Keep ROADMAP.md current
   - Monitor L4 gates for regressions

---

**Mission File Version:** 1.0.0  
**Last Updated:** 2026-05-13  
**Status:** Active & Approved
