# Marketplace Registry Documentation (registry.json)

## 1. Purpose

The registry.json file is the canonical machine-readable catalog for this repository. It defines:

- Which governance phases exist and which assets each phase requires.
- Which technology stacks are supported and which assets are recommended.
- Where each asset is stored and how automation tools should resolve download URLs.

In practical terms, registry.json is the contract between the marketplace repository and any orchestrator, setup script, or Copilot workflow that consumes it.

## 2. File Location and Validation

- Registry file: registry.json
- JSON Schema file: docs/schemas/registry.schema.json
- Schema language: English (field descriptions and constraints)

registry.json includes a local schema pointer via the $schema field, enabling validation in supporting tools.

## 3. Root Metadata

Required root fields:

- version: Semantic version of the registry format (for compatibility handling in automation).
- lastUpdated: ISO-8601 date-time indicating when the catalog changed.
- maintainer: Human or service identifier responsible for the registry.
- endpoint_base: Base URL used to build full raw download links.
- core: Governance blueprint definitions.
- stacks: Stack-specific recommendations.
- assets: Global catalog of installable units.

### 3.1 Notes on endpoint_base

- Must be a valid URI.
- Should end with a trailing slash to allow deterministic concatenation with relative paths.

## 4. Core Governance Model

The core section groups governance models. Each model contains phases.

Current model example:

- github_100_percent

Each phase entry must include:

- name: Human-readable phase title.
- assets: Non-empty array of asset IDs required in that phase.

The schema requires phases A, B, C, D, and E for each core model to keep progression consistent.

## 5. Stack Recommendations

The stacks section maps a stack key (for example, nodejs, python) to:

- display_name: Label for UX menus.
- recommended_assets: Non-empty list of asset IDs to bootstrap that stack.

These recommendations are additive guidance; orchestrators can merge them with phase requirements.

## 6. Asset Catalog

The assets section is typed by category.

### 6.1 agents

Each agent definition requires:

- id
- path
- description
- version (semantic version)
- tags (non-empty, unique)

### 6.2 instructions

Each instruction definition requires:

- id
- path
- target (recommended destination path in the consumer repository)
- description

### 6.3 mcp_servers

Each MCP server definition requires:

- id
- type (config or tool)
- path
- description

## 7. Expected Consumer Workflow

1. Fetch registry.json.
2. Validate against docs/schemas/registry.schema.json.
3. Ask user for selected stack and target governance phase.
4. Resolve required asset IDs from core phases and stack recommendations.
5. Resolve each asset ID to assets paths.
6. Build final download URLs using endpoint_base + path.
7. Materialize files into target repository.

## 8. Validation Command (PowerShell)

Use Test-Json in PowerShell:

```powershell
Test-Json -Path .\registry.json -SchemaFile .\docs\schemas\registry.schema.json
```

Expected output:

- True when registry.json is valid.

## 9. Maintenance Guidelines

When adding or updating entries:

1. Add or update the asset under assets with complete required fields.
2. Reuse the same asset id in phase assets and stack recommended_assets.
3. Keep versions and descriptions accurate.
4. Update lastUpdated.
5. Re-run schema validation before committing.

## 10. Compatibility and Evolution

For non-breaking catalog growth:

- Add new asset entries.
- Add new stack keys.
- Extend phase asset lists.

For breaking changes in structure:

- Bump registry version.
- Update schema and documentation together.
- Communicate migration expectations to orchestrator maintainers.
