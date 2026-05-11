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
