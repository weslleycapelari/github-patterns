# MVP Prompt 04 — Frontend with Blade + Tailwind + Alpine

## Goal

Build a Light Luxury web frontend, without React/Vue, with public pages, cart, checkout, and authentication.

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

## Acceptance criteria

- Semantic layout with `<header>`, `<main>`, `<footer>`.
- Blade componentization for repeated blocks.
- Cart persisted in `localStorage`.
- Frontend build succeeds.
