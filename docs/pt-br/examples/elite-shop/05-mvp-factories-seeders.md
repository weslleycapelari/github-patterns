# MVP Prompt 01 — Factories, Seeders e base de dados

## Objetivo

Criar factories e seeders iniciais para catálogo com variações e usuário admin.

## Prompt

```text
Você está no projeto Laravel 13.8 "Elite-Shop" (e-commerce com variações de produto).

Estrutura já existente:
- app/Models: Product, ProductVariant, ProductAttribute, ProductVariantValue, StockMovement, User
- app/Enums: ProductStatus (Draft/Active/Inactive), StockMovementType
- 5 migrations em database/migrations/ (produtos, atributos, variantes, valores, movimentos de estoque)
- app/Services/ProductService.php (já implementado)
- app/DataTransferObjects: ProductData, ProductVariantData

TAREFA: Gere os seguintes arquivos seguindo as regras do .github/copilot-instructions.md (imutabilidade, early return, sem console.log, funções < 50 linhas):

1. **database/factories/ProductFactory.php**
   - Usa ProductStatus enum; gera name, slug (Str::slug), description, base_price (10-500)
   - State: active(), draft(), inactive()

2. **database/factories/ProductVariantFactory.php**
   - Gera sku único (SKU-{fake()->unique()->numerify('####')}), price_override nullable, stock_quantity (0-100), is_active bool

3. **database/factories/ProductAttributeFactory.php**
   - Gera name ('Cor', 'Tamanho', 'Material'), position

4. **database/factories/UserFactory.php** (substituir o padrão Laravel)
   - Adiciona state: admin() que seta is_admin=true (após adicionar coluna)

5. **database/seeders/ProductSeeder.php**
   - Cria 10 produtos active, cada um com 2 atributos e 3 variantes com valores

6. **database/seeders/DatabaseSeeder.php**
   - Chama UserFactory (1 admin: admin@elite-shop.com / password), ProductSeeder

7. **Adicionar migration** para adicionar coluna `is_admin boolean default false` na tabela users

Para cada arquivo, escreva o teste Pest correspondente em tests/Unit/Factories/ verificando que as factories geram os dados corretamente. Use RefreshDatabase.
```

## Critérios de aceite

- Factories com states e ranges corretos.
- Seeder principal criando usuário admin e catálogo base.
- Migração `is_admin` aplicada.
- Testes de factory passando.
