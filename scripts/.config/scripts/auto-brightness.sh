#!/usr/bin/env sh

if acpi --ac-adapter | rg on-line; then
    brightnessctl set 60%
else
    brightnessctl set 30%
fi
