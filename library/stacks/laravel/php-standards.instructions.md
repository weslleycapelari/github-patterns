# PHP and Laravel Engineering Standards

This instruction set defines mandatory guidance for PHP and Laravel code generation and review.

## Core Rules

- Always use `declare(strict_types=1);` in PHP files.
- Require explicit types for parameters, returns, and properties.
- Prefer immutable value objects and DTOs at service boundaries.
- Keep controllers thin: HTTP translation only.
- Keep business logic in services/actions, not in routes/controllers/models.

## Validation and Security

- Validate all external input using FormRequest classes.
- Enforce authorization via policies/gates before state changes.
- Never hardcode secrets, tokens, or credentials.
- Apply least-privilege data access and explicit trust-boundary checks.
- Use framework-safe defaults for hashing, encryption, and CSRF/session handling.

## Data and Eloquent

- Prevent N+1 with explicit eager loading.
- Keep queries readable; extract complex filters to scopes/query objects.
- Avoid hidden side effects in model events unless clearly documented.
- Use transactions for multi-step state changes requiring consistency.

## Error Handling and Observability

- Use explicit domain/application exceptions for expected failures.
- Return consistent error envelopes at API boundaries.
- Log failures with actionable context (correlation IDs, actor, operation).
- Avoid swallowing exceptions; either handle or rethrow with context.

## Testing Discipline

- Follow test-first approach for new logic.
- Cover critical business rules with unit tests.
- Cover request/authorization/validation paths with feature tests.
- Include boundary and negative-path tests for sensitive flows.
- Keep tests deterministic and isolated from external side effects.

## Quality Gates

- No merge for untyped public APIs.
- No merge for missing validation/authorization on mutating endpoints.
- No merge for critical flows without tests.
- No merge for unresolved SECURITY BREACH findings.
