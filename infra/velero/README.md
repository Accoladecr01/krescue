# Velero + MinIO (local dev)

## Install order (on your machine, after clusters exist)
1) Create namespaces
```bash
kubectl --context kind-primary create namespace krescue-primary
kubectl --context kind-dr create namespace krescue-dr
helm install minio infra/helm/minio -n krescue-primary
helm install minio infra/helm/minio -n krescue-dr
# Wait for pods ready, then verify:
kubectl --context kind-primary -n krescue-primary get pods
kubectl --context kind-dr -n krescue-dr get pods
bash infra/velero/install-primary.sh
bash infra/velero/install-dr.sh
kubectl --context kind-primary -n velero get pods
kubectl --context kind-primary -n velero get backups
kubectl --context kind-dr -n velero get pods
