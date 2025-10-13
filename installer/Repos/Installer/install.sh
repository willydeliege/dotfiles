#!/usr/bin/env sh
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
# Vérifier si l'entrée existe déjà
if ! grep -q "\[chaotic-aur\]" /etc/pacman.conf; then
    echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf >/dev/null
    echo "Chaotic-AUR ajouté à pacman.conf"
else
    echo "Chaotic-AUR est déjà configuré"
fi
sudo pacman -Syu
sudo pacman -S --needed "$(cat ./install_sway.pac)"
(git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si)
yay -S --needed "$(cat ./install_sway.aur)"
