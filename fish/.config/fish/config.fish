if status is-interactive
    # Commands to run in interactive sessions can go here
  fish_vi_key_bindings
  zoxide init --cmd j fish | source

  set -xg EDITOR nvim
  set -xg TERM xterm-256color
  set -xg TMPDIR /tmp
  set -xg PULSE_SERVER 127.0.0.1
  set -xg ZK_NOTEBOOK_DIR ~/willydeliege/
  set -Ux EXA_STANDARD_OPTIONS --icons
  fzf_configure_bindings --git_status=\cS --directory=\cF --git_log=\cO  
end
