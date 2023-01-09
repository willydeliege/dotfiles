function tmuxrc --wraps='nvim .tmux.conf' --wraps='nvim /home/willefi/.tmux.conf' --description 'alias tmuxrc nvim /home/willefi/.tmux.conf'
  nvim /home/willefi/.tmux.conf $argv; 
end
