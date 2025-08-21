#!/bin/bash

# ----------------------------
# wofi-keybinds : Liste les raccourcis Hyprland
# ----------------------------

CONFIG="$HOME/.config/hypr/hyprland.conf"

# Vérifie si le fichier existe
if [ ! -f "$CONFIG" ]; then
    notify-send "Hyprland" "Config introuvable : $CONFIG"
    exit 1
fi

# Fonction récursive pour collecter les configs (inclut les 'source = ...')
collect_configs() {
    local file="$1"
    echo "$file"

    # Cherche les includes (source = path)
    grep -E "^\s*source\s*=" "$file" | while read -r line; do
        include=$(echo "$line" | cut -d '=' -f2- | xargs)
        # Remplace ~ par $HOME si présent
        include="${include/#\~/$HOME}"
        # Si chemin relatif -> relatif au fichier parent
        if [[ "$include" != /* ]]; then
            include="$(dirname "$file")/$include"
        fi
        if [ -f "$include" ]; then
            collect_configs "$include"
        fi
    done
}

# Récupère tous les fichiers de config (principal + inclus)
all_configs=$(collect_configs "$CONFIG")

# Extraire les bind/binde/bindm de tous les fichiers
binds=$(grep -h -E "^\s*bind" $all_configs |
    sed 's/^ *//; s/#.*//' |
    awk -F '=' '{print $2}' |
    sed 's/^ *//')

# Construire un menu : raccourci -> commande
menu=$(echo "$binds" |
    awk -F',' '
    {
        mod=$1; key=$2; action=$3; cmd=$4;
        if (action == "exec")
            printf "%-12s + %-8s -> %s\n", mod, key, cmd;
        else
            printf "%-12s + %-8s -> [%s] %s\n", mod, key, action, cmd;
    }')

# Affichage dans wofi
choice=$(echo "$menu" | wofi --dmenu --prompt "Hyprland Keybinds")

# Récupérer la commande de la sélection
$(echo "$choice" | sed 's/.*-> *//')
