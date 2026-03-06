#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v podman >/dev/null 2>&1; then
  echo "podman not found; please install podman to run container tests." >&2
  exit 1
fi

IMAGES=(42 43 44 45)

for ver in "${IMAGES[@]}"; do
  echo "==> Testing in Fedora ${ver} container..."
  podman run --rm -v "${ROOT_DIR}:/repo:Z" -w /repo "quay.io/fedora/fedora:${ver}" bash -lc "dnf -y install bash coreutils findutils git shellcheck >/dev/null && bash tests/fedora-image-test.sh"
done

echo "All Fedora image tests completed successfully."


