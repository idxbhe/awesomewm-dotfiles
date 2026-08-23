#!/bin/bash
# =============================================================
# dotfiles installer
# Two methods: symlink (default) or copy
# =============================================================

set -euo pipefail

DOTFILES="$HOME/dotfiles"
BACKUP_DIR="$HOME/backup/dotfiles-$(date +%Y%m%d-%H%M%S)"
METHOD="${1:-symlink}"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

info()  { echo -e "${CYAN}[INFO]${NC} $1"; }
ok()    { echo -e "${GREEN}[OK]${NC} $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
err()   { echo -e "${RED}[ERR]${NC} $1"; }

# Check method
if [[ "$METHOD" != "symlink" && "$METHOD" != "copy" ]]; then
    echo "Usage: $0 [symlink|copy]"
    echo "  symlink (default) - symlink configs, backup existing files"
    echo "  copy              - copy configs, backup existing files"
    exit 1
fi

# Check dotfiles dir
if [[ ! -d "$DOTFILES" ]]; then
    err "Dotfiles dir not found: $DOTFILES"
    exit 1
fi

info "Method: $METHOD"
info "Dotfiles: $DOTFILES"
info "Backup: $BACKUP_DIR"
echo ""

# Create backup dir
mkdir -p "$BACKUP_DIR"

# Backup existing file/dir and create link/copy
install_item() {
    local src="$1"
    local dst="$2"

    if [[ ! -e "$src" ]]; then
        warn "Source not found: $src"
        return
    fi

    # Backup if target exists
    if [[ -e "$dst" || -L "$dst" ]]; then
        local backup_path="$BACKUP_DIR$(basename "$dst")"
        mkdir -p "$(dirname "$backup_path")"
        cp -a "$dst" "$backup_path" 2>/dev/null || true
        rm -rf "$dst"
        info "Backed up: $dst"
    fi

    # Create parent dir
    mkdir -p "$(dirname "$dst")"

    # Install
    if [[ "$METHOD" == "symlink" ]]; then
        ln -s "$src" "$dst"
    else
        cp -a "$src" "$dst"
    fi
    ok "Installed: $dst"
}

# =============================================================
# Install configs
# =============================================================

info "Installing configs..."

# AwesomeWM
install_item "$DOTFILES/config/awesome" "$HOME/.config/awesome"

# Thunar
install_item "$DOTFILES/config/Thunar" "$HOME/.config/Thunar"

# GTK3
install_item "$DOTFILES/config/gtk-3.0/settings.ini" "$HOME/.config/gtk-3.0/settings.ini"

# GTK2
install_item "$DOTFILES/config/gtk-2.0/gtkrc" "$HOME/.gtkrc-2.0"

# =============================================================
# Install themes (to ~/.themes for user, or /usr/share/themes for system)
# =============================================================

info "Installing themes..."

for theme_dir in "$DOTFILES/themes"/*/; do
    theme_name=$(basename "$theme_dir")
    install_item "$theme_dir" "$HOME/.themes/$theme_name"
done

# =============================================================
# Done
# =============================================================

echo ""
ok "Installation complete!"
if [[ -d "$BACKUP_DIR" ]] && [[ "$(ls -A "$BACKUP_DIR" 2>/dev/null)" ]]; then
    info "Backups saved to: $BACKUP_DIR"
fi
echo ""
info "Restart AwesomeWM (Mod+Ctrl+R) to apply."
