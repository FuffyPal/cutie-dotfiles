#!/bin/bash

set -euo pipefail

# ─── Renkli log fonksiyonları ──────────────────────────────────────────────────
info()    { echo -e "\e[38;2;180;200;255m[INFO]\e[0m    $*"; }
success() { echo -e "\e[38;2;150;255;150m[OK]\e[0m      $*"; }
warn()    { echo -e "\e[38;2;255;200;100m[WARN]\e[0m    $*"; }
error()   { echo -e "\e[38;2;255;100;100m[ERROR]\e[0m   $*" >&2; }
step()    { echo -e "\n\e[38;2;255;171;185m━━━ $* ━━━\e[0m\n"; }

# ─── DNF paketleri ─────────────────────────────────────────────────────────
install_packages() {
    step "DNF paketleri kuruluyor"

    PACKAGES=(
        # Temel araçlar
        git git-lfs vim
        # Sistem
        podman podman-docker podman-compose
        firewalld
        # Yardımcılar
        lolcat btop
    )

    sudo dnf install -y "${PACKAGES[@]}"

    success "DNF paketleri kuruldu."
}

# ─── Dotfiles symlink'leri ─────────────────────────────────────────────────
create_symlinks() {
    step "Dotfiles symlink'leri oluşturuluyor"

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
        success "Bağlandı: $dst → $src"
    done
}

# ─── Ana akış ─────────────────────────────────────────────────────────────────
main() {
    echo -e "\e[38;2;255;171;185m"
    echo "  ╔═══════════════════════════════════════════╗"
    echo "  ║   Fedora Server Dotfiles Kurulum Scripti  ║"
    echo "  ╚═══════════════════════════════════════════╝"
    echo -e "\e[0m"

    create_symlinks
    install_packages

    echo -e "\n\e[38;2;150;255;150m✔ Kurulum tamamlandı!\e[0m"
    echo -e "  Önerilir: sistemi yeniden başlatın → \e[1msudo reboot\e[0m"
}

main "$@"