#!/bin/bash
# install.sh — Fedora dotfiles ana kurulum scripti
#
# Kullanım:
#   ./install.sh             # tam kurulum
#   ./install.sh --symlinks  # sadece symlink'leri güncelle
#   ./install.sh --no-nvidia # NVIDIA kurulumunu atla

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ─── Renkli log fonksiyonları ──────────────────────────────────────────────────
info()    { echo -e "\e[38;2;180;200;255m[INFO]\e[0m    $*"; }
success() { echo -e "\e[38;2;150;255;150m[OK]\e[0m      $*"; }
warn()    { echo -e "\e[38;2;255;200;100m[WARN]\e[0m    $*"; }
error()   { echo -e "\e[38;2;255;100;100m[ERROR]\e[0m   $*" >&2; }
step()    { echo -e "\n\e[38;2;255;171;185m━━━ $* ━━━\e[0m\n"; }
log() { echo -e "\e[38;2;180;200;255m[debloat]\e[0m $*"; }


# ─── Argümanlar ────────────────────────────────────────────────────────────────
SYMLINKS_ONLY=false
SKIP_NVIDIA=false

for arg in "$@"; do
    case "$arg" in
        --symlinks)  SYMLINKS_ONLY=true ;;
        --no-nvidia) SKIP_NVIDIA=true ;;
        --help|-h)
            echo "Kullanım: ./install.sh [--symlinks] [--no-nvidia]"
            exit 0
            ;;
    esac
done

# ─── 1. Repo'lar ───────────────────────────────────────────────────────────────
setup_repos() {
    step "Repo'lar yapılandırılıyor"

    info "RPM Fusion ekleniyor..."
    sudo rpm-ostree install \
      https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
      https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo rpm-ostree ex apply-live
    success "Repo'lar hazır."
}

# ─── 2. Debloat ────────────────────────────────────────────────────────────────
run_debloat() {
    step "Bloatware kaldırılıyor"

    set -euo pipefail


    RPM_override_PACKAGES=(
        firefox
        firefox-langpacks
        gnome-tour
    )

    FLATPAK_PACKAGES=(
        org.fedoraproject.MediaWriter
        org.gnome.Calculator
        org.gnome.Characters
        org.gnome.Calendar
        org.gnome.Connections
        org.gnome.Contacts
        org.gnome.Extensions
        org.gnome.Maps
        org.gnome.Papers
        org.gnome.Snapshot
        org.gnome.clocks
        org.gnome.font-viewer
    )
    log "Uninstall Bloatware..."
    log "with rpm-ostree override ..."
    sudo rpm-ostree override remove "${RPM_override_PACKAGES[@]}" || true
    flatpak uninstall -y --delete-data "${FLATPAK_PACKAGES[@]}" || true

    success "Debloat tamamlandı."
}

# ─── 3. DNF paketleri ─────────────────────────────────────────────────────────
install_packages() {
    step "DNF paketleri kuruluyor"

    PACKAGES=(
        # Temel araçlar
        git git-lfs vim
        # Sistem
        flatpak podman podman-docker podman-compose
        firewalld firewall-config firewall-applet
        distrobox
        # Masaüstü
        gnome-tweaks papirus-icon-theme
        # Yardımcılar
        lolcat btop wtype fuse fuse-libs
        # Konteyner / sanallaştırma
        freerdp
        # sanal kamera ve obs studip
        kmod-v4l2loopback akmod-v4l2loopback v4l2loopback-utils obs-studio help2man
    )
    sudo rpm-ostree install --allow-inactive "${PACKAGES[@]}"

    success "DNF paketleri kuruldu."
}

