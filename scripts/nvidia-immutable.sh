#!/bin/bash
# scripts/nvidia.sh — NVIDIA sürücü + container toolkit kurulumu

set -euo pipefail

log()  { echo -e "\e[38;2;255;200;100m[nvidia]\e[0m $*"; }
warn() { echo -e "\e[38;2;255;100;100m[nvidia]\e[0m $*"; }

NVIDIA_CONTAINER_TOOLKIT_VERSION="1.19.0-1"

NVIDIA_PACKAGES=(
    akmod-nvidia-open
    xorg-x11-drv-nvidia-cuda
    vulkan
    xorg-x11-drv-nvidia-cuda-libs
    libva-nvidia-driver
    libva-utils
    vdpauinfo
    cuda-toolkit-13-2
)

detect_nvidia() {
    if ! command -v lspci &>/dev/null; then
        warn "lspci bulunamadı, NVIDIA tespiti atlanıyor."
        return 1
    fi
    lspci | grep -qi nvidia
}

install_container_toolkit() {

    log "Container Toolkit kuruluyor ..."
    sudo rpm-ostree install nvidia-container-toolkit nvidia-container-toolkit-selinux
}

install_drivers() {
    log "NVIDIA sürücüleri kuruluyor..."
    sudo rpm-ostree install "${NVIDIA_PACKAGES[@]}"
}

# ─── Main ──────────────────────────────────────────────────────────────────────
if detect_nvidia; then
    log "NVIDIA GPU tespit edildi."
    install_container_toolkit
    install_drivers
    log "NVIDIA kurulum tamamlandı. Modüller oluşmak için yeniden başlatma gerekebilir."
else
    log "NVIDIA GPU bulunamadı, atlanıyor."
fi
