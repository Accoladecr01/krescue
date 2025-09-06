# Contributing to kRescue

## Dev setup
- Node 18+ and pnpm 9
- Install deps: `pnpm i`
- Run tests: `pnpm test`
- Lint: `pnpm lint`
- Start API: `pnpm --filter @krescue/api start` (GET /status)

## Project layout
- `orchestrator/` – .NET 8 API + BackgroundService
- `ts/api` – Node/TS Fastify service
- `ts/operator` – Node/TS K8s controller
- `infra/` – kind/minikube scripts, Helm, CRDs
- `qa/` – Robot/PyTest/Playwright/Locust
- `verify/` – TLA+ + RTL (SVA) samples

## Branch & commits
- Create feature branches: `feat/xyz`, `fix/bug-123`
- Conventional commits: `feat: ...`, `fix: ...`, `docs: ...`, `test: ...`, `chore: ...`

## Pull requests
- Keep PRs small and focused
- Fill the PR template (how to test, checklist)
- Green tests & lint required
