# Velero + MinIO (local dev)

## Install order (on your machine, after clusters exist)
1) Create namespaces
```bash
kubectl --context kind-primary create namespace krescue-primary
kubectl --context kind-dr create namespace krescue-dr
