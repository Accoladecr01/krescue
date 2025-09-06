# kRescue — Kubernetes DR & Resilience Orchestrator
Disaster-recovery drills for Kubernetes: a .NET 8 orchestrator triggers Velero backups, restores to a DR cluster, and flips traffic—validated by Node.js/TS + Robot/PyTest tests in CI. Tech: .NET 8, Node.js/TypeScript, K8s, Helm, Velero, Postgres, MinIO/S3, Playwright/Robot/PyTest.
# krescue
## Local quickstart (after you have Docker + kind)
```bash
# create clusters
make up
# namespaces
kubectl create namespace krescue-primary
kubectl create namespace krescue-dr

# install Postgres + app to primary
helm install pg infra/helm/postgres -n krescue-primary -f infra/helm/postgres/values-primary.yaml
helm install app infra/helm/sample-app -n krescue-primary -f infra/helm/sample-app/values-primary.yaml
