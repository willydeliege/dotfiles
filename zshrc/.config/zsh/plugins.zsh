# =========================================================
# Plugins
# =========================================================

ZPLUGINDIR="${ZDOTDIR:-$HOME/.config/zsh}/plugins"

_zplugin_load() {
  local repo="${1}"
  local plugin="${2}"
  local plugin_path="${ZPLUGINDIR}/${plugin}"

  if [[ ! -d "$plugin_path" ]]; then
    mkdir -p "$ZPLUGINDIR"
    echo "Installing ${plugin}..."

    # Gestion spécifique pour Oh My Zsh
    if [[ "$repo" == "ohmyzsh" ]]; then
      # On clone uniquement le dossier du plugin grâce à l'option sparse-checkout
      git clone --depth=1 --filter=blob:none --sparse "https://github.com/ohmyzsh/ohmyzsh" "$plugin_path" \
        || { echo "ERROR: failed to install ${plugin}" >&2; return 1; }
      git -C "$plugin_path" sparse-checkout set "plugins/${plugin}"

      # On crée un lien symbolique pour que le fichier .plugin.zsh soit à la racine du dossier
      ln -s "${plugin_path}/plugins/${plugin}/${plugin}.plugin.zsh" "${plugin_path}/${plugin}.plugin.zsh"
    else
      # Comportement normal pour les autres plugins
      git clone --depth=1 "https://github.com/${repo}/${plugin}" "$plugin_path" \
        || { echo "ERROR: failed to install ${plugin}" >&2; return 1; }
    fi
  fi
  source "${plugin_path}/${plugin}.plugin.zsh"
}

zplugin-update() {
  local dir
  for dir in "${ZPLUGINDIR}"/*/; do
    echo "Updating ${dir:t}..."
    git -C "$dir" pull --ff-only
  done
}

# Zplugins
_zplugin_load zsh-users zsh-autosuggestions
_zplugin_load zsh-users zsh-history-substring-search
_zplugin_load zdharma-continuum fast-syntax-highlighting
_zplugin_load z-shell zsh-eza

# Plugin oh-my-zsh
_zplugin_load ohmyzsh sudo
