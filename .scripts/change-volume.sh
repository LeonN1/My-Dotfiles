#!/usr/bin/env sh

export LANG='POSIX'
exec >/dev/null 2>&1

VOLUME_VALUE='5'        # Volume value to increase/decrease
AUDIO_DEVICE=''         # Device to change volume to. Leave it blank to set the default value

[ -x "$(command -v amixer)" ] || exec dunstify 'Install `alsa-utils`!' -h string:synchronous:install-deps \
                                                                       -a "System Volume" \
                                                                       -u low

# Increase/decrease/toggle mute
case "${1}" in
    +) amixer ${AUDIO_DEVICE:+-D "$AUDIO_DEVICE"} sset Master "${VOLUME_VALUE:-5}%+" on -q
    ;;
    -) amixer ${AUDIO_DEVICE:+-D "$AUDIO_DEVICE"} sset Master "${VOLUME_VALUE:-5}%-" on -q
    ;;
    0) amixer ${AUDIO_DEVICE:+-D "$AUDIO_DEVICE"} sset Master 1+ toggle -q
    ;;
esac

# Get the current volume value
{
    AUDIO_VOLUME="$(amixer ${AUDIO_DEVICE:+-D "$AUDIO_DEVICE"} sget Master)"
    AUDIO_MUTED="${AUDIO_VOLUME##*\ \[on\]}"
    AUDIO_VOLUME="${AUDIO_VOLUME#*\ \[}" \
    AUDIO_VOLUME="${AUDIO_VOLUME%%\%\]\ *}"

# Change the icon that will be displayed depending on the volume 
    if [ "$AUDIO_VOLUME" -eq 0 -o -n "$AUDIO_MUTED" ]; then
        [ -z "$AUDIO_MUTED" ] || MUTED='Muted'
        ICON='notification-audio-volume-muted'
    elif [ "$AUDIO_VOLUME" -lt 30 ]; then
        ICON='notification-audio-volume-low'
    elif [ "$AUDIO_VOLUME" -lt 70 ]; then
        ICON='notification-audio-volume-medium'
    else
        ICON='notification-audio-volume-high'
    fi

# Display a notification when a volume change occur
    exec dunstify ${MUTED:-"$AUDIO_VOLUME" -h "int:value:${AUDIO_VOLUME}"} \
                                           -a joyful_desktop \
                                           -h string:synchronous:audio-volume \
                                           -i "$ICON" \
                                           -t 1000
} &

exit ${?}
