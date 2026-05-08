# MVP Prompt 03 — HTTP API Layer (REST JSON)

## Goal

Generate a complete HTTP layer with Sanctum, requests, resources, controllers, middleware, routes, and feature tests.

## Prompt

```text
Projeto: Elite-Shop (Laravel 13.8). Estilo: API JSON RESTful (sem Blade). Todos os endpoints retornam JSON.

Contexto: ProductService e OrderService já implementados. Models Product, ProductVariant, Order, OrderItem existem. Autenticação será Laravel Sanctum.

TAREFA: Gere a camada HTTP completa:

**1. Instalar Sanctum** (já vem com Laravel 11+, apenas configure):
- Adicionar `HasApiTokens` ao model User
- Publicar config: php artisan vendor:publish --provider="Laravel\Sanctum\SanctumServiceProvider"
- Adicionar middleware `auth:sanctum` nas rotas protegidas

**2. Form Requests** (em app/Http/Requests/):
- `StoreProductRequest`, `UpdateProductRequest`, `StoreProductVariantRequest`, `CreateOrderRequest`, `AdjustStockRequest`, `LoginRequest`, `RegisterRequest`

**3. API Resources** (em app/Http/Resources/):
- `ProductResource`, `ProductVariantResource`, `OrderResource`, `OrderItemResource`, `UserResource`

**4. Controllers** (em app/Http/Controllers/Api/):
- `AuthController`, `ProductController`, `ProductVariantController`, `OrderController`, `AdminOrderController`

**5. Middleware:**
- `app/Http/Middleware/EnsureIsAdmin.php`

**6. Routes** (routes/api.php):
- Auth, produtos, variantes, pedidos e admin orders conforme escopo

**7. Testes Feature** em `tests/Feature/Api/`:
- `AuthTest.php`, `ProductApiTest.php`, `OrderApiTest.php`

Siga: early return nos controllers, responses sempre via Resources, erros via `response()->json(['message'=>$e->getMessage()], código)`.
```

## Acceptance criteria

- Public and protected routes correctly configured.
- Admin access validated with 403 for non-admin.
- API feature tests covering happy-path and auth/stock error paths.
