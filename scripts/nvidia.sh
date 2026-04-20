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
)

detect_nvidia() {
    if ! command -v lspci &>/dev/null; then
        warn "lspci bulunamadı, NVIDIA tespiti atlanıyor."
        return 1
    fi
    lspci | grep -qi nvidia
}

install_container_toolkit() {
    log "NVIDIA Container Toolkit repo ekleniyor..."
    curl -fsSL https://nvidia.github.io/libnvidia-container/stable/rpm/nvidia-container-toolkit.repo \
        | sudo tee /etc/yum.repos.d/nvidia-container-toolkit.repo > /dev/null

    log "Container Toolkit kuruluyor (v${NVIDIA_CONTAINER_TOOLKIT_VERSION})..."
    sudo dnf install -y \
        "nvidia-container-toolkit-${NVIDIA_CONTAINER_TOOLKIT_VERSION}" \
        "nvidia-container-toolkit-base-${NVIDIA_CONTAINER_TOOLKIT_VERSION}" \
        "libnvidia-container-tools-${NVIDIA_CONTAINER_TOOLKIT_VERSION}" \
        "libnvidia-container1-${NVIDIA_CONTAINER_TOOLKIT_VERSION}"
}

install_drivers() {
    log "NVIDIA sürücüleri kuruluyor..."
    sudo dnf install -y "${NVIDIA_PACKAGES[@]}"
}

configure_podman_nvidia() {
    if command -v nvidia-ctk &>/dev/null; then
        log "Podman için NVIDIA CDI yapılandırılıyor..."
        sudo nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml
        log "CDI oluşturuldu: /etc/cdi/nvidia.yaml"
    fi
}

# ─── Main ──────────────────────────────────────────────────────────────────────
if detect_nvidia; then
    log "NVIDIA GPU tespit edildi."
    install_container_toolkit
    install_drivers
    configure_podman_nvidia
    log "NVIDIA kurulum tamamlandı. Modüller oluşmak için yeniden başlatma gerekebilir."
else
    log "NVIDIA GPU bulunamadı, atlanıyor."
fi
