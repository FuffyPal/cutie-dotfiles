#!/bin/bash

if [ "$EUID" -ne 0 ]; then 
  echo "Please run this script with sudo (root privileges)."
  exit
fi

REGISTRY_CONF="/etc/containers/registries.conf"
BACKUP_CONF="/etc/containers/registries.conf.bak"

echo "🔄 Backing up current configuration to: $BACKUP_CONF"
cp $REGISTRY_CONF $BACKUP_CONF

echo "📝 Writing new registry configuration..."

# Dosyanın içeriğini tamamen güncelliyoruz
cat <<EOF > $REGISTRY_CONF
# Podman registry configuration (auto-generated)
unqualified-search-registries = ["docker.io", "quay.io", "ghcr.io", "gcr.io"]

[[registry]]
location = "docker.io"

[[registry]]
location = "quay.io"

[[registry]]
location = "ghcr.io"

[[registry]]
location = "gcr.io"
EOF

echo "✅ Done! You can now use the podman search command with the updated registries."