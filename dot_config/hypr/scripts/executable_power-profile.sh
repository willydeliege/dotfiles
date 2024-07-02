#!/usr/bin/env bash

options=$(printf "powersave\nreset\nperformance" | rofi -dmenu -p "Power Profile")

sudo auto-cpufreq --force "$options"
