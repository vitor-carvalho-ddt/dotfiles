# helpers
cdf() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf -e +m) && \
  cd "$dir"
}

## Aliases
# source
alias sz="source ~/.zshrc"
# vim
alias v="nvim"
alias vz="nvim ~/.zshrc"
alias vdf="cd ~/.config/nvim/ && v"
# docker
alias dps="docker ps"
alias dcu="docker compose up -d"
alias dcub="docker compose up -d --build"
alias dcbnc="docker compose build --no-cache"
alias dcd="docker compose down"
openhands() {
  docker run -d --rm --name openhands-app \
    --add-host=host.docker.internal:host-gateway \
    -p 3000:3000 \
    -e SANDBOX_RUNTIME_CONTAINER_IMAGE=docker.openhands.dev/openhands/runtime:latest-nikolaik \
    -e LOG_ALL_EVENTS=true \
    -e "SANDBOX_VOLUMES=$(pwd):/workspace:rw" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v ~/.openhands:/.openhands \
    -v "$(pwd):/workspace" \
    docker.openhands.dev/openhands/openhands:latest
}
# git
alias gs="git status"
alias gl="git log"
alias gau="git add -u"
alias gc="git commit"
alias gsiu="git stash --include-untracked"
# misc
alias c="clear"
alias lzd="lazydocker"
alias lzg="lazigit"

# NeoVim
export PATH="$HOME/nvim-macos-arm64/bin:$PATH"
# GCloud
export PATH="$HOME/google-cloud-sdk/bin:$PATH"
# Golang
export PATH="/usr/local/go/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# tmux-session
export PATH="$HOME/dotfiles/bin:$PATH"
