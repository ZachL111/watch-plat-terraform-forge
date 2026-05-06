# Watch Plat Terraform Forge Walkthrough

The fixture is intentionally compact, so the review starts with the cases that pull farthest apart.

| Case | Focus | Score | Lane |
| --- | --- | ---: | --- |
| baseline | rollout width | 171 | ship |
| stress | quota pressure | 168 | ship |
| edge | route drift | 153 | ship |
| recovery | secret scope | 165 | ship |
| stale | rollout width | 159 | ship |

Start with `baseline` and `edge`. They create the widest contrast in this repository's fixture set, which makes them better review anchors than the middle cases.

`baseline` is the optimistic case; use it to make sure the scoring path still rewards strong signal.
