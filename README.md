# watch-plat-terraform-forge

`watch-plat-terraform-forge` explores platform engineering with a small Java codebase and local fixtures. The technical goal is to package a Java local lab for terraform analysis with round-trip fixtures, lossless normalization checks, and documented operating limits.

## Purpose

The point is to make a small domain rule concrete enough that a reader can change it and immediately see what broke.

## Watch Plat Terraform Forge Review Notes

The first comparison I would make is `rollout width` against `route drift` because it shows where the rule is most opinionated.

## What Is Covered

- `fixtures/domain_review.csv` adds cases for rollout width and quota pressure.
- `metadata/domain-review.json` records the same cases in structured form.
- `config/review-profile.json` captures the read order and the two review questions.
- `examples/watch-plat-terraform-walkthrough.md` walks through the case spread.
- The Java code includes a review path for `rollout width` and `route drift`.
- `docs/field-notes.md` explains the strongest and weakest cases.

## Implementation Notes

The core code exposes a scoring path and the added review layer uses `signal`, `slack`, `drag`, and `confidence`. The domain terms are `rollout width`, `quota pressure`, `route drift`, and `secret scope`.

The Java addition stays small enough to inspect in one sitting.

## Command

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/verify.ps1
```

## Audit Path

That command is also the regression path. It verifies the domain cases and catches mismatches between the CSV, metadata, and code.

## Limits

This remains a local project with deterministic fixtures. It does not depend on credentials, hosted services, or live data. Future work should add richer malformed inputs before widening the public API.
