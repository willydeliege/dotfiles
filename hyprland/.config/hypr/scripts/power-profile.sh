#!/usr/bin/env bash

options=$(printf "power-saver\nbalanced\nperformance" | rofi -dmenu -p "Power Profile" -config ~/.config/rofi/config-dmenu.rasi)

sudo powerprofilesctl set "$options"
