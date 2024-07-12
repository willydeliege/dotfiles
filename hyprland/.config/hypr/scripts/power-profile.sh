#!/usr/bin/env bash

options=$(printf "power-saver\nbalanced\nperformance" | rofi -dmenu -p "Power Profile")

sudo powerprofilesctl set "$options"
