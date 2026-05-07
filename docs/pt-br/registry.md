# Documentação do Registro do Marketplace (registry.json)

## 1. Objetivo

O arquivo registry.json é o catálogo canônico e legível por máquina deste repositório. Ele define:

- Quais fases de governança existem e quais ativos cada fase exige.
- Quais stacks de tecnologia são suportadas e quais ativos são recomendados.
- Onde cada ativo está armazenado e como ferramentas de automação devem resolver URLs de download.

Na prática, o registry.json é o contrato entre o repositório de marketplace e qualquer orquestrador, script de setup ou fluxo do Copilot que consome esse conteúdo.

## 2. Localização dos Arquivos e Validação

- Arquivo de registro: registry.json
- Arquivo de schema: docs/schemas/registry.schema.json
- Linguagem do schema: inglês (descrições e restrições)

O registry.json inclui um ponteiro local de schema via campo $schema, permitindo validação por ferramentas compatíveis.

## 3. Metadados de Raiz

Campos obrigatórios na raiz:

- version: Versão semântica do formato do registro (controle de compatibilidade para automações).
- lastUpdated: Data/hora no padrão ISO-8601 indicando a última alteração do catálogo.
- maintainer: Identificador humano ou de serviço responsável pelo registro.
- endpoint_base: URL base para compor links completos de download.
- core: Definições dos blueprints de governança.
- stacks: Recomendações específicas por stack.
- assets: Catálogo global de unidades instaláveis.

### 3.1 Observações sobre endpoint_base

- Deve ser uma URI válida.
- Deve terminar com barra final para concatenação determinística com caminhos relativos.

## 4. Modelo de Governança Core

A seção core agrupa modelos de governança. Cada modelo contém fases.

Exemplo atual:

- github_100_percent

Cada fase deve conter:

- name: Título legível da fase.
- assets: Lista não vazia de IDs de ativos exigidos na fase.

O schema exige as fases A, B, C, D e E em cada modelo core para manter progressão consistente.

## 5. Recomendações por Stack

A seção stacks mapeia uma chave de stack (por exemplo, nodejs, python) para:

- display_name: Rótulo amigável para menus e interfaces.
- recommended_assets: Lista não vazia de IDs para bootstrap da stack.

Essas recomendações são orientativas e podem ser combinadas com os requisitos de fase.

## 6. Catálogo de Ativos

A seção assets é tipada por categoria.

### 6.1 agents

Cada definição de agente exige:

- id
- path
- description
- version (semver)
- tags (não vazio, sem duplicados)

### 6.2 instructions

Cada definição de instrução exige:

- id
- path
- target (destino recomendado no repositório consumidor)
- description

### 6.3 mcp_servers

Cada definição de servidor MCP exige:

- id
- type (config ou tool)
- path
- description

## 7. Fluxo Esperado de Consumo

1. Buscar o registry.json.
2. Validar contra docs/schemas/registry.schema.json.
3. Perguntar ao usuário a stack e a fase-alvo de governança.
4. Resolver IDs obrigatórios a partir das fases core e das recomendações da stack.
5. Resolver cada ID para caminhos em assets.
6. Montar URLs finais com endpoint_base + path.
7. Materializar arquivos no repositório de destino.

## 8. Comando de Validação (PowerShell)

Use Test-Json no PowerShell:

```powershell
Test-Json -Path .\registry.json -SchemaFile .\docs\schemas\registry.schema.json
```

Saída esperada:

- True quando registry.json estiver válido.

## 9. Diretrizes de Manutenção

Ao adicionar ou alterar entradas:

1. Adicione ou atualize o ativo em assets com todos os campos obrigatórios.
2. Reutilize o mesmo id em assets de fase e recommended_assets de stack.
3. Mantenha versões e descrições coerentes.
4. Atualize lastUpdated.
5. Reexecute a validação de schema antes de commitar.

## 10. Compatibilidade e Evolução

Para evolução sem quebra estrutural:

- Adicionar novos ativos.
- Adicionar novas stacks.
- Estender listas de ativos por fase.

Para mudanças estruturais com quebra:

- Incrementar a versão do registro.
- Atualizar schema e documentação em conjunto.
- Comunicar expectativas de migração para mantenedores dos orquestradores.
