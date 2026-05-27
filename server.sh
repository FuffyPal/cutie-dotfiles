#!/bin/bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


# ─── Renkli log fonksiyonları ──────────────────────────────────────────────────
info()    { echo -e "\e[38;2;180;200;255m[INFO]\e[0m    $*"; }
success() { echo -e "\e[38;2;150;255;150m[OK]\e[0m      $*"; }
warn()    { echo -e "\e[38;2;255;200;100m[WARN]\e[0m    $*"; }
error()   { echo -e "\e[38;2;255;100;100m[ERROR]\e[0m   $*" >&2; }
step()    { echo -e "\n\e[38;2;255;171;185m━━━ $* ━━━\e[0m\n"; }

# ─── DNF paketleri ─────────────────────────────────────────────────────────
install_packages() {
    step "DNF Installing Packages"

    PACKAGES=(
        # Base Tool
        git git-lfs vim
        # System
        podman podman-docker podman-compose
        firewalld
        # Utilis
        lolcat btop
        # Cockpit ENV
        cockpit cockpit-machines cockpit-podman cockpit-storaged cockpit-files cockpit-bridge cockpit-system cockpit-ws cockpit-ws-selinux
    )

    sudo dnf install -y "${PACKAGES[@]}"

    success "DNF Packages installed"
}

# ─── Dotfiles symlink'leri ─────────────────────────────────────────────────
create_symlinks() {
    step "Dotfiles Creating symlinks"

    declare -A LINKS=(
        ["$DOTFILES_DIR/home/.bashrc"]="$HOME/.bashrc"
        ["$DOTFILES_DIR/home/.vimrc"]="$HOME/.vimrc"
        ["$DOTFILES_DIR/home/.gitconfig"]="$HOME/.gitconfig"
    )

    for src in "${!LINKS[@]}"; do
        dst="${LINKS[$src]}"
        if [ -e "$dst" ] && [ ! -L "$dst" ]; then
            warn "$dst mevcut, yedekleniyor → ${dst}.bak"
            mv "$dst" "${dst}.bak"
        fi
        ln -sf "$src" "$dst"
        success "link: $dst → $src"
    done
}

# ─── Compose Kurulum ─────────────────────────────────────────────────

compose_setup() {
    step "pal-clouddyy-stack Setup"

    if ! command -v podman-compose &>/dev/null; then
        error "Podman Compose Not Found."
    else
        if ! command -v git &>/dev/null; then
            error "Git Not Found."
        else
            mkdir -P "$DOTFILES_DIR/server/docker"
            cd "$DOTFILES_DIR/server/docker"
            git pull https://gitlab.com/FluffyPal/pal-clouddyy-stack.git
            podman-compose build
            success "Stack updated."
        fi
    fi
}

# ─── Ana akış ─────────────────────────────────────────────────────────────────
main() {
    echo -e "\e[38;2;255;171;185m"
    echo "  ╔═══════════════════════════════════════════╗"
    echo "  ║   Fedora Server Dotfiles Setup Scripti    ║"
    echo "  ╚═══════════════════════════════════════════╝"
    echo -e "\e[0m"

    create_symlinks
    install_packages
    compose_setup

    echo -e "\n\e[38;2;150;255;150m✔ Setup Finished!\e[0m"
    echo -e "  Önerilir: sistemi yeniden başlatın → \e[1msudo reboot\e[0m"
}

main "$@"
