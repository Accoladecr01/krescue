#!/usr/bin/env bash
set -euo pipefail
NS="krescue-dr"
MINIO_SVC="http://minio.${NS}.svc.cluster.local:9000"
BUCKET="krescue"

echo "[velero] installing to DR (context kind-dr)"
kubectl config use-context kind-dr
kubectl create namespace velero --dry-run=client -o yaml | kubectl apply -f -

kubectl -n velero delete secret velero-credentials --ignore-not-found
kubectl -n velero create secret generic velero-credentials \
  --from-literal cloud="[default]
aws_access_key_id = krescueadmin
aws_secret_access_key = krescuepass
"

mkdir -p infra/velero/.render
sed "s#{{BUCKET}}#${BUCKET}#; s#{{S3_URL}}#${MINIO_SVC}#" infra/velero/values.tmpl.yaml > infra/velero/.render/values-dr.yaml

helm repo add vmware-tanzu https://vmware-tanzu.github.io/helm-charts
helm repo update
helm upgrade --install velero vmware-tanzu/velero \
  -n velero \
  -f infra/velero/.render/values-dr.yaml \
  --set image.repository=velero/velero \
  --set initContainers[0].image=velero/velero-plugin-for-aws:v1.9.0

echo "[velero] dr ready. Try: kubectl -n velero get pods"
