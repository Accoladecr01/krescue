[![ci](https://github.com/haneenmas/krescue/actions/workflows/ci.yml/badge.svg)](https://github.com/haneenmas/krescue/actions/workflows/ci.yml)

# kRescue — Disaster-Recovery Orchestrator (MVP)

A tiny **.NET 8** web service that simulates a **disaster-recovery (DR) drill**:
- `GET /status` – health check
- `POST /backup` – returns a backup plan (dry-run)
- `POST /restore` – returns a restore plan (dry-run)
- `GET /demo` – simple web page with buttons to trigger backup/restore

This is a **minimal, interview-friendly** project that runs in one command, returns JSON, and has CI on GitHub Actions.

## Quickstart

```bash
# from repo root
dotnet restore orchestrator/Orchestrator/Orchestrator.csproj
dotnet run --project orchestrator/Orchestrator/Orchestrator.csproj
# App listens on http://localhost:8090
