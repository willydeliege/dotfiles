# general use aliases updated for eza
alias ls='eza'                                         # Basic replacement for ls with eza
alias l='eza --long -bF auto'                          # Extended details with binary sizes and type indicators
alias ll='eza --long -a'                               # Long format
alias llm='eza --long -a --sort=modified'              # Long format, including hidden files, sorted by modification date
alias la='eza -a --group-directories-first'            # Show all files, with directories listed first
alias lx='eza -a --group-directories-first --extended' # Show all files and extended attributes, directories first
alias tree='eza --tree'                                # Tree view
alias lS='eza --oneline'                               # Display one entry per line

# new aliases than exa-zsh
alias lT='eza --tree --long'                       # Tree view with extended details
alias lr='eza --recurse'                           # Recursively list all files, excluding hidden ones
alias lra='eza --recurse --all'                    # Recursively list all files, including hidden ones
alias ld='eza --only-dirs'                         # List only directories
alias lda='eza --only-dirs --all'                  # List only directories with hidden
alias lf='eza --only-files'                        # List only files
alias lfa='eza --only-files --all'                 # List only files with hidden
alias lC='eza --color-scale=size --long'           # Use color scale based on file size
alias li='eza --icons=always --grid'               # Display with icons in grid format
alias lh='eza --hyperlink --all'                   # Display all entries as hyperlinks
alias lX='eza --across'                            # Sort the grid across, rather than downwards
alias lt='eza --long --sort=type'                  # Sort by file type in long format
alias lsize='eza --long --sort=size'               # Sort by size in long format
alias lmod='eza --long --modified --sort=modified' # Sort by modification date in long format, using the modified timestamp

# Advanced filtering and display options
alias ldepth='eza --level=2'          # Limit recursion depth to 2
alias lignore='eza --git-ignore'      # Ignore files mentioned in .gitignore
alias lcontext='eza --long --context' # Show security context
# Better cat
alias cat='bat'

# =========================================================
# Core utilities
# =========================================================

alias grep='rg --color=auto'
alias diff='diff --color=auto'
alias df='df -h'

# =========================================================
# Navigation
# =========================================================

alias -- -='cd -' # -- prevents - being parsed as a flag; cd - jumps to previous directory

# =========================================================
# Editor
# =========================================================

alias vim='nvim'
alias vi='nvim'
# =========================================================
# Git
# =========================================================

alias glog='PAGER="less -F -X" git log' # -F quit if one screen, -X no clear on exit
alias gadog='PAGER="less -F -X" git log --all --decorate --oneline --graph'
alias dotfiles='git --git-dir=$HOME/dotfiles --work-tree=$HOME'
alias lg='lazygit'

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
alias cp='cp -iv'
