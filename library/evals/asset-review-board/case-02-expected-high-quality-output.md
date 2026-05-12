# Eval Case ARB-02 — Expected High-Quality Output / Multi-Lens Review

## Metadata

- **agent**: `asset-review-board`
- **case_id**: `ARB-02`
- **status**: `draft`
- **scenario_type**: `expected_high_quality_output`
- **contract_version**: `1.1.0`

## Scenario

The requester asks for a multi-lens review of an artifact with findings by severity, evidence, and a clear recommendation.

## Input (prompt payload)

```text
Review the artifact below in multi-lens mode (correctness, governance, risk, and clarity). Classify findings by severity, cite evidence, and close with an objective recommendation.

Target artifact: a draft governance policy for asset review.
```

## Required Output Contract

1. Executive summary of the review.
2. Findings separated by severity.
3. Text evidence for each finding.
4. Clear final recommendation.
5. Residual risks and next steps.

## PASS Criteria (all required)

1. Uses at least 3 explicit lenses: `correctness`, `governance`, `risk`.
2. Presents findings with named severities.
3. Includes at least 2 concrete evidence snippets from the artifact.
4. Provides a final recommendation: `approve`, `revise`, or `reject`.
5. States explicitly when no findings exist.
6. Does not overclaim approval without basis.

## FAIL Conditions

- Missing severity labels.
- No textual evidence.
- No final recommendation.
- Ignores the multi-lens format.
- Approves without justification.

## Gate Decision

- `PASS` only if all PASS criteria are met.
- Otherwise `FAIL`.
