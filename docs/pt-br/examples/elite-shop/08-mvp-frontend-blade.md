# MVP Prompt 04 — Frontend com Blade + Tailwind + Alpine

## Objetivo

Criar frontend web em estilo Light Luxury, sem React/Vue, com páginas públicas, carrinho, checkout e autenticação.

## Prompt

```text
Projeto: Elite-Shop (Laravel 13.8). Frontend com Blade, TailwindCSS 3 e Alpine.js. Não usar React/Vue.

Design: estilo "Light Luxury" — fundo branco/creme, tipografia serif para títulos (Inter + Playfair Display via Google Fonts), accent color gold (#C9A84C), cards com sombra suave, espaçamento generoso. Anti-template: hierarquia visual clara, hover states projetados, sem grids uniformes genéricos.

TAREFA: Gere as views Blade e layout base:

**1. Layout** (`resources/views/layouts/app.blade.php`)
**2. Páginas públicas** (`home`, `shop`, `product`)
**3. Carrinho e Checkout** (`cart`, `checkout`, `order-success`)
**4. Autenticação** (`login`, `register`)
**5. Alpine.js** (`resources/js/cart.js` com store `cart`)
**6. Controllers Web** e `routes/web.php`
**7. Tailwind config** com cores e fontes de marca

Siga o coding style: Blade components para elementos repetidos, Alpine.js apenas para interatividade client-side, sem lógica de negócio nas views.
```

## Critérios de aceite

- Layout semântico com `<header>`, `<main>`, `<footer>`.
- Componentização Blade para blocos repetidos.
- Carrinho persistido em `localStorage`.
- Build frontend concluindo com sucesso.
