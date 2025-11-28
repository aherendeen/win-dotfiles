#!/bin/bash
#
# WSL/Ubuntu Dotfiles Installer
# Creates symlinks from ~ to the dotfiles repository
#

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="$HOME/.config"

echo ""
echo "🚀 WSL/Ubuntu Dotfiles Installer"
echo "================================"
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Create backup directory
backup_dir="$HOME/.dotfiles_backup/$(date +%Y%m%d-%H%M%S)"

backup_file() {
    local file="$1"
    if [ -e "$file" ] && [ ! -L "$file" ]; then
        mkdir -p "$backup_dir"
        echo -e "${YELLOW}📦 Backing up $file${NC}"
        mv "$file" "$backup_dir/"
    elif [ -L "$file" ]; then
        rm "$file"
    fi
}

create_symlink() {
    local src="$1"
    local dest="$2"
    backup_file "$dest"
    ln -sf "$src" "$dest"
    echo -e "${GREEN}✓${NC} Linked $dest -> $src"
}

# Create config directory
mkdir -p "$CONFIG_DIR"

echo -e "${CYAN}📝 Installing bash config...${NC}"
create_symlink "$DOTFILES_DIR/wsl/.bashrc" "$HOME/.bashrc"
create_symlink "$DOTFILES_DIR/wsl/.bash_aliases" "$HOME/.bash_aliases"
create_symlink "$DOTFILES_DIR/wsl/.profile" "$HOME/.profile"

echo ""
echo -e "${CYAN}⭐ Installing starship config...${NC}"
create_symlink "$DOTFILES_DIR/shared/starship.toml" "$CONFIG_DIR/starship.toml"

echo ""
echo -e "${GREEN}✅ Installation complete!${NC}"

if [ -d "$backup_dir" ]; then
    echo ""
    echo -e "${YELLOW}Backups saved to: $backup_dir${NC}"
fi

echo ""
echo -e "${CYAN}Next steps:${NC}"
echo "  1. Restart your shell or run: source ~/.bashrc"
echo "  2. Install dependencies:"
echo ""
echo "     # Essential tools"
echo "     sudo apt update && sudo apt install -y git curl wget unzip"
echo ""
echo "     # Modern CLI tools"
echo "     sudo apt install -y bat ripgrep fd-find fzf"
echo ""
echo "     # exa/eza (check latest install method)"
echo "     # https://github.com/eza-community/eza"
echo ""
echo "     # Starship prompt"
echo "     curl -sS https://starship.rs/install.sh | sh"
echo ""
echo "     # Zoxide"
echo "     curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh"
echo ""
