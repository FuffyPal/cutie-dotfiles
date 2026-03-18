DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_SRC="$DOTFILES_DIR/config/dnf/dnf.conf"
CONFIG_DEST="/etc/dnf/dnf.conf"

if [ -f "$CONFIG_SRC" ]; then
    sudo cp "$CONFIG_SRC" "$CONFIG_DEST"
    sudo dnf clean all
    sudo dnf makecache
else
    exit 1
fi