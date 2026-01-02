#!/usr/bin/env bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script directory
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    else
        echo "unknown"
    fi
}

OS_TYPE=$(detect_os)

# Install Homebrew
install_brew() {
    if command_exists brew; then
        log_warning "Homebrew is already installed"
        return 0
    fi

    log_info "Installing Homebrew..."
    if [[ "$OS_TYPE" == "macos" ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    elif [[ "$OS_TYPE" == "linux" ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for Linux
        echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
    log_success "Homebrew installed successfully"
}

# Install Git
install_git() {
    if command_exists git; then
        log_warning "Git is already installed"
        return 0
    fi

    log_info "Installing Git..."
    if [[ "$OS_TYPE" == "macos" ]]; then
        brew install git
    elif [[ "$OS_TYPE" == "linux" ]]; then
        sudo apt-get update
        sudo apt-get install -y git
    fi
    log_success "Git installed successfully"
}

# Install Zsh
install_zsh() {
    if command_exists zsh; then
        log_warning "Zsh is already installed"
    else
        log_info "Installing Zsh..."
        if [[ "$OS_TYPE" == "macos" ]]; then
            brew install zsh
        elif [[ "$OS_TYPE" == "linux" ]]; then
            sudo apt-get update
            sudo apt-get install -y zsh
        fi
        log_success "Zsh installed successfully"
    fi

    # Set Zsh as default shell
    if [[ "$SHELL" != *"zsh"* ]]; then
        log_info "Setting Zsh as default shell..."
        if ! grep -q "$(which zsh)" /etc/shells; then
            echo "$(which zsh)" | sudo tee -a /etc/shells
        fi
        chsh -s "$(which zsh)"
        log_success "Zsh set as default shell (restart terminal to apply)"
    else
        log_warning "Zsh is already the default shell"
    fi
}

# Install Oh My Zsh
install_oh_my_zsh() {
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        log_warning "Oh My Zsh is already installed"
        return 0
    fi

    log_info "Installing Oh My Zsh..."
    RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    log_success "Oh My Zsh installed successfully"
}

# Install Neovim
install_neovim() {
    local reinstall=false
    
    if command_exists nvim; then
        local current_version=$(nvim --version | head -n1)
        log_warning "Neovim is already installed: $current_version"
        
        # Check if it's from apt (version conflict risk)
        if dpkg -l | grep -q "neovim" 2>/dev/null; then
            log_warning "Detected apt-installed Neovim (may cause version conflicts)"
            echo -n "Do you want to remove it and install the latest from GitHub? (y/N): "
            read -r response
            if [[ "$response" =~ ^[Yy]$ ]]; then
                log_info "Removing apt-installed Neovim..."
                sudo apt-get remove -y neovim
                sudo apt-get autoremove -y
                reinstall=true
            else
                log_info "Keeping existing Neovim installation"
                return 0
            fi
        else
            echo -n "Do you want to reinstall Neovim with the latest version? (y/N): "
            read -r response
            if [[ "$response" =~ ^[Yy]$ ]]; then
                reinstall=true
            else
                log_info "Keeping existing Neovim installation"
                return 0
            fi
        fi
    fi

    log_info "Installing Neovim..."
    if [[ "$OS_TYPE" == "macos" ]]; then
        brew install neovim
    elif [[ "$OS_TYPE" == "linux" ]]; then
        # Install latest stable Neovim from GitHub releases
        log_info "Downloading latest stable Neovim from GitHub..."
        
        # Install dependencies
        sudo apt-get update
        sudo apt-get install -y curl
        
        # Download latest stable release
        NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
        curl -Lo /tmp/nvim-linux64.tar.gz "$NVIM_URL"
        
        # Extract and install
        sudo rm -rf /opt/nvim /opt/nvim-linux-x86_64
        sudo tar -C /opt -xzf /tmp/nvim-linux64.tar.gz
        sudo mv /opt/nvim-linux-x86_64 /opt/nvim
        
        # Create symlink (remove any existing one first)
        sudo rm -f /usr/local/bin/nvim
        sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
        
        # Cleanup
        rm /tmp/nvim-linux64.tar.gz
    fi
    log_success "Neovim installed successfully"
    nvim --version | head -n1
}

# Install Tmux
install_tmux() {
    if command_exists tmux; then
        log_warning "Tmux is already installed"
    else
        log_info "Installing Tmux..."
        if [[ "$OS_TYPE" == "macos" ]]; then
            brew install tmux
        elif [[ "$OS_TYPE" == "linux" ]]; then
            sudo apt-get update
            sudo apt-get install -y tmux
        fi
        log_success "Tmux installed successfully"
    fi
    
    # Install xclip for clipboard support (Linux only)
    if [[ "$OS_TYPE" == "linux" ]]; then
        if ! command_exists xclip; then
            log_info "Installing xclip for clipboard support..."
            sudo apt-get install -y xclip
            log_success "xclip installed successfully"
        else
            log_warning "xclip is already installed"
        fi
    fi
}

# Install LazyGit
install_lazygit() {
    if command_exists lazygit; then
        log_warning "LazyGit is already installed"
        return 0
    fi

    log_info "Installing LazyGit..."
    if [[ "$OS_TYPE" == "macos" ]]; then
        brew install lazygit
    elif [[ "$OS_TYPE" == "linux" ]]; then
        LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        tar xf lazygit.tar.gz lazygit
        sudo install lazygit /usr/local/bin
        rm lazygit.tar.gz lazygit
    fi
    log_success "LazyGit installed successfully"
}

# Install LazyDocker
install_lazydocker() {
    if command_exists lazydocker; then
        log_warning "LazyDocker is already installed"
        return 0
    fi

    log_info "Installing LazyDocker..."
    if [[ "$OS_TYPE" == "macos" ]]; then
        brew install lazydocker
    elif [[ "$OS_TYPE" == "linux" ]]; then
        curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
    fi
    log_success "LazyDocker installed successfully"
}

# Install Ripgrep
install_ripgrep() {
    if command_exists rg; then
        log_warning "Ripgrep is already installed"
        return 0
    fi

    log_info "Installing Ripgrep..."
    if [[ "$OS_TYPE" == "macos" ]]; then
        brew install ripgrep
    elif [[ "$OS_TYPE" == "linux" ]]; then
        sudo apt-get update
        sudo apt-get install -y ripgrep
    fi
    log_success "Ripgrep installed successfully"
}

# Install Nerd Font (Mononoki)
install_nerd_font() {
    log_info "Installing Mononoki Nerd Font..."
    
    if [[ "$OS_TYPE" == "macos" ]]; then
        brew tap homebrew/cask-fonts
        brew install --cask font-mononoki-nerd-font
    elif [[ "$OS_TYPE" == "linux" ]]; then
        FONT_DIR="$HOME/.local/share/fonts"
        mkdir -p "$FONT_DIR"
        
        cd "$FONT_DIR"
        FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Mononoki.zip"
        
        if command_exists curl; then
            curl -fLo "Mononoki.zip" "$FONT_URL"
        elif command_exists wget; then
            wget -O "Mononoki.zip" "$FONT_URL"
        fi
        
        unzip -o "Mononoki.zip"
        rm "Mononoki.zip"
        
        # Update font cache
        fc-cache -fv
        cd - > /dev/null
    fi
    log_success "Mononoki Nerd Font installed successfully"
}

# Link Neovim configuration
link_neovim_config() {
    log_info "Linking Neovim configuration..."
    
    NVIM_CONFIG_DIR="$HOME/.config/nvim"
    
    if [[ -d "$NVIM_CONFIG_DIR" ]] && [[ ! -L "$NVIM_CONFIG_DIR" ]]; then
        log_warning "Existing Neovim config found. Creating backup..."
        mv "$NVIM_CONFIG_DIR" "$NVIM_CONFIG_DIR.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    
    mkdir -p "$HOME/.config"
    ln -sf "$DOTFILES_DIR/nvim/.config/nvim" "$NVIM_CONFIG_DIR"
    log_success "Neovim configuration linked successfully"
}

# Link Tmux configuration
link_tmux_config() {
    log_info "Linking Tmux configuration..."
    
    if [[ -f "$HOME/.tmux.conf" ]] && [[ ! -L "$HOME/.tmux.conf" ]]; then
        log_warning "Existing .tmux.conf found. Creating backup..."
        mv "$HOME/.tmux.conf" "$HOME/.tmux.conf.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    
    ln -sf "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
    log_success "Tmux configuration linked successfully"
}

# Setup Zsh aliases
setup_zsh_aliases() {
    log_info "Setting up Zsh aliases..."
    
    ZSHRC="$HOME/.zshrc"
    ALIASES_MARKER="# Custom aliases added by dotfiles install script"
    
    # Check if aliases already exist
    if grep -q "$ALIASES_MARKER" "$ZSHRC" 2>/dev/null; then
        log_warning "Aliases already exist in .zshrc"
        return 0
    fi
    
    # Backup existing .zshrc
    if [[ -f "$ZSHRC" ]]; then
        cp "$ZSHRC" "$ZSHRC.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    
    # Add aliases
    cat >> "$ZSHRC" << 'EOF'

# Custom aliases added by dotfiles install script
alias c='clear'
alias v='nvim'
alias gs='git status'
alias nvz='nvim ~/.zshrc'
alias nvc='nvim ~/.config/nvim'
EOF
    
    log_success "Zsh aliases added to .zshrc"
}

# Display menu and get selection
show_menu() {
    echo ""
    echo -e "${GREEN}=== Dotfiles Installation Script ===${NC}"
    echo ""
    echo "Please select what you want to install:"
    echo ""
    echo "  1) Install All"
    echo "  2) Homebrew"
    echo "  3) Git"
    echo "  4) Zsh + Oh My Zsh"
    echo "  5) Neovim"
    echo "  6) Tmux"
    echo "  7) LazyGit"
    echo "  8) LazyDocker"
    echo "  9) Ripgrep"
    echo " 10) Mononoki Nerd Font"
    echo " 11) Link Neovim Config"
    echo " 12) Link Tmux Config"
    echo " 13) Setup Zsh Aliases"
    echo "  0) Exit"
    echo ""
    echo -n "Enter your choices (space-separated, e.g., '2 3 4' or '1' for all): "
}

# Execute installation based on selection
execute_installation() {
    local choice=$1
    
    case $choice in
        1)
            log_info "Installing all tools..."
            install_brew
            install_git
            install_zsh
            install_oh_my_zsh
            install_neovim
            install_tmux
            install_lazygit
            install_lazydocker
            install_ripgrep
            install_nerd_font
            link_neovim_config
            link_tmux_config
            setup_zsh_aliases
            ;;
        2) install_brew ;;
        3) install_git ;;
        4)
            install_zsh
            install_oh_my_zsh
            ;;
        5) install_neovim ;;
        6) install_tmux ;;
        7) install_lazygit ;;
        8) install_lazydocker ;;
        9) install_ripgrep ;;
        10) install_nerd_font ;;
        11) link_neovim_config ;;
        12) link_tmux_config ;;
        13) setup_zsh_aliases ;;
        0)
            log_info "Exiting..."
            exit 0
            ;;
        *)
            log_error "Invalid choice: $choice"
            ;;
    esac
}

# Main execution
main() {
    log_info "Dotfiles directory: $DOTFILES_DIR"
    log_info "Operating System: $OS_TYPE"
    echo ""
    
    show_menu
    read -r input
    
    if [[ -z "$input" ]]; then
        log_error "No selection made. Exiting."
        exit 1
    fi
    
    # Parse and execute each choice
    for choice in $input; do
        execute_installation "$choice"
    done
    
    echo ""
    log_success "Installation complete!"
    echo ""
    log_info "Next steps:"
    echo "  - Restart your terminal or run: exec zsh"
    echo "  - Configure your terminal to use Mononoki Nerd Font"
    echo "  - Run 'nvim' to initialize Neovim plugins (Lazy.nvim will auto-install)"
    echo ""
}

# Run main function
main
