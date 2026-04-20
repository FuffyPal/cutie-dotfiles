#!/bin/bash

RESOLVED_CONF_PATH_TO="/etc/systemd/resolved.conf.d"
RESOLVED_CONF="$RESOLVED_CONF_PATH_TO/fluffy.conf"

NEW_CONFIG="[Resolve]
DNS=1.1.1.1#cloudflare-dns.com 
FallbackDNS=1.0.0.1#cloudflare-dns.com 
DNSSEC=yes
DNSOverTLS=yes
Cache=yes
CacheFromLocalhost=no
ReadEtcHosts=yes"

sudo mkdir -p "$RESOLVED_CONF_PATH_TO"

echo "$NEW_CONFIG" | sudo tee "$RESOLVED_CONF" > /dev/null

sudo systemctl enable --now systemd-resolved

sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

sudo systemctl restart systemd-resolved