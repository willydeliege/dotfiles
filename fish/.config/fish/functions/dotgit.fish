function dotgit --wraps='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME' --description 'alias dotgit git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
  git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME $argv
        
end
