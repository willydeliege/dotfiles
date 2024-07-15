#!/usr/bin/env bash
options=$(printf "Paris\nBelgium\nDisconnect" | rofi -dmenu -p "Choose region" -config ~/.config/rofi/config-dmenu.rasi)
case $options in
    Disconnect)
        nordvpn d
        ;;
    *)
        nordvpn connect "$options"
        ;;
esac
