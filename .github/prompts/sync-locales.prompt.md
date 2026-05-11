# Prompt: Sync Locales (en ↔ pt-br)

## Objective

Keep `docs/en` and `docs/pt-br` semantically synchronized (no detectable semantic drift under this prompt criteria) by comparing paired files and applying a direct translation patch to the target locale file.

## Context

This repository maintains bilingual documentation (`en` and `pt-br`). Any semantic drift between paired files is a documentation defect and must be corrected in the same workflow with explicit sync status reporting.

## Input Contract

Required inputs:

1. `source_file`: path under `docs/en/` or `docs/pt-br/`.
2. `target_locale`: `en` or `pt-br` (the file to be patched).
3. `change_scope`: `full-file` or specific sections/headings.
4. `preserve_rules`:
   - Keep headings structure and ordering unless source changed.
   - Keep code blocks, commands, paths, IDs, and schema keys unchanged.
   - Translate meaning, not literals, except technical tokens.

Validation rules:

- A valid locale pair must resolve to:
  - `docs/en/<same-relative-path>`
  - `docs/pt-br/<same-relative-path>`
- `target_locale` must be the opposite locale of `source_file`:
  - if `source_file` is under `docs/en/`, `target_locale` must be `pt-br`;
  - if `source_file` is under `docs/pt-br/`, `target_locale` must be `en`.
- If pair file does not exist, stop edits and return `status: blocked` with exact missing path in `blocked_reason`.

## Workflow

1. Resolve locale pair:
   - Map `source_file` to its equivalent path in the opposite locale.
   - Confirm both files exist before editing.

2. Read and compare semantics:
   - Compare objective, procedures, constraints, and expected outcomes.
   - Detect semantic gaps (missing steps, altered requirements, outdated references, inconsistent terminology).

3. Build gap list (audit-first):
   - Produce a concise list of semantic deltas with section references.

4. Apply direct patch to target file:
   - Generate and apply translation edits directly in the target locale file.
   - Preserve technical literals (commands, paths, identifiers, JSON keys, schema fields).
   - Do not introduce net-new behavior not present in source.

5. Declare final sync status:
   - Return `done` when no semantic gaps remain.
   - Return `pending` only if blocked, with explicit pending tasks.

## Expected Output

Return exactly:

1. `status`: `done|pending|blocked`.
2. `patched_file`: target file path (or `none` when blocked).
3. `semantic_gaps_found`: concise bullets with section mapping.
4. `patch_summary`: what changed (procedures, wording, references).
5. `sync_status`:
   - `en_status`: `done|pending`
   - `pt_br_status`: `done|pending`
   - `pending_sync_tasks`: explicit actionable list (must be non-empty when any status is `pending`)
6. `blocked_reason`: explicit reason when `status=blocked` (otherwise `none`)

## Guardrails

- Do not change meaning in source-of-truth requirements.
- Do not modify commands, URLs, file paths, IDs, schema/property names.
- Do not claim sync completion without semantic comparison evidence.
- If blocked by missing pair file, stop edits and report `pending_sync_tasks`.

## Example

Input:

- `source_file`: `docs/en/registry.md`
- `target_locale`: `pt-br`
- `change_scope`: `full-file`

Expected behavior:

- Map pair to `docs/pt-br/registry.md`
- Compare semantic content section-by-section
- Patch `docs/pt-br/registry.md` to remove semantic drift
- Return:
  - `en_status: done`
  - `pt_br_status: done`
  - `pending_sync_tasks: []`
