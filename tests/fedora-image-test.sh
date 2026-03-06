#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

SCRIPTS_DIR="$ROOT_DIR/script"

echo "==> Running bash syntax checks"
for f in "$SCRIPTS_DIR"/*.sh; do
  [ -f "$f" ] || continue
  echo " - bash -n $(basename "$f")"
  bash -n "$f"
done

echo "==> Running shellcheck"
shellcheck -S error -s bash -x "$SCRIPTS_DIR"/*.sh

echo "==> OK"

