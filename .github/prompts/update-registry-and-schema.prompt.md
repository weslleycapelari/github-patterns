# Prompt: Update Registry and Schema

## Objective

Apply coherent updates to `registry.json` and `docs/schemas/registry.schema.json` with validation.

## Instructions

1. Gather current registry and schema contracts.
2. Delegate proposal generation to a subagent.
3. Delegate independent contract review to another subagent.
4. Apply changes and validate instance against schema.
5. Return compatibility notes.

## Required Output

- Updated registry snippet or full update
- Updated schema snippet or full update
- Validation result summary
- Breaking-change note (if any)

## Quality Bar

- [ ] Registry and schema are contract-aligned.
- [ ] Validation command output is captured.
- [ ] Version and lastUpdated handling is justified.
- [ ] No stale or orphaned references remain.

## Confirmation Gate

Request confirmation before finalizing when any of the following applies:

- breaking schema changes
- required field changes
- category contract changes
- version bump beyond patch

## Example

"Add a new stack with assets, update registry entries, and adjust schema only if contract fields change."
