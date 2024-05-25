#!/usr/bin/env bash

# Format JSON proper;y
JSON=$(hyprkeys --from-ctl --json | jq -r --slurp "[.[]][0]");

USER_SELECTED=$(echo $JSON | jq -r 'range(0, length) as $i | "\($i) \(.[$i].mods) \(.[$i].key) \(.[$i].dispatcher) \(.[$i].arg)"' | rofi -dmenu -p 'Keybinds' -config ~/.config/rofi/config-compact.rasi | awk -F ' ' '{print $1}')

if [ -z "$USER_SELECTED" ]; then
    exit 0;
fi

EVENT=$(echo $JSON | jq -r "[.[]] | .[$USER_SELECTED]" | jq -r '"\(.dispatcher) \(.arg)"');

hyprctl dispatch "$EVENT";
