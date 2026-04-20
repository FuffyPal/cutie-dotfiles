#!/bin/bash
# scripts/debloat.sh — GNOME bloatware kaldırma

set -euo pipefail

log() { echo -e "\e[38;2;180;200;255m[debloat]\e[0m $*"; }

PACKAGES=(
    gnome-calendar
    gnome-contacts
    gnome-calculator
    gnome-clocks
    mediawriter
    totem
    sushi
    evince
    simple-scan
    snapshot
    gnome-maps
    gnome-boxes
    gnome-characters
    gnome-connections
    loupe
    gnome-tour
    rhythmbox
    firefox
    showtime
    decibels
    papers
    gnome-terminal
)

log "Bloatware kaldırılıyor..."
sudo dnf remove -y "${PACKAGES[@]}" || true

log "LibreOffice paketi kaldırılıyor..."
sudo dnf remove -y 'libreoffice-*' || true
sudo dnf group remove -y libreoffice || true

log "Orphan paketler temizleniyor..."
sudo dnf autoremove -y

log "Debloat tamamlandı."
