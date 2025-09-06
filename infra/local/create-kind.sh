#!/usr/bin/env bash
# Exit on first error (-e), treat unset vars as errors (-u), and fail on pipe errors
set -euo pipefail

echo "[krescue] creating kind clusters: primary, dr"

# Create the PRIMARY cluster with 1 control-plane + 1 worker
kind create cluster --name primary --config - <<'EOF'
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
EOF

# Create the DR cluster with the same layout
kind create cluster --name dr --config - <<'EOF'
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
EOF

# Install Ingress-NGINX in each cluster and wait until it's ready
for CL in primary dr; do
  echo "[krescue] installing ingress-nginx on $CL"
  kubectl config use-context kind-$CL
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.10.0/deploy/static/provider/kind/deploy.yaml
  kubectl -n ingress-nginx rollout status deployment/ingress-nginx-controller --timeout=180s
done

echo "[krescue] contexts ready: kind-primary, kind-dr"
