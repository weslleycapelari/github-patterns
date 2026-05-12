# Eval Case LE-01 — Bad Input / Anti-Pattern Detection

## Metadata

- **agent**: `laravel-expert`
- **case_id**: `LE-01`
- **status**: `draft`
- **scenario_type**: `bad_input`
- **contract_version**: `1.0.0`

## Scenario

The input contains Laravel anti-patterns in a single controller action:

- business logic in controller
- missing FormRequest validation
- mass assignment risk
- missing transaction boundary for writes
- query strategy likely to produce N+1 behavior

## Input (prompt payload)

```text
Analyze the following Laravel code and return findings with remediation:

public function store(Request $request) {
  $order = Order::create($request->all());
  foreach ($request->items as $item) {
    OrderItem::create(['order_id' => $order->id, 'sku' => $item['sku']]);
  }
  if ($order->total > 1000) {
    $order->discount = 0.2;
    $order->save();
  }
  return response()->json($order->load('items.product'));
}
```

## Required Output Contract

1. Scope summary and assumptions.
2. Findings table (ID, severity, evidence, violated principle, action).
3. Prioritized remediation checklist.
4. Subagent handoff plan.
5. Delegation trace.

## PASS Criteria (all required)

1. Detects all mandatory findings:
   - missing validation boundary (`FormRequest` or equivalent)
   - mass assignment risk (`$request->all()`)
   - business logic in controller
   - missing transaction boundary (`DB::transaction` or equivalent)
   - query strategy/performance concern (N+1 risk or unbounded relationship loading)
2. Uses Laravel contract-compatible severities (`SECURITY BREACH`, `CRITICAL`, `WARNING`, `INFO`).
3. Includes code-level evidence for each mandatory finding.
4. Provides at least 3 Laravel-native remediation steps.
5. Intake compliance:
   - either asks intake questions first,
   - or explicitly states assumptions because this is an eval fixture.
6. For CRUD scope, includes delegation trace to `@eloquent-optimizer` and `@laravel-security` (or explicit blocker if unavailable).

## FAIL Conditions

- Misses any mandatory finding.
- Uses non-contract severity taxonomy as final severity model.
- No evidence tied to code fragments.
- No Laravel-native remediation path.
- No intake handling statement.
- No CRUD delegation trace (or blocker rationale).

## Evidence Checklist (runner)

- `raw_output_attached`: yes/no
- `timestamp_utc`: ISO 8601
- `runner`: human/agent id
- `gate_result`: PASS/FAIL

## Gate Decision

Binary gate:

- `PASS` only if all PASS criteria are satisfied.
- Otherwise `FAIL`.
