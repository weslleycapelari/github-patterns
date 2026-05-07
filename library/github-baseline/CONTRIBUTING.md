# Contributing Guide

This repository is **Copilot-Managed** — it uses AI agents and governance rules to ensure consistent quality. This guide applies equally to human contributors and AI assistants.

---

## Table of Contents

1. [Prerequisites](#1-prerequisites)
2. [Branch Strategy](#2-branch-strategy)
3. [Commit Convention](#3-commit-convention)
4. [Working with AI Agents](#4-working-with-ai-agents)
5. [Development Workflow](#5-development-workflow)
6. [Pull Request Standards](#6-pull-request-standards)
7. [Code Quality Rules](#7-code-quality-rules)
8. [Testing Requirements](#8-testing-requirements)
9. [Security](#9-security)
10. [Getting Help](#10-getting-help)

---

## 1. Prerequisites

Before contributing, ensure you have:

- [ ] Read `.github/copilot-instructions.md` (core engineering rules)
- [ ] `gh` CLI installed and authenticated
- [ ] Access to open issues or an approved task before starting work

---

## 2. Branch Strategy

All work must happen in a dedicated branch. Never commit directly to `main`.

| Prefix | Purpose | Example |
| --- | --- | --- |
| `feat/` | New feature or capability | `feat/add-auth-flow` |
| `fix/` | Bug fix | `fix/null-pointer-login` |
| `chore/` | Maintenance, deps, config | `chore/update-dependencies` |
| `docs/` | Documentation only | `docs/update-readme` |
| `refactor/` | Code change without behavior change | `refactor/extract-validator` |
| `test/` | Tests only | `test/add-unit-coverage` |

```bash
git checkout -b feat/your-feature-name
```

---

## 3. Commit Convention

This project uses **Conventional Commits**. Each commit message must follow:

```plaintext
<type>(<scope>): <short description>

[optional body: explain WHY, not what]

[optional footer: BREAKING CHANGE or issue ref]
```

**Types:** `feat` · `fix` · `docs` · `style` · `refactor` · `test` · `chore` · `perf`

**Examples:**

```plaintext
feat(auth): add JWT refresh token rotation
fix(api): handle null response on user lookup
chore(deps): bump eslint to v9
```

> Breaking changes must include `BREAKING CHANGE:` in the footer and a `!` after the type: `feat!:`

---

## 4. Working with AI Agents

This repo ships AI agents in `.github/agents/`. Always engage the right agent before starting a task.

| Agent | When to Use |
| --- | --- |
| `@repo-architect` | Setting up a new repo or installing governance assets |
| `@agent-factory` | Creating a new specialist agent |

**Rules for AI contributions:**

- Follow `.github/copilot-instructions.md` at all times.
- Never generate files without explicit user confirmation (`CONFIRM`).
- Never assume context — ask clarifying questions before acting.
- All AI-generated code is subject to the same review process as human code.

---

## 5. Development Workflow

```plaintext
1. Pick or create an issue
        ↓
2. Create a branch (see §2)
        ↓
3. Write the test first (TDD)
        ↓
4. Implement the minimum code to pass the test
        ↓
5. Refactor if needed (no behavior change)
        ↓
6. Commit following Conventional Commits (see §3)
        ↓
7. Open a Pull Request (see §6)
```

---

## 6. Pull Request Standards

### Before Opening a PR

- [ ] All tests pass locally
- [ ] No linting errors
- [ ] PR description follows the template in `.github/pull_request_template.md`
- [ ] Linked to the related issue (`Closes #123`)

### Review Requirements

- Minimum **1 approval** required before merge.
- `main` branch is protected — force-pushes and direct commits are blocked.
- Squash merge preferred to keep history clean.

### PR Title

Must follow Conventional Commits format:

```plaintext
feat(scope): short description
```

---

## 7. Code Quality Rules

Enforced by `.github/copilot-instructions.md` and CI checks:

- **KISS**: Write the simplest solution that works.
- **DRY**: Extract repeated logic into shared utilities.
- **Immutability**: Prefer `map`, `filter`, spread operators over mutating state.
- **Early Returns**: Use guard clauses — avoid deeply nested `if` blocks.
- **Self-Documenting Code**: Name things clearly. Comments explain *why*, not *what*.
- **No dead code**: Do not leave commented-out code in PRs.

---

## 8. Testing Requirements

- **TDD is mandatory**: Write tests before implementation.
- Every new function or module must have unit tests.
- PRs that reduce test coverage will not be approved.
- Use the project's established test framework (check `README.md` for stack-specific details).

**Test naming convention:**

```javascript
describe('functionName', () => {
  it('should <expected behavior> when <condition>', () => { ... })
})
```

---

## 9. Security

- Never commit secrets, API keys, tokens, or credentials — use environment variables.
- Do not disable security scanners or bypass branch protection rules.
- Report vulnerabilities privately via **GitHub Security Advisories**, not as public issues.
- Dependencies with known critical CVEs must be updated before merging.

---

## 10. Getting Help

- **Questions about the codebase**: Open a Discussion in the GitHub Discussions tab.
- **Bug reports**: Open an issue using the Bug Report template.
- **Feature requests**: Open an issue using the Feature Request template.
- **Security issues**: Use GitHub Security Advisories (private disclosure).
