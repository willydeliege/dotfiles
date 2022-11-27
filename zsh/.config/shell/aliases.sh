#!/bin/bash
# Aliases
alias 7zc="7z a -mx=9"
alias acp="advcp -gv"
alias amv="advmv -gv"
alias apti="sudo apt install"
alias apts="apt search"
alias aptr="sudo apt remove"
alias aptq="apt show"
alias aptu="sudo apt update && sudo apt upgrade"
alias aran="autorandr -l"
alias asc="asciinema"
alias cat="bat"
alias bat="batcat" # only usefull on ubuntu
alias ccp="clipcopy"
alias cdx='cd $(xplr)'
alias cless='colorize_less -N'
alias cols='spectrum_ls'
alias cp="cp -irv"
alias cpa="clippaste"
alias diff="diff --color=auto"
alias e='nvim $(files)'
alias exag="exa -ahlT -L=1  -s=extension --git --group-directories-first"
alias fd="fd -H"
alias fdir="find . -type d -name"
alias ffil="find . -type f -name"
alias files="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
alias gbrr="git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format='%(refname:short)'"
alias gc="git commit -m"
alias gcm="git checkout main"
alias gcma="git commit --amend -m"
alias gcmn="git add . && git commit --amend --no-edit"
alias gdh="git diff HEAD"
alias ghrd="gh repo edit -d 'Sample description'"
alias ghrh="gh repo edit -h 'https://user.github.io/repo'"
alias ghrt="gh repo edit --add-topic 'topic1,topic2'"
alias ghrv="gh repo edit --visibility public"
alias gmv="git mv"
alias gsv="git status -v"
alias gtop='cd "$(git rev-parse --show-toplevel)"'
alias grep="grep --color=auto"
alias jupn="jupyter notebook"
alias ln="ln -sv"
alias ls='exa -a --icons --git --group-directories-first --time-style=long-iso'
alias lz='exa --icons --git --group-directories-first --time-style=long-iso'
alias l='ls -lbF'
alias ll='ls -la'
alias llm='ll --sort=modified'
alias la='ls -lbhHigUmuSa'
alias lx='ls -lbhHigUmuSa@'
alias tree='exa --tree'

alias nm="neomutt"
alias me="README.md"
alias mv="mv -iv"
alias ncdu="ncdu --color=dark -x"
alias npi="npm install"
alias npr="npm run"
alias open="open_command"
alias plasmar="kquitapp5 plasmashell && kstart5 plasmashell"
alias pp="prettyping --nolegend"
alias q="exit"
alias rm="rm -irv"
alias rmf="rm -rf"
alias serv="python -m http.server 1234"
alias shad="ssh-add ~/.ssh/id_rsa"
alias shag='eval "$(ssh-agent -s)"'
alias sto="stackoverflow"
alias sysd="sudo systemctl disable"
alias syse="sudo systemctl enable"
alias sysr="sudo systemctl restart"
alias syss="systemctl status"
alias systa="sudo systemctl start"
alias systo="sudo systemctl stop"
alias trii="trizen -S --noedit"
alias tris="trizen -Ss --noedit"
alias triu="trizen -Syu --noedit"
alias tt="taskwarrior-tui"
alias vi="nvim"
alias xp="xplr"
alias ytdl="youtube-dl"

if [ -f "/usr/bin/grc" ]; then
    alias df="grc df"
    alias gcc="grc gcc"
    alias iwconfig="grc iwconfig"
    alias last="grc last"
    alias make="grc make"
    alias mount="grc mount"
    alias mtr="grc mtr"
    alias ping="grc ping"
    alias ps="grc ps"
    alias traceroute="grc traceroute"
    alias wdiff="grc wdiff"
fi

alias vimrc="vim ~/.vimrc"
alias nvimrc="nvim ~/.config/nvim/init.vim"
alias zshrc="$EDITOR ~/.zshrc"
alias bashrc="$EDITOR ~/.bashrc"
alias alia="$EDITOR ~/.config/shell/aliases.sh"
alias enva="$EDITOR ~/.config/shell/envars.sh"
alias func="$EDITOR ~/.config/shell/functions.sh"
alias p2k="$EDITOR ~/.config/shell/powerlevel2k.zsh"

# Causes Issues
# if [ -f "/usr/bin/kdeconnect-cli" ]; then
#     alias send="kdeconnect-cli -d "$(kdeconnect-cli -a --id-only)" --share"
# fi
