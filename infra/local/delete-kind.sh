#!/usr/bin/env bash
set -euo pipefail
kind delete cluster --name primary || true
kind delete cluster --name dr || true
echo "[krescue] deleted kind clusters (primary, dr)"
