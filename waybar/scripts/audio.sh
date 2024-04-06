#!/bin/bash

# Get Volume
get_volume() {
    volume=$(pactl get-sink-volume $(pactl get-default-sink) | awk -F '/' '{gsub(/\s+|%/, "", $2); print $2}')
    if [[ "$volume" -eq "0" ]]; then
        echo "Muted"
    else
        echo "$volume"
    fi
}

# Increase Volume
inc_volume() {
    pactl set-sink-volume @DEFAULT_SINK@ +5%
}

# Decrease Volume
dec_volume() {
    pactl set-sink-volume @DEFAULT_SINK@ -5%
}

# Toggle Mute
toggle_mute() {
    pactl set-sink-mute $(pactl get-default-sink) toggle

    muted=$(pactl get-sink-mute $(pactl get-default-sink) | awk '/Mute:/ {print $2}')
    if [[ "$muted" = "yes" ]]; then
        notify-send -c "Audio" -t 2000 "  Speakers" "<span color='red'>Volume muted</span>"
    else 
        notify-send -c "Audio" -t 2000 "  Speakers" "Volume enabled"
    fi
}

# Toggle Mic
toggle_mic() {
    pactl set-source-mute $(pactl get-default-source) toggle

    muted=$(pactl get-source-mute $(pactl get-default-source) | awk '/Mute:/ {print $2}')
    if [[ "$muted" = "yes" ]]; then
        notify-send -c "Audio" -t 2000 "  Mic" "<span color='red'>Output muted</span>"
    else 
        notify-send -c "Audio" -t 2000 "  Mic" "Output enabled"
    fi
}

# Get Microphone Volume
get_mic_volume() {
    volume=$(pactl get-source-volume $(pactl get-default-source) | awk -F '/' '{gsub(/\s+|%/, "", $2); print $2}')
    if [[ "$volume" -eq "0" ]]; then
        echo "Muted"
    else
        echo "$volume%"
    fi
}

# Increase MIC Volume
inc_mic_volume() {
    pactl set-source-volume @DEFAULT_SOURCE@ +5%
}

# Decrease MIC Volume
dec_mic_volume() {
    pactl set-source-volume @DEFAULT_SOURCE@ -5%
}

# Execute accordingly
if [[ "$1" == "--get" ]]; then
	get_volume
elif [[ "$1" == "--inc" ]]; then
	inc_volume
elif [[ "$1" == "--dec" ]]; then
	dec_volume
elif [[ "$1" == "--toggle" ]]; then
	toggle_mute
elif [[ "$1" == "--toggle-mic" ]]; then
	toggle_mic
elif [[ "$1" == "--mic-inc" ]]; then
	inc_mic_volume
elif [[ "$1" == "--mic-dec" ]]; then
	dec_mic_volume
else
	get_volume
fi
