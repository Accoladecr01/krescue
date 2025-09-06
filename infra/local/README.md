# Local clusters (kind)

## Prerequisites (run on your machine, not in Codespaces)
- Docker
- kubectl
- kind

## Create clusters
```bash
chmod +x infra/local/create-kind.sh
./infra/local/create-kind.sh
# contexts will be: kind-primary, kind-dr
kubectl config get-contexts
