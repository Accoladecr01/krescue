#!/usr/bin/env bash
set -euo pipefail
NS="krescue-primary"
MINIO_SVC="http://minio.${NS}.svc.cluster.local:9000"
BUCKET="krescue"

echo "[velero] installing to PRIMARY (context kind-primary)"
kubectl config use-context kind-primary

# namespace for velero (chart uses 'velero' by default)
kubectl create namespace velero --dry-run=client -o yaml | kubectl apply -f -

# create credentials secret for velero (AWS format, for MinIO)
kubectl -n velero delete secret velero-credentials --ignore-not-found
kubectl -n velero create secret generic velero-credentials \
  --from-literal cloud="[default]
aws_access_key_id = krescueadmin
aws_secret_access_key = krescuepass
"

# render values
mkdir -p infra/velero/.render
sed "s#{{BUCKET}}#${BUCKET}#; s#{{S3_URL}}#${MINIO_SVC}#" infra/velero/values.tmpl.yaml > infra/velero/.render/values-primary.yaml

# install velero via Helm
helm repo add vmware-tanzu https://vmware-tanzu.github.io/helm-charts
helm repo update
helm upgrade --install velero vmware-tanzu/velero \
  -n velero \
  -f infra/velero/.render/values-primary.yaml \
  --set image.repository=velero/velero \
  --set initContainers[0].image=velero/velero-plugin-for-aws:v1.9.0

echo "[velero] primary ready. Try: kubectl -n velero get pods"
