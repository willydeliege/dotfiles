#!/bin/bash

# Volume and Brightness Control Script with Persistent Notification
# Usage: ./control.sh [volume|brightness] [up|down|set|mute] [value]

# Configuration
VOLUME_STEP=5
BRIGHTNESS_STEP=5
MAX_VOLUME=150
MAX_BRIGHTNESS=100
NOTIFY_TIMEOUT=2000
ICON_THEME="Adwaita"
NOTIFICATION_ID=9999

# Colors for notifications
COLOR_GREEN="#4CAF50"
COLOR_BLUE="#2196F3"
COLOR_ORANGE="#FF9800"
COLOR_RED="#F44336"
COLOR_GRAY="#9E9E9E"

# Get current volume percentage
get_volume() {
    pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -1
}

# Check if volume is muted
is_muted() {
    pactl get-sink-mute @DEFAULT_SINK@ | grep -q "yes"
}

# Toggle mute
toggle_mute() {
    pactl set-sink-mute @DEFAULT_SINK@ toggle
}

# Get mute status text
get_mute_status() {
    if is_muted; then
        echo " (Muted)"
    else
        echo ""
    fi
}

# Set volume with pactl
set_volume() {
    local volume=$1
    # Unmute if setting volume while muted
    if is_muted && [ $volume -gt 0 ]; then
        pactl set-sink-mute @DEFAULT_SINK@ 0
    fi
    pactl set-sink-volume @DEFAULT_SINK@ ${volume}%
}

# Get current brightness percentage
get_brightness() {
    brightnessctl -m | cut -d',' -f4 | tr -d '%'
}

# Set brightness with brightnessctl
set_brightness() {
    local brightness=$1
    brightnessctl set ${brightness}% > /dev/null
}

# Create stylish notification with persistence
show_notification() {
    local type=$1
    local value=$2
    local max=$3
    local color=$4
    local muted=${5:-false}

    # Create progress bar
    local bar_width=20
    local filled=$((value * bar_width / max))
    local empty=$((bar_width - filled))

    local progress_bar="["
    if [ "$muted" = true ]; then
        # Grayed out progress bar for muted state
        for ((i=0; i<bar_width; i++)); do progress_bar+="░"; done
        color=$COLOR_GRAY
    else
        for ((i=0; i<filled; i++)); do progress_bar+="█"; done
        for ((i=0; i<empty; i++)); do progress_bar+="─"; done
    fi
    progress_bar+="]"

    local percentage="${value}%"
    if [ "$muted" = true ]; then
        percentage="Muted"
    fi

    local title=""
    local icon=""

    case $type in
        "volume")
            title="Volume Control"
            if [ "$muted" = true ] || [ $value -eq 0 ]; then
                icon="audio-volume-muted"
                title="Volume Control (Muted)"
            elif [ $value -le 33 ]; then
                icon="audio-volume-low"
            elif [ $value -le 66 ]; then
                icon="audio-volume-medium"
            else
                icon="audio-volume-high"
            fi
            ;;
        "brightness")
            title="Brightness Control"
            if [ $value -eq 0 ]; then
                icon="display-brightness-off"
            elif [ $value -le 33 ]; then
                icon="display-brightness-low"
            elif [ $value -le 66 ]; then
                icon="display-brightness-medium"
            else
                icon="display-brightness-high"
            fi
            ;;
    esac

    # Use dunstify if available (better for replacement)
    if command -v dunstify &> /dev/null; then
        dunstify \
            -h "int:value:${value}" \
            -h "string:hlcolor:${color}" \
            -t $NOTIFY_TIMEOUT \
            -i "$icon" \
            -r $NOTIFICATION_ID \
            -a "System Control" \
            "$title" \
            "$progress_bar\n$percentage"
    else
        # Fallback to notify-send
        notify-send \
            -h "int:value:${value}" \
            -h "string:hlcolor:${color}" \
            -t $NOTIFY_TIMEOUT \
            -i "$icon" \
            -r $NOTIFICATION_ID \
            --hint=string:x-dunst-stack-tag:system_control \
            "$title" \
            "$progress_bar\n$percentage"
    fi
}

