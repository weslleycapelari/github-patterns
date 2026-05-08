# Example 02 — Branch Protection Hardening in Phase B

## Goal

Configure merge governance for the main branch with two mandatory approvals and validation of the `ci/test` check.

## Why this matters

`Phase B` protects the merge flow against silent failures such as:

- direct pushes to the main branch;
- merges without review;
- force-pushes and accidental deletion;
- drift between documented governance and actual enforcement.

## Expected inputs

Before executing this step, confirm:

- target repository (`owner/repo`);
- actual protected branch name;
- minimum approval count;
- exact status-check name (`ci/test` or equivalent);
- owners/teams that should participate in review;
- whether admins should also be covered by the rules.

## Prompt

```text
Asset contract: SB-CORE (see this directory's README.md, section "Prompt Asset Contract"). Step delta: explicitly use `prompts/start-phase-b.prompt.md`.
Use the governance prompt at:
https://raw.githubusercontent.com/weslleycapelari/github-patterns/main/prompts/start-phase-b.prompt.md
Help me configure the Ruleset for the 'main' branch.
Require 2 approvals and mandate that the 'ci/test' check passes.
```

## Expected generated artifacts

- Ruleset configuration for the main branch;
- `required_approving_review_count = 2` rule;
- required status-check block with `ci/test`;
- `CODEOWNERS` guidance when applicable;
- explicit post-configuration validation step.

## Expected result

- Proposed protection rules for `main`.
- Requirement of 2 approvals.
- Mandatory `ci/test` status check before merge.
- Guidance to validate the configured Ruleset.

## Execution checklist

- [ ] Confirm the main branch is actually `main`.
- [ ] Validate the exact `ci/test` check name in GitHub Actions.
- [ ] Review whether the Ruleset includes deletion and non-fast-forward protection.
- [ ] Verify the configuration covers owners and admins as expected.

## Validation points

- `2 approvals` effectively configured.
- `ci/test` present as a required status check.
- protected branch correctly identified.
- result stays coherent with the official `start-phase-b.prompt.md` prompt.

## Acceptance criteria

- Target branch explicitly set to `main`.
- Two-approval requirement represented in the configuration.
- `ci/test` included as a required check.
- Result stays aligned with the official `start-phase-b.prompt.md` prompt.

## Common mistakes

- Using a check name that does not actually exist in the repository.
- Assuming `main` without confirming the real default branch.
- Treating `CODEOWNERS` as optional when structured review is part of the rule set.
- Configuring governance without validating active enforcement afterwards.

## Next step

Once the main branch is protected, continue to `03-project-audit.md` to audit the critical reservation flows.
