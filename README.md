# dotfiles

Personal configuration files for Unix-based systems (macOS and Linux).

## What's Included

- **Neovim**: Complete Neovim configuration with Lazy.nvim plugin manager
- **Tmux**: Terminal multiplexer configuration
- **Zsh**: Shell configuration with Oh My Zsh
- **Dev Tools**: LazyGit, LazyDocker, Ripgrep
- **Fonts**: Mononoki Nerd Font

## Quick Start

### One-Command Installation

```bash
cd ~/dotfiles
./install.sh
```

### Selective Installation

You can choose specific tools to install:

```bash
cd ~/dotfiles
./install.sh
# Enter space-separated numbers, e.g.: 2 4 5 7
```

### Installation Options

1. **Install All** - Installs everything listed below
2. **Homebrew** - Package manager (required for many tools on macOS)
3. **Git** - Version control system
4. **Zsh + Oh My Zsh** - Shell with framework and sets Zsh as default
5. **Neovim** - Modern Vim-based text editor
6. **Tmux** - Terminal multiplexer
7. **LazyGit** - Terminal UI for Git
8. **LazyDocker** - Terminal UI for Docker
9. **Ripgrep** - Fast search tool
10. **Mononoki Nerd Font** - Programming font with icons
11. **Link Neovim Config** - Symlink Neovim configuration
12. **Link Tmux Config** - Symlink Tmux configuration
13. **Setup Zsh Aliases** - Add custom aliases to .zshrc

## Custom Aliases

The following aliases will be added to your `.zshrc`:

- `c` - Clear terminal
- `gs` - Git status
- `nvz` - Open ~/.zshrc in Neovim
- `nvc` - Open ~/.config/nvim in Neovim

## Post-Installation

1. **Restart your terminal** or run `exec zsh` to apply Zsh changes
2. **Configure terminal font**: Set your terminal to use "Mononoki Nerd Font"
3. **Initialize Neovim**: Run `nvim` - Lazy.nvim will automatically install plugins
4. **Configure Git**

## Features

### Safety
- Automatically backs up existing configurations before linking
- Checks if tools are already installed before attempting installation
- Idempotent - safe to run multiple times

### Cross-Platform
- Supports both macOS and Linux (Ubuntu/Debian)
- Automatically detects OS and uses appropriate installation methods

### Modular
- Install only what you need
- Each tool can be installed independently

## Manual Installation

If you prefer manual installation:

### Neovim Configuration
```bash
ln -s ~/dotfiles/nvim/.config/nvim ~/.config/nvim
```

### Tmux Configuration
```bash
ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
```

## Requirements

- **macOS**: Xcode Command Line Tools (`xcode-select --install`)
- **Linux**: sudo privileges for system package installation

## Troubleshooting

### Permission Denied
If you get "Permission denied" when running the script:
```bash
chmod +x install.sh
```

### Font Not Appearing
After installing fonts, you may need to:
- Restart your terminal application
- Select the font in terminal preferences
- On Linux, verify with: `fc-list | grep Mononoki`
