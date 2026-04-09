#!/bin/bash

if [ "$EUID" -ne 0 ]; then 
  echo "Please run sudo access or root access"
  exit 1
fi


systemctl enable --now firewalld

firewall-cmd --permanent --add-icmp-block-inversion
firewall-cmd --permanent --set-target=ACCEPT

firewall-cmd --permanent --zone=trusted --add-interface=tailscale0

TCP_PORTS=(53317 4955 4950 27031 27036 27037)
for port in "${TCP_PORTS[@]}"; do
    firewall-cmd --permanent --add-port=${port}/tcp
done

UDP_PORTS=(41641 53317 4955 4950 27031 27036 27037)
for port in "${UDP_PORTS[@]}"; do
    firewall-cmd --permanent --add-port=${port}/udp
done

firewall-cmd --permanent --add-port=1714-1764/tcp
firewall-cmd --permanent --add-port=1714-1764/udp

firewall-cmd --reload

