## Summary
<!-- What changed and why? Link issue if exists. -->

## How to test
<!-- Exact commands / steps reviewers can run. -->
- `pnpm i`
- `pnpm test`
- (optional) `pnpm --filter @krescue/api start` then GET http://localhost:8080/status

## Checklist
- [ ] Unit tests added/updated (Vitest/Playwright/Robot/PyTest as relevant)
- [ ] Lint passes: `pnpm lint`
- [ ] Docs/README updated if behavior changed
- [ ] No secrets or credentials committed