# Play sound feedback (optional) - don't play sound when muting
play_sound() {
    local type=$1
    local value=$2
    local muted=$3

    if [ "$muted" = true ]; then
        return  # No sound for mute/unmute
    fi

    if command -v paplay &> /dev/null && [ $value -gt 0 ]; then
        case $type in
            "volume")
                paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga 2>/dev/null || true
                ;;
            "brightness")
                paplay /usr/share/sounds/freedesktop/stereo/bell.oga 2>/dev/null || true
                ;;
        esac
    fi
}

# Handle volume mute specifically
handle_volume_mute() {
    local current=$(get_volume)
    local muted=$(is_muted && echo "true" || echo "false")

    # Toggle mute
    toggle_mute

    # Get new mute status
    local new_muted=$(is_muted && echo "true" || echo "false")

    # Show notification
    if [ "$new_muted" = true ]; then
        show_notification "volume" $current $MAX_VOLUME $COLOR_GRAY true
    else
        show_notification "volume" $current $MAX_VOLUME $COLOR_GREEN false
        # Play unmute sound if volume > 0
        if [ $current -gt 0 ]; then
            paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga 2>/dev/null || true
        fi
    fi
}

# Main control function
control() {
    local control_type=$1
    local action=$2
    local value=$3

    # Handle mute separately
    if [ "$control_type" = "volume" ] && [ "$action" = "mute" ]; then
        handle_volume_mute
        return
    fi

    case $control_type in
        "volume")
            current=$(get_volume)
            max=$MAX_VOLUME
            step=$VOLUME_STEP
            set_func="set_volume"
            muted=$(is_muted && echo "true" || echo "false")
            ;;
        "brightness")
            current=$(get_brightness)
            max=$MAX_BRIGHTNESS
            step=$BRIGHTNESS_STEP
            set_func="set_brightness"
            muted="false"
            ;;
        *)
            echo "Unknown control type: $control_type"
            echo "Usage: $0 [volume|brightness] [up|down|set|mute] [value]"
            exit 1
            ;;
    esac

    case $action in
        "up")
            new_value=$((current + step))
            [ $new_value -gt $max ] && new_value=$max
            color=$COLOR_GREEN
            ;;
        "down")
            new_value=$((current - step))
            [ $new_value -lt 0 ] && new_value=0
            color=$COLOR_BLUE
            ;;
        "set")
            if [ -z "$value" ]; then
                echo "Value required for set action"
                exit 1
            fi
            new_value=$value
            [ $new_value -gt $max ] && new_value=$max
            [ $new_value -lt 0 ] && new_value=0
            color=$COLOR_ORANGE
            ;;
        *)
            echo "Unknown action: $action"
            echo "Usage: $0 [volume|brightness] [up|down|set|mute] [value]"
            exit 1
            ;;
    esac

    # Apply the change
    $set_func $new_value

    # Show notification and play sound
    show_notification $control_type $new_value $max $color $muted
    # play_sound $control_type $new_value $muted
}

# Handle command line arguments
case ${1:-""} in
    "volume"|"brightness")
        control "$1" "${2:-"up"}" "$3"
        ;;
    "-h"|"--help")
        echo "Volume and Brightness Control Script with Persistent Notification"
        echo "Usage: $0 [volume|brightness] [up|down|set|mute] [value]"
        echo ""
        echo "Features:"
        echo "  - Volume control: up, down, set, mute"
        echo "  - Brightness control: up, down, set"
        echo "  - Notifications stay and update when pressing multiple times"
        echo "  - Progress bars and color coding"
        echo "  - Sound feedback (except for mute)"
        echo ""
        echo "Examples:"
        echo "  $0 volume up           # Increase volume by $VOLUME_STEP%"
        echo "  $0 volume down         # Decrease volume by $VOLUME_STEP%"
        echo "  $0 volume set 75       # Set volume to 75%"
        echo "  $0 volume mute         # Toggle mute/unmute"
        echo "  $0 brightness up       # Increase brightness by $BRIGHTNESS_STEP%"
        echo "  $0 brightness set 50   # Set brightness to 50%"
        ;;
    *)
        echo "Usage: $0 [volume|brightness] [up|down|set|mute] [value]"
        echo "Use -h or --help for more information"
        exit 1
        ;;
esac
