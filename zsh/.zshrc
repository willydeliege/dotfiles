if [ ! -d ~/.oh-my-zsh/custom/plugins/exa-zsh ]; then
    git clone https://github.com/MohamedElashri/exa-zsh ~/.oh-my-zsh/custom/plugins/exa-zsh
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/alias-tips ]; then
    git clone https://github.com/djui/alias-tips.git ~/.oh-my-zsh/custom/plugins/alias-tips
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autopair ]; then
    git clone https://github.com/hlissner/zsh-autopair.git ~/.oh-my-zsh/custom/plugins/zsh-autopair
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/fzf-tab ]; then
    git clone https://github.com/Aloxaf/fzf-tab ~/.oh-my-zsh/custom/plugins/fzf-tab
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/fzf-tab-source ]; then
    git clone https://github.com/Freed-Wu/fzf-tab-source.git ~/.oh-my-zsh/custom/plugins/fzf-tab-source
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/fedora ]; then
 git clone https://github.com/gmifflen/zsh-fedora-plugin.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fedora
fi

export PATH="/home/willefi/.local/share/gem/ruby/3.0.0/bin:/home/willefi/.local/bin:/home/willefi/.config/emacs/bin:$PATH"

export ZSH="$HOME/.oh-my-zsh"
export ZOXIDE_CMD_OVERRIDE="cd"
# ZSH_THEME="crunch"

plugins=(
    fedora
    extract
    systemd
    sudo zoxide
    git
    emacs
    globalias alias-tips
    fzf-tab-source
    fzf-tab fzf
    zsh-autopair
    zsh-syntax-highlighting zsh-autosuggestions
    cp
    exa-zsh
    colored-man-pages
)

source /home/willefi/.oh-my-zsh/oh-my-zsh.sh
zstyle ':completion:*' rehash true
zstyle ':fzf-tab:sources' config-directory ~/.zsh-sources/
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

# Aliases
# Get the error messages from journalctl
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

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

eval "$(starship init zsh)"
