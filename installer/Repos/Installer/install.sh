#!/usr/bin/env sh
sudo pacman -Syu
sudo pacman -S --needed "$(cat ./install_sway.pac)"
(git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si)
yay -S --needed "$(cat ./install_sway.aur)"
