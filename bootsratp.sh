#!/usr/bin/env bash
#
# Dotfiles bootstrap script using GNU Stow
# - Backs up existing files (if they are not symlinks)
# - Applies GNU Stow cleanly
#

set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/dotfiles_backup/$(date +%Y-%m-%d_%H-%M-%S)"

mkdir -p "$BACKUP_DIR"

# List of "packages" (subfolders inside $DOTFILES_DIR)
PACKAGES=(
    doom
    fish
    foot
    gitconfig
    hyprland
    starship
    swaync
    waybar
    wofi
    zshrc
)

echo "📦 Installing dotfiles from $DOTFILES_DIR"
echo "💾 Backing up existing files to $BACKUP_DIR"
echo

cd "$DOTFILES_DIR"

for pkg in "${PACKAGES[@]}"; do
  echo "➡️  Processing package: $pkg"

  # Dry-run to detect conflicts
  conflicts=$(stow -nv "$pkg" 2>&1 | grep "stowing doom would cause conflicts:" || true)

  if [[ -n "$conflicts" ]]; then
    echo "   ⚠️  Conflicts detected:"
    echo "$conflicts"

    # Extract conflicting files and move them to backup
    while IFS= read -r line; do
      file=$(echo "$line" | awk '{print $NF}')
      if [[ -f "$file" || -d "$file" ]]; then
        echo "   🔄 Backing up $file → $BACKUP_DIR"
        mkdir -p "$BACKUP_DIR$(dirname "$file")"
        mv "$file" "$BACKUP_DIR/"
      fi
    done <<< "$conflicts"
  fi

  # Apply stow
  stow -v "$pkg"
  echo "   ✅ $pkg installed"
  echo
done

echo "✨ All done!"
echo "📂 Backups are stored in: $BACKUP_DIR"
