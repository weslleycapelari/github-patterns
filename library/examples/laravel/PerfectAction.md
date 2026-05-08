# PerfectAction.php — Referência de Excelência em Laravel

## Objetivo

Este arquivo demonstra um exemplo **production-ready** de um Service/Action no Laravel que implementa todos os padrões obrigatórios de excelência do repositório:

- ✅ `declare(strict_types=1)` e type hints explícitos em 100% da API pública
- ✅ DTOs imutáveis (input e output) com `readonly` properties
- ✅ Early returns e guard clauses para falhas rápidas
- ✅ Autorização via Policy (não gates)
- ✅ Validação via FormRequest
- ✅ Transações para operações multi-step
- ✅ Comentários `// AI-REFERENCE:` explicando cada padrão crítico
- ✅ Responsabilidade única (uma ação = um caso de uso)
- ✅ Testes com padrão AAA (Arrange, Act, Assert)

---

## Estrutura do Arquivo

### 1. **CreateProductVariantAction** (Classe Principal)

A ação encapsula um caso de uso: **criar uma variante de produto com autorização e stock inicial**.

#### Método público: `__invoke()`

```php
public function __invoke(
    CreateProductVariantRequest $request,
    User $user,
): ProductVariantCreated
```

**Por que `__invoke`?**

- Torna a ação invocável como função: `$action($request, $user)`
- Sintaxe limpa e expressiva
- Padrão comum em Laravel (jobs, commands, etc.)

**Fluxo:**

1. **Autorização** (early return) — falha rápido se não autorizado
2. **Transação** — garante atomicidade entre criação e alocação de stock
3. **Retorno imutável** — DTO com apenas dados necessários

#### Método privado: `authorize()`

```php
private function authorize(int $productId, User $user): void
```

**Por que separado?**

- Isolamento de responsabilidade
- Falha rápido antes de qualquer IO
- Política única e verificável
- Fácil de testar

**Policy vs. Gate:**

- **Gate:** global, sem contexto de modelo
- **Policy:** vinculada a um modelo, escala com seus dados

### 2. **CreateProductVariantRequest** (DTO Input)

Imutável, validada, com conversão segura de tipo:

```php
public function __construct(
    readonly public int $productId,
    readonly public string $sku,
    // ... outras propriedades
) {
    $this->validateInputs();
}
```

**Propriedades:**

- `readonly`: não pode ser reatribuída após construção
- Tipos explícitos: `int`, `string`, `float`, `?array`
- Validação no construtor: falha rápido se dados inválidos

**Factory method:**

```php
public static function fromValidated(array $validated): static
```

Converte dados pré-validados do FormRequest para DTO.

### 3. **ProductVariantCreated** (DTO Output)

Imutável, representa o resultado da ação:

```php
public function __construct(
    readonly public int $id,
    readonly public string $sku,
    // ... apenas dados necessários
) {
}
```

**Por que não retornar o Model?**

- DTO restringe quais dados são expostos
- Evita que o caller acesse ou mutue properties não intencionadas
- Contrato explícito entre ação e consumidor

### 4. **CreateProductVariantFormRequest**

Validação do framework no nível HTTP:

```php
public function rules(): array
{
    return [
        'product_id' => ['required', 'integer', 'exists:products,id'],
        'sku' => ['required', 'string', 'regex:/^[A-Z0-9\-]+$/'],
        // ...
    ];
}
```

**Separação:**

- **FormRequest:** valida entrada HTTP (XSS, injection, tipos)
- **DTO:** valida regras de negócio (preço > custo, etc.)

---

## Padrões Implementados

### 1. **Early Returns (Guard Clauses)**

```php
if (!$user->can('update', $product)) {
    throw new AuthorizationException(...);
}

if ($existingVariant instanceof ProductVariant) {
    throw new \InvalidArgumentException(...);
}
```

**Benefício:** Reduz nesting, deixa a lógica principal visível.

### 2. **Imutabilidade de DTOs**

```php
readonly public int $productId,
readonly public string $sku,
```

**Garantia:** Uma vez construído, o DTO não pode ser alterado. Falhas durante construção são imediatas.

### 3. **Type Hints Explícitos**

Em **parâmetros:**

```php
public function __invoke(
    CreateProductVariantRequest $request,
    User $user,
): ProductVariantCreated
```

Em **propriedades:**

```php
readonly public int $id,
readonly public string $sku,
```

Em **arrays retornados:**

```php
public function toArray(): array<string, mixed>
```

### 4. **Transações para Multi-Step Operations**

```php
return DB::transaction(
    fn () => $this->createVariant($request, $user)
);
```

**Garantia:** Se variant é criada mas stock falha, tudo é revertido. Sem inconsistência.

### 5. **Autorização via Policy**

```php
if (!$user->can('update', $product)) {
    throw new AuthorizationException(...);
}
```

**vs. Gate simples:**

```php
// ❌ Não: global, sem contexto
if (!$user->can('create-variant')) { ... }
```

---

## Exemplos de Teste (AAA Pattern)

### Teste de Sucesso

```php
#[Test]
public function it_creates_a_product_variant_with_valid_data(): void
{
    // ARRANGE: prepara dados
    $user = User::factory()->create();
    $product = Product::factory()->for($user, 'owner')->create();
    $request = new CreateProductVariantRequest(...);

    // ACT: executa ação
    $result = $action($request, $user);

    // ASSERT: valida resultado
    $this->assertInstanceOf(ProductVariantCreated::class, $result);
    $this->assertDatabaseHas('product_variants', [...]);
}
```