# ─── 4. Flatpak ────────────────────────────────────────────────────────────────
install_flatpaks() {
    step "Flatpak uygulamaları kuruluyor"
    bash "$DOTFILES_DIR/scripts/flatpak.sh"
    FLATPAK_PACKS=(
        com.ranfdev.DistroShelf
        dev.zed.Zed
        com.visualstudio.code
        com.google.Chrome
    )
    log "Flatpak uygulamaları kuruluyor (${#FLATPAK_PACKS[@]} adet)..."
    flatpak install -y --user flathub "${FLATPAK_PACKS[@]}"
    success "Flatpak kurulumu tamamlandı."
}

# ─── 5. NVIDIA ─────────────────────────────────────────────────────────────────
maybe_nvidia() {
    step "NVIDIA kontrol ediliyor"
    if "$SKIP_NVIDIA"; then
        warn "NVIDIA kurulumu --no-nvidia ile atlandı."
        return
    fi
    bash "$DOTFILES_DIR/scripts/nvidia.sh"
}

# ─── 6. Secure Boot (akmods) ──────────────────────────────────────────────────
setup_secureboot() {
    step "Secure Boot / akmods yapılandırılıyor"

    if sudo kmodgenca -a; then
        info "akmods sertifikası oluşturuldu."
    else
        warn "İlk deneme başarısız, --force ile tekrar deneniyor..."
        if ! sudo kmodgenca -a --force; then
            error "Sertifika oluşturulamadı. Secure Boot ayarı atlanıyor."
            return 1
        fi
    fi

    local cert="/etc/pki/akmods/certs/public_key.der"
    if [ ! -f "$cert" ]; then
        warn "Sertifika dosyası bulunamadı: $cert"
        return 1
    fi

    info "MOK sertifikası import ediliyor..."
    if sudo mokutil --import "$cert"; then
        success "Secure Boot sertifikası import edildi."
        info "Sistemi yeniden başlatınca MOK Manager çıkacak, sertifikayı oradan onaylayın."
    else
        error "mokutil import başarısız."
        return 1
    fi
}

# ─── 7. Sistem konfigürasyonları ──────────────────────────────────────────────
apply_system_configs() {
    step "Sistem konfigürasyonları uygulanıyor"

    info "dnf.conf kopyalanıyor..."
    sudo cp "$DOTFILES_DIR/system/dnf.conf" /etc/dnf/dnf.conf

    info "systemd-resolved yapılandırılıyor (DoT + DNSSEC)..."
    sudo cp "$DOTFILES_DIR/system/resolved.conf" /etc/systemd/resolved.conf
    sudo systemctl enable --now systemd-resolved
    sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

    info "firewalld etkinleştiriliyor..."
    sudo systemctl enable --now firewalld

    info "Snapper yapılandırılıyor..."
    if command -v snapper &>/dev/null; then
        sudo snapper -c root create-config / || warn "Snapper config zaten var, atlandı."
        sudo cp "$DOTFILES_DIR/system/snapper-root.conf" /etc/snapper/configs/root
        sudo systemctl enable --now snapper-timeline.timer snapper-cleanup.timer
    else
        warn "snapper bulunamadı, atlandı."
    fi

    success "Sistem konfigürasyonları uygulandı."
}

# ─── 8. Dotfiles symlink'leri ─────────────────────────────────────────────────
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
    echo "  ╔═══════════════════════════════════╗"
    echo "  ║   Fedora Dotfiles Kurulum Scripti ║"
    echo "  ╚═══════════════════════════════════╝"
    echo -e "\e[0m"

    if "$SYMLINKS_ONLY"; then
        create_symlinks
        info "Sadece symlink modu — diğer adımlar atlandı."
        exit 0
    fi

    setup_repos
    run_debloat
    install_packages
    install_flatpaks
    # maybe_nvidia
    # setup_secureboot
    # apply_system_configs
    create_symlinks

    echo -e "\n\e[38;2;150;255;150m✔ Kurulum tamamlandı!\e[0m"
    echo -e "  Önerilir: sistemi yeniden başlatın → \e[1msudo reboot\e[0m"
}

main "$@"
