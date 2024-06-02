#!/bin/bash

    # swww
    echo ":: Using swww"
    swww init
    swww-daemon --format xrgb
    sleep 0.5
    ~/.config/hypr/scripts/wallpaper.sh 
 
