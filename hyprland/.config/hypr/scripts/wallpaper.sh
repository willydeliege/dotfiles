#!/bin/bash
#                _ _
# __      ____ _| | |_ __   __ _ _ __   ___ _ __
# \ \ /\ / / _` | | | '_ \ / _` | '_ \ / _ \ '__|
#  \ V  V / (_| | | | |_) | (_| | |_) |  __/ |
#   \_/\_/ \__,_|_|_| .__/ \__,_| .__/ \___|_|
#                   |_|         |_|
#
# by Stephan Raabe (2023)
# -----------------------------------------------------

# Cache file for holding the current wallpaper
wallpaper_folder="$HOME/wallpaper"
cache_file="$HOME/.cache/current_wallpaper"
blurred="$HOME/.cache/blurred_wallpaper.png"
square="$HOME/.cache/square_wallpaper.png"
rasi_file="$HOME/.cache/current_wallpaper.rasi"
blur_file="$HOME/.config/.settings/blur.sh"
wallpaper=""
blur="50x30"
blur=$(cat $blur_file)

# Create cache file if not exists
if [ ! -f $cache_file ] ;then
    touch $cache_file
    echo "$wallpaper_folder/archlinux.png" > "$cache_file"
fi

# Create rasi file if not exists
if [ ! -f $rasi_file ] ;then
    touch $rasi_file
    echo "* { current-image: url(\"$wallpaper_folder/archlinux.png\", height); }" > "$rasi_file"
fi

current_wallpaper=$(cat "$cache_file")

case $1 in

    # Load wallpaper from .cache of last session
    "init")
        sleep 1
        if [ -f $cache_file ]; then
	    wallpaper=$current_wallpaper
            wallust run -s $current_wallpaper
        else
	    wallpaper=$wallpaper_folder/$(ls $wallpaper_folder -1 | shuf -n 1)
            wallust run -s $wallpaper

        fi
    ;;

    # Select wallpaper with rofi
    "select")
        sleep 0.2
        selected=$( find "$wallpaper_folder" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort -R | while read -r rfile
        do
            echo -en "$rfile\x00icon\x1f$wallpaper_folder/${rfile}\n"
        done | rofi -dmenu -i -replace -config ~/.config/rofi/config-wallpaper.rasi)
        if [ ! "$selected" ]; then
            echo "No wallpaper selected"
            exit
        fi
	wallpaper=$wallpaper_folder/$selected
        wallust run -s $wallpaper
	echo $wallpaper
    ;;

    # Randomly select wallpaper
    *)
	wallpaper=$wallpaper_folder/$(ls $wallpaper_folder -1 | shuf -n 1)
        wallust run -s $wallpaper
    ;;

esac


echo ":: Wallpaper: $wallpaper"

# -----------------------------------------------------
# get wallpaper image name
# -----------------------------------------------------
newwall=$(echo $wallpaper | sed "s|$wallpaper_folder/||g")

# -----------------------------------------------------
# Reload waybar with new colors
# -----------------------------------------------------
~/.config/waybar/launch.sh
swaync-client -rs
# -----------------------------------------------------
# Set the new wallpaper
# -----------------------------------------------------
# transition_type="wipe"
# transition_type="outer"
transition_type="random"


    # swww
    echo ":: Using swww"
    swww img $wallpaper \
        --transition-bezier .43,1.19,1,.4 \
        --transition-fps=60 \
        --transition-type=$transition_type \
        --transition-duration=0.5 \
        --transition-pos "$( hyprctl cursorpos )"


if [ "$1" == "init" ] ;then
    echo ":: Init"
else
    sleep 1
    notify-send "Changing wallpaper ..." "with image $newwall" -h int:value:25

fi

# -----------------------------------------------------
# Created blurred wallpaper
# -----------------------------------------------------
if [ "$1" == "init" ] ;then
    echo ":: Init"
else
    echo "Creating blurred version ..." "with image $newwall"
fi

magick $wallpaper -resize 75% $blurred
echo ":: Resized to 75%"
if [ ! "$blur" == "0x0" ] ;then
    magick $blurred -blur $blur $blurred
    echo ":: Blurred"
fi

# -----------------------------------------------------
# Created quare wallpaper
# -----------------------------------------------------
if [ "$1" == "init" ] ;then
    echo ":: Init"
else
    echo "Creating square version ..." "with image $newwall"
fi
magick $wallpaper -gravity Center -extent 1:1 $square
echo ":: Square version created"

# -----------------------------------------------------
# Write selected wallpaper into .cache files
# -----------------------------------------------------
echo "$wallpaper" > "$cache_file"
echo "* { current-image: url(\"$blurred\", height); }" > "$rasi_file"

# -----------------------------------------------------
# Send notification
# -----------------------------------------------------

if [ "$1" == "init" ] ;then
    echo ":: Init"
else
    notify-send "Wallpaper procedure complete!" "with image $newwall" -h int:value:100
fi

echo "DONE!"
