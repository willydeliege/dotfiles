# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
if [ ! -d ~/.oh-my-zsh/custom/plugins/fzf-tab ]; then
    git clone https://github.com/Aloxaf/fzf-tab ~/.oh-my-zsh/custom/plugins/fzf-tab
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/fzf-tab-source ]; then
    git clone https://github.com/Freed-Wu/fzf-tab-source.git ~/.oh-my-zsh/custom/plugins/fzf-tab-source
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(
    extract
    eza
    git
    archlinux
    emacs
    command-not-found
    zsh-autosuggestions
    zsh-syntax-highlighting
    fzf-tab
    fzf-tab-source
)

source $ZSH/oh-my-zsh.sh

# Check archlinux plugin commands here
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/archlinux

# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
#pokemon-colorscripts --no-title -s -r #without fastfetch
#pokemon-colorscripts --no-title -s -r | fastfetch -c $HOME/.config/fastfetch/config-pokemon.jsonc --logo-type file-raw --logo-height 10 --logo-width 5 --logo -

# fastfetch. Will be disabled if above colorscript was chosen to install
fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

# Set-up icons for files/directories in terminal using lsd
alias jctl="journalctl -p 3 -xb"
# Safer remove
alias rm='rm -iv'
alias rmf='rm -rf'
alias mv='mv -iv'
alias cp='cp -iv'
# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

# Globalias cam bn used anywhere in the command line
alias -g G='| rg'
alias -g B='| bat'
alias -g W='| wc -l'

eval "$(zoxide init zsh)"

zstyle ':completion:*' rehash true
zstyle ':fzf-tab:complete:-command-:*' fzf-preview \
    ¦ '(out=$(tldr --color always "$word") 2>/dev/null && echo $out) || (out=$(MANWIDTH=$FZF_PREVIEW_COLUMNS man "$word") 2>/dev/null && echo $out) || (out=$(which "$word") && echo $out) || echo "${(P)word}"'
# Ctrl+Backspace: kill the word backward
bindkey -M emacs '^H' backward-kill-word
bindkey -M viins '^H' backward-kill-word
bindkey -M vicmd '^H' backward-kill-word

# Ctrl+Delete: kill the word forward
bindkey -M emacs '^[[3;5~' kill-word
bindkey -M viins '^[[3;5~' kill-word
bindkey -M vicmd '^[[3;5~' kill-word

export EDITOR=emacs
export SUDO_EDITOR=vim
export SYSTEMD_EDITOR=vim
# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
