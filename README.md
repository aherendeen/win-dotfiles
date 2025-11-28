# Windows + WSL Dotfiles

Cross-platform dotfiles for Windows (PowerShell) and WSL (Ubuntu/Bash).

## Features

- **PowerShell** - Modern CLI with Dracula theme, PSReadLine, FZF integration
- **WSL Integration** - Seamless Windows ↔ Ubuntu workflows
- **Scoop** - Windows package manager with fast search
- **Starship** - Cross-shell prompt (works in both pwsh and bash)
- **Modern CLI Tools** - eza, bat, ripgrep, fd, zoxide, fzf

## Structure

```
.dotfiles/
├── powershell/          # PowerShell config (~/.config/powershell)
│   ├── init.ps1         # Main loader
│   ├── config/          # Settings
│   └── functions/       # Modular functions
├── wsl/                 # WSL/Ubuntu config
│   ├── .bashrc          # Bash config
│   ├── .bash_aliases    # Aliases
│   └── .profile         # Login shell
├── shared/              # Cross-platform configs
│   └── starship.toml    # Prompt config
├── install.ps1          # Windows installer
├── install.sh           # WSL/Linux installer
└── README.md
```

## Installation

### Windows (PowerShell)

```powershell
# Clone
git clone https://github.com/YOUR_USERNAME/win-dotfiles.git $HOME\.dotfiles

# Install
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
~\.dotfiles\install.ps1
```

### WSL/Ubuntu

```bash
# Clone (if not already)
git clone https://github.com/YOUR_USERNAME/win-dotfiles.git ~/.dotfiles

# Install
chmod +x ~/.dotfiles/install.sh
~/.dotfiles/install.sh
```

## Dependencies

### Windows (via Scoop)

```powershell
# Install scoop
irm get.scoop.sh | iex

# Install tools
scoop install git starship eza bat ripgrep fd fzf zoxide 7zip sudo
scoop install scoop-search  # Fast scoop search
scoop bucket add nerd-fonts
scoop install FiraCode-NF   # Nerd font for icons

# PowerShell modules
Install-Module Terminal-Icons -Scope CurrentUser -Force
Install-Module PSFzf -Scope CurrentUser -Force
Install-Module posh-git -Scope CurrentUser -Force
```

### WSL/Ubuntu

```bash
# Install tools (handled by install.sh)
sudo apt update && sudo apt install -y \
    git curl wget unzip \
    exa bat ripgrep fd-find fzf
    
# Install starship
curl -sS https://starship.rs/install.sh | sh

# Install zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
```

## Key Bindings

| Key | Action |
|-----|--------|
| `Tab` | Menu complete |
| `Ctrl+R` | Fuzzy history search |
| `Ctrl+T` | Fuzzy file search |
| `Ctrl+F` | FZF tab completion |
| `Ctrl+A/E` | Beginning/End of line |
| `Ctrl+W` | Delete word backward |
| `Ctrl+U/K` | Delete to start/end of line |

## Aliases

### Navigation
| Alias | Command |
|-------|---------|
| `..`, `...` | Go up directories |
| `~` | Home directory |
| `z <dir>` | Zoxide jump |
| `dev`, `dl`, `docs` | Quick directories |

### Git
| Alias | Command |
|-------|---------|
| `gst` | git status |
| `gaa` | git add --all |
| `gc "msg"` | git commit -m |
| `gp` / `gpl` | git push / pull |
| `gco` / `gcb` | checkout / checkout -b |

### Scoop (Windows)
| Alias | Command |
|-------|---------|
| `si` | scoop install |
| `su` | scoop update |
| `sr` | scoop uninstall |
| `sl` | scoop list |

### WSL Integration
| Alias | Command |
|-------|---------|
| `wsl` | Enter WSL |
| `cdwsl` | Open cwd in WSL bash |
| `wslhome` | Navigate to WSL home |
| `aptup` | apt update && upgrade |

### Modern CLI
| Alias | Replaces |
|-------|----------|
| `ls`, `ll`, `lt` | ls (via eza) |
| `cat` | cat (via bat) |
| `grep` | grep (via ripgrep) |
| `find` | find (via fd) |

## License

MIT
