#!/usr/bin/env bash

options=$(printf "powersave\nreset\nperformance" | rofi -dmenu -p "Power Profile" -config ~/.config/rofi/config-dmenu.rasi)

sudo  auto-cpufreq --force "$options"
