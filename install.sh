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
    sudo dnf install -y \
        "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
        "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

    info "Terra repo ekleniyor..."
    sudo dnf install -y --nogpgcheck \
        --repofrompath "terra,https://repos.fyralabs.com/terra$(rpm -E %fedora)" \
        terra-release

    info "Fedora workstation repoları etkinleştiriliyor..."
    sudo dnf install -y fedora-workstation-repositories
    sudo dnf config-manager setopt google-chrome.enabled=1
    sudo dnf config-manager setopt rpmfusion-nonfree-nvidia-driver.enabled=1

    info "VS Code repo ekleniyor..."
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo tee /etc/yum.repos.d/vscode.repo > /dev/null <<'EOF'
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

    info "Antigravity repo ekleniyor..."
    sudo tee /etc/yum.repos.d/antigravity.repo << EOL
[antigravity-rpm]
name=Antigravity RPM Repository
baseurl=https://us-central1-yum.pkg.dev/projects/antigravity-auto-updater-dev/antigravity-rpm
enabled=1
gpgcheck=0
EOL
    info "ProtonVPN repo ekleniyor..."
    local fedora_ver
    fedora_ver=$(cat /etc/fedora-release | cut -d' ' -f 3)
    local proton_rpm
    proton_rpm=$(mktemp --suffix=.rpm)
    curl -fsSL \
        "https://repo.protonvpn.com/fedora-${fedora_ver}-stable/protonvpn-stable-release/protonvpn-stable-release-1.0.3-1.noarch.rpm" \
        -o "$proton_rpm"
    sudo dnf install -y "$proton_rpm"
    rm -f "$proton_rpm"

    info "Cloudflare WARP repo ekleniyor..."
    sudo rpm --import https://pkg.cloudflareclient.com/pubkey.gpg
    sudo tee /etc/yum.repos.d/cloudflare-warp.repo > /dev/null <<'EOF'
[cloudflare-warp]
name=Cloudflare WARP
baseurl=https://pkg.cloudflareclient.com/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkg.cloudflareclient.com/pubkey.gpg
EOF
    info "Cude Repo ekleniyor..."
    sudo dnf config-manager addrepo --from-repofile https://developer.download.nvidia.com/compute/cuda/repos/fedora$(rpm -E %fedora)/x86_64/cuda-fedora$(rpm -E %fedora).repo
    
    success "Repo'lar hazır."
}

# ─── 2. Debloat ────────────────────────────────────────────────────────────────
run_debloat() {
    step "Bloatware kaldırılıyor"
    bash "$DOTFILES_DIR/scripts/debloat.sh"
    success "Debloat tamamlandı."
}

# ─── 3. DNF paketleri ─────────────────────────────────────────────────────────
install_packages() {
    step "DNF paketleri kuruluyor"

    PACKAGES=(
        # Temel araçlar
        git git-lfs vim google-chrome-stable
        # Sistem
        flatpak podman podman-docker podman-compose
        firewalld firewall-config firewall-applet
        # Masaüstü
        gnome-tweaks papirus-icon-theme ptyxis
        # Geliştirici araçları
        zed helix rust-analyzer cargo
        # Yardımcılar
        lolcat btop wtype fuse fuse-libs
        # Btrfs
        snapper python3-dnf-plugin-snapper btrfs-assistant
        # Konteyner / sanallaştırma
        freerdp
        # Steam / oyun
        steam gtk-layer-shell
        # VPN
        proton-vpn-gnome-desktop
        cloudflare-warp
        # Kubernetes
        kubernetes1.35
    )

    sudo dnf update -y
    sudo dnf install -y "${PACKAGES[@]}"

    info "git-lfs başlatılıyor..."
    git lfs install || warn "git lfs install başarısız, atlandı."

    info "Cloudflare WARP servisi etkinleştiriliyor..."
    sudo systemctl enable --now warp-svc || warn "warp-svc başlatılamadı, atlandı."

    success "DNF paketleri kuruldu."
}

# ─── 4. Flatpak ────────────────────────────────────────────────────────────────
install_flatpaks() {
    step "Flatpak uygulamaları kuruluyor"
    bash "$DOTFILES_DIR/scripts/flatpak.sh"
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
    maybe_nvidia
    setup_secureboot
    apply_system_configs
    create_symlinks

    echo -e "\n\e[38;2;150;255;150m✔ Kurulum tamamlandı!\e[0m"
    echo -e "  Önerilir: sistemi yeniden başlatın → \e[1msudo reboot\e[0m"
}

main "$@"