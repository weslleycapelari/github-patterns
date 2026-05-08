# Example 04 — Standards-Driven Implementation (TDD First)

## Goal

Generate tests before implementing `ProductService`, aligning `llms.txt` with design/testing standards.

## Prompt

```text
Copilot, using this project's llms.txt, implement the ProductService class.
Follow the Immutability and Early Return rules from docs/standards/code-design.md.
Before writing logic, generate the Pest test file following docs/standards/testing.md.
```

## Standards mapping note

In the marketplace, the source files for these standards are:

- `library/standards/code-design-logic.md`
- `library/standards/testing-excellence.md`

In the target project, they are usually materialized as `docs/standards/code-design.md` and `docs/standards/testing.md`.

## Expected result

- Pest test file created first (RED phase).
- `ProductService` implemented after tests (GREEN phase).
- Immutability and Early Return rules respected.

## Acceptance criteria

- TDD order proven (tests before service).
- Transactions and validations in critical write paths.
- Tests executed and in-scope regressions corrected.
