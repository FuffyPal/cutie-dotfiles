#!/usr/bin/env bash
# scripts/flatpak.sh — Flatpak uygulamaları kur

set -euo pipefail

log() { echo -e "\e[38;2;255;171;185m[flatpak]\e[0m $*"; }

FLATPAKS=(
    dev.vencord.Vesktop
    com.usebottles.bottles
    io.github.dvlv.boxbuddyrs
    io.podman_desktop.PodmanDesktop
    com.github.rafostar.Clapper
    org.localsend.localsend_app
    io.gitlab.theevilskeleton.Upscaler
    com.github.tchx84.Flatseal
    com.mattjakeman.ExtensionManager
    org.mozilla.Thunderbird
    com.github.wwmm.easyeffects
    org.torproject.torbrowser-launcher
    dev.dergs.Tonearm
    org.libreoffice.LibreOffice
    app.zen_browser.zen
    org.gnome.Loupe
    io.ente.auth
    md.obsidian.Obsidian
    im.fluffychat.Fluffychat
    org.gnome.seahorse.Application
)

log "Flathub remote ekleniyor..."
flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo

log "Flatpak uygulamaları kuruluyor (${#FLATPAKS[@]} adet)..."
flatpak install -y --user flathub "${FLATPAKS[@]}"

log "Flatpak kurulum tamamlandı."
