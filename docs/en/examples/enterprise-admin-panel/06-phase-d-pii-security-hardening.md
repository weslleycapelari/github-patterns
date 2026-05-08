# Enterprise Admin Panel — Example 06: Phase D security and PII hardening

## Goal

Apply `Phase D (Advanced Security)` principles to the admin panel with emphasis on PII protection, access boundaries, and safe data exposure in the front-end.

## Step context

A corporate admin panel often displays data that should not appear fully in every screen, log, component, export, or support screenshot. Without an explicit strategy, the front-end leaks PII through tables, tooltips, telemetry, and debugging flows.

## Expected inputs

- minimum product definition of PII;
- existing roles and access levels;
- higher-sensitivity flows (`billing`, `employees`, `customers`, etc.);
- audit and observability policy.

## Prompt

```text
Asset contract: EAP-CORE (see this directory's README.md, section "Prompt Asset Contract"). Step delta: explicitly apply the Phase D security reference.
Copilot, apply a Phase D security hardening plan for this enterprise admin panel.
Focus on PII protection, role-based UI boundaries, safe logging, masking/redaction, and secure handling of sensitive fields in React screens.
Keep the plan actionable for a React 18 + TypeScript dashboard and aligned with governance-first repository standards.
```

## Expected generated artifacts

- matrix or inventory of sensitive data;
- masking/redaction rules by context;
- criteria for conditional rendering by role/permission;
- recommendations for logging, telemetry, and secure exports.

> Mapping note: in the marketplace, the source of truth for security lives in `library/standards/security-hardening.md`. In the target project, it may be materialized as `docs/standards/security.md`.

## Expected result

By the end of this step, the team should have a clear plan to:

- reduce accidental PII exposure in the UI;
- distinguish visible, partially masked, and fully hidden data;
- strengthen trust between front-end, back-end, and compliance expectations.

## Execution checklist

- [ ] Identify which fields truly count as PII.
- [ ] Separate API authorization from interface authorization.
- [ ] Cover logs, toasts, exports, and tables, not only forms.
- [ ] Record residual risks and backend-dependent items.

## Acceptance criteria

- There is at least one practical inventory of sensitive data.
- The plan includes masking/redaction with verifiable criteria.
- UI access boundaries are not treated as a substitute for backend authorization.
- There is guidance for observability without data leakage.

## Common mistakes

- Assuming hiding a field in the UI solves security by itself.
- Forgetting that logs and errors can also carry PII.
- Treating Phase D as a generic checklist without mapping real flows.

## Next step

Move to `07-wcag-22-accessibility-audit.md` to turn accessibility into a concrete audit with evidence and backlog.
