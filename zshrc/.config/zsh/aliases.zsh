# Reuse ls completions for eza (avoids defining a separate completion function)
compdef eza=ls

# Better cat
alias cat='bat'

# =========================================================
# Core utilities
# =========================================================

alias grep='rg --color=auto'
alias diff='diff --color=auto'
alias df='df -h'

# =========================================================
# Eza (ls replacement)
# =========================================================

eza_params=(
  '--git' '--icons' '--group' '--group-directories-first'
  '--time-style=long-iso' '--color-scale=all'
)
alias ls='eza ${(@)eza_params}'
alias l='eza --git-ignore ${(@)eza_params}'
alias ll='eza --all --header --long ${(@)eza_params}'
alias llm='eza --all --header --long --sort=modified ${(@)eza_params}'
alias la='eza -lbhHigUmuSa'
alias lx='eza -lbhHigUmuSa@'
alias lt='eza --tree ${(@)eza_params}'
alias tree='eza --tree ${(@)eza_params}'
# =========================================================
# Navigation
# =========================================================

alias -- -='cd -'  # -- prevents - being parsed as a flag; cd - jumps to previous directory

lf() { # zsh follow lf navigation
    tmp=$(mktemp)
    command lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir=$(cat "$tmp")
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

# =========================================================
# Editor
# =========================================================

alias vim='nvim'

# =========================================================
# Git
# =========================================================

alias glog='PAGER="less -F -X" git log'                              # -F quit if one screen, -X no clear on exit
alias gadog='PAGER="less -F -X" git log --all --decorate --oneline --graph'
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# =========================================================
# Video
# =========================================================

alias stream='mpv av://v4l2:/dev/video4 --fullscreen --demuxer-lavf-o=input_format=mjpeg,framerate=30 --profile=low-latency --untimed'

# =========================================================
# tmux projects
# =========================================================

alias tm='~/.local/bin/tmux-sessionizer'

# =========================================================
# Processes
# =========================================================

alias pgrep='pgrep -a'
alias pkill='pkill -c'

# =========================================================
# Utils
# =========================================================
alias md='mkdir -p'
alias rmf='rm -rf'
