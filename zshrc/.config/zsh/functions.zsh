# Fuzzy attach or create tmux sessions
tm() {
  [[ -n "$TMUX" ]] && echo "Already inside a tmux session!" && return 1

  local session
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0 --query="$1" --prompt="Select Session: ")

  if [[ -n "$session" ]]; then
    tmux attach-session -t "$session"
  elif [[ -n "$1" ]]; then
    tmux new-session -s "$1"
  else
    tmux new-session
  fi
}