### Teste de Falha (Autorização)

```php
#[Test]
public function it_throws_if_user_not_authorized(): void
{
    // ARRANGE
    $unauthorized = User::factory()->create();
    $product = Product::factory()->for($owner, 'owner')->create();

    // ACT & ASSERT
    $this->expectException(AuthorizationException::class);
    $action($request, $unauthorized);
}
```

### Teste de Falha (SKU Duplicado)

```php
#[Test]
public function it_throws_if_sku_already_exists(): void
{
    // ... existente com SKU 'EXISTING' ...

    // ACT & ASSERT
    $this->expectException(\InvalidArgumentException::class);
    $action($request, $user);
}
```

---

## Validação com Type Checkers

Este código é **compatível com Psalm/PHPStan level 9**:

```bash
# Validar com Psalm
psalm library/examples/laravel/PerfectAction.php

# Validar com PHPStan
phpstan analyse library/examples/laravel/PerfectAction.php --level 9
```

**Sem erros esperados** porque:

- Todos os tipos públicos são explícitos
- Nenhuma variável é reatribuída para múltiplos tipos
- Early returns evitam narrowing complexo
- DTOs imutáveis garantem tipo estável

---

## Checklist de Auditoria

Ao revisar uma Action em seu projeto, use esta checklist:

- [ ] Usa `declare(strict_types=1)` no topo
- [ ] Todos os parâmetros públicos têm tipos explícitos
- [ ] Todos os returns públicos têm tipos explícitos
- [ ] Implementa `__invoke()` ou método nomeado explicitamente
- [ ] Primeira coisa é autorização (via Policy, não gate)
- [ ] Guard clauses antes de lógica principal (early returns)
- [ ] Usa DTOs para entrada (readonly properties)
- [ ] Usa DTOs para saída (dados apenas necessários)
- [ ] Multi-step operations usam transações
- [ ] Exceções são específicas (não genéricas)
- [ ] Comentários `// AI-REFERENCE:` explicam por quê
- [ ] Testável com padrão AAA (sem mocks de framework)
- [ ] Passou em `php -l` (sem erros de sintaxe)
- [ ] Passou em Psalm level 8+ ou PHPStan level 9

---

## Integração em Seu Projeto

### 1. **Copiar estrutura**

```
app/
  Actions/
    Products/
      CreateProductVariantAction.php (este arquivo)
  Data/
    CreateProductVariantRequest.php (extrair para melhor organização)
    ProductVariantCreated.php
  Http/
    Requests/
      CreateProductVariantFormRequest.php (já com validação HTTP)
  Policies/
    ProductPolicy.php (deve implementar 'update')
```

### 2. **No Controller**

```php
class ProductVariantController
{
    public function store(
        CreateProductVariantFormRequest $request,
        CreateProductVariantAction $action,
    ): JsonResponse {
        $request->authorize(); // FormRequest authorization se tiver

        $result = $action(
            CreateProductVariantRequest::fromValidated($request->validated()),
            auth()->user(),
        );

        return response()->json($result->toArray(), 201);
    }
}
```

### 3. **No Teste**

```php
class CreateProductVariantActionTest extends TestCase
{
    use DatabaseTransactions;

    #[Test]
    public function it_creates_variant(): void { ... }
}
```

---

## Anti-Patterns a Evitar

### ❌ Retornar Model em vez de DTO

```php
// Ruim: caller pode acessar qualquer propriedade
return $variant;
```

**Bom:**

```php
// Bom: caller recebe apenas o necessário
return new ProductVariantCreated(
    id: $variant->id,
    sku: $variant->sku,
    // ...
);
```

### ❌ Usar Gate em vez de Policy

```php
// Ruim: sem contexto de modelo
if (!$user->can('create-variant')) { ... }
```

**Bom:**

```php
// Bom: vínculo explícito ao modelo
if (!$user->can('update', $product)) { ... }
```

### ❌ Validar depois de estado mutável

```php
// Ruim: variant criada antes de validação
$variant = new ProductVariant([...]);
$variant->save();
if (invalid) throw; // Já foi salvo!
```

**Bom:**

```php
// Bom: validação antes de qualquer IO
if ($existingVariant) throw;
$variant->save(); // Só após validação
```

### ❌ Reatribuir variáveis para múltiplos conceitos

```php
// Ruim
$data = $request->all();
$data = validate($data); // $data muda de tipo/significado
return $data;
```

**Bom:**

```php
$input = $request->all();
$validated = validate($input);
return new DTO($validated);
```

---

## Referências

- [Laravel Service Classes vs Actions](https://laravel.com/docs/actions)
- [Data Transfer Objects (DTOs)](https://en.wikipedia.org/wiki/Data_transfer_object)
- [Guard Clauses](https://refactoring.com/catalog/replaceNestedConditionalWithGuardClauses.html)
- [Early Returns](https://martinfowler.com/articles/replaceExceptionWithTest.html)
- [Laravel Policies](https://laravel.com/docs/authorization#creating-policies)
- [Immutability in PHP](https://www.php.net/manual/en/language.oop5.properties.php#language.oop5.properties.readonly)

---

## Sumário

**PerfectAction.php** é um modelo executável que demonstra como escrever uma Action em Laravel com:

✅ Segurança de tipo absoluta  
✅ Autorização clara e escalável  
✅ Validação em múltiplas camadas  
✅ Imutabilidade de dados  
✅ Responsabilidade única  
✅ Testabilidade sem friction  
✅ Documentação integrada (comentários AI-REFERENCE)

Use como referência em auditorias de código, treinamento de times e definição de padrões.
