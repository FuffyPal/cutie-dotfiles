DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# ─── Renkli log fonksiyonları ──────────────────────────────────────────────────
info()    { echo -e "\e[38;2;180;200;255m[INFO]\e[0m    $*"; }
success() { echo -e "\e[38;2;150;255;150m[OK]\e[0m      $*"; }
warn()    { echo -e "\e[38;2;255;200;100m[WARN]\e[0m    $*"; }
error()   { echo -e "\e[38;2;255;100;100m[ERROR]\e[0m   $*" >&2; }
step()    { echo -e "\n\e[38;2;255;171;185m━━━ $* ━━━\e[0m\n"; }


create_symlinks() {
    step "Dotfiles symlink'leri oluşturuluyor"

    declare -A LINKS=(
        ["$DOTFILES_DIR/config/bash/.bashrc"]="$HOME/.bashrc"
        ["$DOTFILES_DIR/config/vim/.vimrc"]="$HOME/.vimrc"
        ["$DOTFILES_DIR/config/git/.gitconfig"]="$HOME/.gitconfig"
        ["$DOTFILES_DIR/config/helix/config.toml"]="$HOME/.config/helix/config.toml"
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

create_symlinks