#!/usr/bin/env bash
swaylock \
    -fSle \
    --indicator \
    --indicator-radius 110 \
    --indicator-idle-visible \
    --clock \
    --timestr "%-l:%M %p" \
    --datestr "%a, %B %-e, %Y" \
    --effect-blur 5x5 \
    --grace 3
