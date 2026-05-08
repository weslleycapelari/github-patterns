# Performance And Scalability

## Objective

Prevent AI from generating code that is slow, expensive, or structurally incapable of scaling.

This standard defines how to operate in Performance First mode:

- identify bottlenecks before writing code;
- avoid N+1 queries and unnecessary round-trips;
- choose caching with criteria and invalidate with discipline;
- design queries, data loading, and indexing with predictable cost.

## Non-Negotiable Principles

1. Every solution must consider CPU, memory, network, disk, and database cost before being accepted.
2. Every recurring read must be analyzed for batching, caching, or pre-computation.
3. Every critical query must be treated as suspect until its access plan is understood.
4. Every abstraction that hides I/O cost must be treated with distrust.
5. Performance without measurement is hypothesis; optimization without a bottleneck is noise.
6. AI must design to avoid predictable bottlenecks before they become incidents.

## Performance First Workflow

Before writing code, AI must explicitly answer:

1. What is the expected data volume?
2. What is the cardinality of the relationship involved?
3. How many network or database round-trips will this flow require?
4. Is there a risk of repeated queries per item?
5. Is this data hot, cold, mutable, or derived?
6. Is there a natural key for caching, pagination, or indexing?

If these answers do not exist, the implementation must follow the most predictable and observable option, never the most convenient.

## Detect Bottlenecks Early

Predictable bottlenecks must be identified at design time, not only after implementation.

### Always: Detect Early

- Always estimate the time complexity and number of external calls on the main path.
- Always distrust loops that query a database, network, filesystem, or remote cache.
- Always map endpoints and jobs by volume, concurrency, and frequency.
- Always ask whether the query grows linearly with the number of records, relations, or pages.
- Always verify whether the ORM or framework is hiding implicit lazy loads.

### Never: Detect Early

- Never assume small initial volumes represent the future of the system.
- Never treat a relational database as a cost-free access structure.
- Never use "we'll optimize later" to justify N+1, avoidable full scans, or excessive payloads.
- Never introduce cache before understanding the origin of the cost.

## N+1 Query Prevention

N+1 occurs when an initial query is followed by a new query for each returned item. It is one of the most predictable and least acceptable bottlenecks.

### Always: N+1 Prevention

- Always analyze one-to-many and many-to-one relationships as risk areas.
- Always prefer eager loading, controlled joins, or batching when related data is needed in the same flow.
- Always consolidate reads into set-based queries when possible.
- Always measure the number of queries in critical endpoints and listing use cases.

### Never: N+1 Prevention

- Never iterate over a collection and fetch a dependency item by item from the database.
- Never rely on ORM default behavior to resolve efficient loading.
- Never serialize a response with implicit lazy access during rendering.

### Bad vs Good: N+1

```ts
// Bad
async function listOrdersWithCustomers(orderRepository: OrderRepository) {
  const orders = await orderRepository.findRecent();

  return Promise.all(
    orders.map(async (order) => ({
      ...order,
      customer: await orderRepository.findCustomerById(order.customerId),
    })),
  );
}
```

```ts
// Good
async function listOrdersWithCustomers(orderRepository: OrderRepository) {
  const orders = await orderRepository.findRecentWithCustomers();

  return orders;
}
```

## Caching Strategy

Cache exists to reduce repeated cost. Without a key, expiration, and invalidation strategy, cache is a source of inconsistency.

### Cache Selection Rules

- Memoization: use for pure, local, short-lived computation within the process.
- In-memory cache: use for frequent reads with low cardinality and low cross-instance sharing requirements.
- Redis or distributed cache: use for hot data shared across multiple instances.
- CDN or edge cache: use for public, static, or highly distributed content.

### Always: Caching

- Always define key, TTL, invalidation criteria, and cache owner before implementing it.
- Always cache expensive, repeated, and sufficiently stable reads.
- Always measure hit rate, miss rate, and recomputation cost.
- Always treat cache as optional acceleration, never as the sole source of truth.

### Never: Caching

- Never cache without an invalidation policy.
- Never cache highly mutable data without a clear consistency strategy.
- Never use cache to mask a poor query that should be fixed at the source.
- Never serialize giant payloads into Redis without real necessity.

### Bad vs Good: Caching

```ts
// Bad
async function getProductCatalog() {
  return redis.get('catalog');
}
```

```ts
// Good
async function getProductCatalog(cache: Cache, repository: CatalogRepository) {
  const cacheKey = 'catalog:v1';
  const cachedCatalog = await cache.get<CatalogDto>(cacheKey);

  if (cachedCatalog) {
    return cachedCatalog;
  }

  const catalog = await repository.findPublishedCatalog();
  await cache.set(cacheKey, catalog, { ttlSeconds: 300 });

  return catalog;
}
```

## Lazy Loading Vs Eager Loading

Lazy loading reduces immediate cost but can explode into invisible round-trips. Eager loading reduces round-trips but can inflate payload and memory. The decision must be explicit.

### Always: Loading Strategy

- Always use eager loading when related data is needed for the current response.
- Always use lazy loading only when the access probability is low and controlled.
- Always limit the depth of loaded graphs.
- Always measure payload, cardinality, and number of queries for the chosen strategy.

### Never: Loading Strategy

- Never use blind eager loading of large relations just for convenience.
- Never accept implicit lazy loading during serialization of large lists.
- Never load a full tree when the screen or endpoint only uses a summary.

## Database Indexing

An index is not decoration. It is an access structure. The right index reduces latency; excess indexing increases write cost and maintenance.

### Always: Indexing

- Always suggest an index for columns used recurrently in where, join, order by, and pagination filters.
- Always consider composite indexes when filters appear together in a stable pattern.
- Always align index order with the real query pattern.
- Always review the impact on writes, storage, and maintenance.

### Never: Indexing

- Never suggest an index with no relation to an observable recurring query.
- Never index all columns indiscriminately "for safety".
- Never ignore the update and insert cost in tables with many indexes.
- Never assume a simple index resolves a query that depends on a combination of filters.

### Bad vs Good: Indexing

```sql
-- Bad
SELECT *
FROM orders
WHERE status = 'PAID'
  AND created_at >= '2026-01-01'
ORDER BY created_at DESC;

-- no index strategy discussed
```

```sql
-- Good
-- Query pattern identified: frequent filtering by status and created_at,
-- with descending pagination by created_at.

CREATE INDEX idx_orders_status_created_at_desc
ON orders (status, created_at DESC);
```

## Query Design Rules

### Always: Query Design

- Always select only the necessary columns.
- Always paginate potentially large listings.
- Always push filtering and aggregation to the database when it reduces data transfer.
- Always prefer batching over repeated per-item calls.

### Never: Query Design

- Never use select all in listing endpoints without real need.
- Never load an entire collection to filter in memory what the database can filter better.
- Never paginate in memory after loading a full dataset.

## Performance Review Checklist

Before approving a solution, validate:

1. Is there N+1 risk when reading lists or relations?
2. Is the number of queries and round-trips explicit?
3. Is there a real need for eager loading or batching?
4. Does the cache have a key, TTL, invalidation policy, and effectiveness metric?
5. Do critical queries have an index strategy consistent with the real filters?
6. Does the payload contain only the necessary data?
7. Is pagination designed before volume grows?
8. Does the solution avoid predictable bottlenecks before implementation?

## Enforcement

If an implementation queries inside a loop, it is wrong until proven otherwise.

If a cache has no invalidation policy, it is technical debt with an active clock.

If a critical query has no explicit access strategy, the solution is not yet ready.
