#!/usr/bin/env bash
set -euo pipefail
IMAGE=${1:-'my-app:latest'}
echo "Scanning $IMAGE with Trivy..."
trivy image --exit-code 1 --severity HIGH,CRITICAL "$IMAGE"
