# Prompt: Start Phase B — Merge Governance

This prompt guides the full configuration of merge governance for a repository. Phase B ensures that `main` is protected, all changes go through Pull Requests, and the right people are responsible for reviewing critical paths.

---

## Context

The user wants to apply **Phase B** of the GitHub 100% guide to their repository. This phase covers:

- Branch protection via GitHub Rulesets
- Merge strategy enforcement
- CODEOWNERS configuration
- Force-push and deletion blocking

Phase B should be applied after Phase A (README, CONTRIBUTING) is in place.

---

## Prerequisites

Before starting, verify:

1. The `gh` CLI is installed and authenticated:

   ```bash
   gh auth status
   ```

2. The user has **Admin** or **Owner** permissions on the repository.
3. The target branch name (`main` by default) is confirmed.

---

## Instructions for Copilot

### Step 1: Explain the "Why"

Briefly explain to the user what Phase B protects against:

- **Force-pushes** can silently overwrite commit history.
- **Direct commits to `main`** bypass review and break audit trails.
- **Branch deletion** can cause data loss and break CI references.
- **Unreviewed merges** introduce bugs and violate compliance requirements.

### Step 2: Collect Configuration Inputs

Ask the user:

```text
PHASE B - CONFIGURATION
------------------------
1. Repository (owner/repo):
2. Protected branch name (default: main):
3. Minimum required reviewers (default: 1):
4. Require status checks to pass before merge? (yes/no):
5. Status check names (e.g.: "ci/build", "ci/test"), if applicable:
6. Who are the CODEOWNERS? (GitHub usernames or teams, e.g.: @org/backend-team):
7. Should admins also be subject to these rules? (yes/no):
```

### Step 3: Create the Ruleset

Generate the `gh` CLI command to create a branch Ruleset:

```bash
gh api \
  --method POST \
  -H "Accept: application/vnd.github+json" \
  /repos/{owner}/{repo}/rulesets \
  --input - <<'EOF'
{
  "name": "protect-main",
  "target": "branch",
  "enforcement": "active",
  "conditions": {
    "ref_name": {
      "include": ["refs/heads/main"],
      "exclude": []
    }
  },
  "rules": [
    { "type": "deletion" },
    { "type": "non_fast_forward" },
    {
      "type": "pull_request",
      "parameters": {
        "required_approving_review_count": 1,
        "dismiss_stale_reviews_on_push": true,
        "require_code_owner_review": true,
        "require_last_push_approval": true
      }
    }
  ]
}
EOF
```

Adjust `required_approving_review_count` based on the user's answer in Step 2.

### Step 4: Add Required Status Checks (if applicable)

If the user requires status checks, append this rule to the `rules` array:

```json
{
  "type": "required_status_checks",
  "parameters": {
    "strict_required_status_checks_policy": true,
    "required_status_checks": [
      { "context": "ci/build" },
      { "context": "ci/test" }
    ]
  }
}
```

Replace `ci/build` and `ci/test` with the actual check names provided.

### Step 5: Create the CODEOWNERS File

Generate the `.github/CODEOWNERS` file based on the user's inputs:

```bash
mkdir -p .github
cat > .github/CODEOWNERS <<'EOF'
# Global owners — review required on all changes
* @username-or-team

# Specific path overrides
# /.github/   @org/devops-team
# /src/auth/  @org/security-team
EOF
```

Explain to the user that more specific rules override less specific ones (bottom wins over top).

### Step 6: Validate

After applying the rules, verify protection is active:

```bash
gh api /repos/{owner}/{repo}/rulesets --jq '[.[] | {name: .name, enforcement: .enforcement}]'
```

Expected output should include `"enforcement": "active"` for the `protect-main` ruleset.

### Step 7: Commit and Document

Commit the CODEOWNERS file:

```bash
git add .github/CODEOWNERS
git commit -m "chore(governance): add CODEOWNERS for Phase B"
git push
```

---

## Expected Outcome

After Phase B is complete:

- [ ] Direct pushes to `main` are blocked for all users (including admins, if chosen).
- [ ] Force-pushes and branch deletion are blocked.
- [ ] All merges require at least 1 approved Pull Request review.
- [ ] Code owners are notified automatically when their paths change.
- [ ] Required CI checks must pass before merge (if configured).

---

## Suggested Next Step

"Phase B is active. Move to **Phase C** to add CI/CD workflows and quality gates to enforce tests and linting on every Pull Request."
