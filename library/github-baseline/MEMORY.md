# MEMORY.md — Project Context Memory

## Objective

Keep a lightweight, auditable memory of operational facts shared across human and AI sessions.

> Scope: execution memory only. This file complements (does not replace) ADRs, changelog, issues, PRs, and functional docs.

---

## Operating Rules (keep it practical)

1. Add new entries at the **top** of each section.
2. Every entry must include:
   - **ID** (`MEM-YYYYMMDD-XX`)
   - **Date** (`YYYY-MM-DD`)
   - **Owner** (person/team/agent)
   - **Record** (objective fact, 1–3 lines)
   - **Impact** (why it matters)
   - **Evidence/Link** (issue/PR/commit/ADR/chat) or `N/A` with reason
   - **Status** (allowed values defined per section)
3. If an item is no longer valid, mark it as **`[OBSOLETE YYYY-MM-DD]`** and add a short reason.
4. Prefer factual language over assumptions ("observed", "validated by", "pending validation").
5. Keep entries short and actionable; avoid long narratives.
6. Quick housekeeping: do a light review at least once per month (remove noise, obsolete stale items).

---

## Security Guardrails

- Never record secrets, tokens, credentials, private keys, or connection strings.
- Never include sensitive personal data (PII).
- Avoid pasting raw logs that may contain secrets; sanitize first.
- If sensitive details are needed for traceability, reference a secure system link instead of copying content.

---

## Implemented Modules

### Status values

`active` | `obsolete`

### Entry template

- **ID:** MEM-YYYYMMDD-XX
- **Date:** YYYY-MM-DD
- **Owner:**
- **Record:**
- **Impact:**
- **Evidence/Link:** (or `N/A: <reason>`)
- **Status:** active | obsolete

### Entries

<!-- Add new entries at the top -->

- **ID:** MEM-20260512-03
- **Date:** 2026-05-12
- **Owner:** asset-factory (sprint N4 Hardening)
- **Record:** Continuous governance audit (eval coverage) operationalised in `marketplace-integrity.yml`. New step runs on every PR: audits `library/evals/<agent-id>/` against registered agents, classifies gaps by severity (HIGH/MEDIUM/PASS), publishes table in PR Step Summary, and fails CI when any agent has zero eval cases.
- **Impact:** Every PR that adds an agent without evals will fail CI immediately — eliminates silent eval debt.
- **Evidence/Link:** `.github/workflows/marketplace-integrity.yml` — step `Governance Audit — Eval Coverage Report (PR)`
- **Status:** active

---

- **ID:** MEM-20260512-02
- **Date:** 2026-05-12
- **Owner:** asset-factory (sprint N4 Hardening)
- **Record:** Eval coverage for `agent-factory`, `issue-ops-architect`, and `rule-distiller` completed. Asset Review Board found 3 HIGH findings: (H1) missing "Title and Mission" section in AGFAC-02; (H2) false FAIL risk in IOA-02 for agent-spec-mandated registry fetch URL; (H3) non-deterministic section title (PT vs EN) in RD-02. All 3 corrected before merge.
- **Impact:** Eval files now correctly reflect agent contracts. Prevents false positives in eval execution.
- **Evidence/Link:** `library/evals/agent-factory/case-02-expected-high-quality-output.md`, `library/evals/issue-ops-architect/case-02-expected-high-quality-output.md`, `library/evals/rule-distiller/case-02-expected-high-quality-output.md`
- **Status:** active

---

- **ID:** MEM-20260512-01
- **Date:** 2026-05-12
- **Owner:** roadmap-steward
- **Record:** Sprint N4 Hardening initiated. Three priority objectives: (1) close eval gap for 3 agents, (2) operationalise PR governance audit, (3) activate MEMORY.md decision routine. Mission file created at `.github/MISSIONS/roadmap-2026-05-12-sprint-n4-hardening.md`.
- **Impact:** Moves repository from N3 (AI-Driven) toward N4 (Self-Auditable) maturity. Eval coverage now ≥90%.
- **Evidence/Link:** `ROADMAP.md` — sprint N4 Hardening section; `.github/MISSIONS/roadmap-2026-05-12-sprint-n4-hardening.md`
- **Status:** active

---

## Known Failures/Bugs

### Status values

`active` | `mitigated` | `obsolete`

### Entry template

- **ID:** MEM-YYYYMMDD-XX
- **Date:** YYYY-MM-DD
- **Owner:**
- **Record:**
- **Impact:**
- **Temporary Mitigation:** (required when known)
- **Evidence/Link:** (or `N/A: <reason>`)
- **Status:** active | mitigated | obsolete

### Entries

<!-- Add new entries at the top -->

---

## User-approved Ad-hoc Conventions

### Status values

`active` | `obsolete`

### Entry template

- **ID:** MEM-YYYYMMDD-XX
- **Date:** YYYY-MM-DD
- **Owner:**
- **Record:**
- **Impact:**
- **Evidence/Link:** (or `N/A: <reason>`)
- **Status:** active | obsolete

### Entries

<!-- Add new entries at the top -->
