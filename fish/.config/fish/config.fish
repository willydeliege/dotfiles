if status is-interactive
    # Commands to run in interactive sessions can go here
  zoxide init --cmd j fish | source

  set -xg EDITOR nvim
  set -xg PULSE_SERVER 127.0.0.1
  set -xg TMPDIR /tmp
  set -xg ZK_NOTEBOOK_DIR ~/willydeliege/
  set -xg NPM_CONFIG_PREFIX ~/.npm-global
  set -Ux EXA_STANDARD_OPTIONS --icons
  fzf_configure_bindings --git_status=\cS --directory=\cF --git_log=\cO  
end
