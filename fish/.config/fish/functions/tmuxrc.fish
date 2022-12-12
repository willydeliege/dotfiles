function tmuxrc --wraps='nvim .tmux.conf' --description 'alias tmuxrc nvim .tmux.conf'
  nvim .tmux.conf $argv; 
end
