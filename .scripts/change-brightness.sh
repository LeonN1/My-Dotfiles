#!/usr/bin/env sh

export LANG='POSIX'
exec >/dev/null 2>&1

BRIGHTNESS_VALUE=5          # Brightness value to increase/decrease
BRIGHTNESS_DEVICE=''        # Device to change brightness to. Leave it blank to set the default value

# Check if 'brighnessctl' is installed, if not, display a notification.
[ -x "$(command -v brightnessctl)" ] || exec dunstify 'Install `brightnessctl`!' -h string:synchronous:install-deps \
                                                                                 -a "System Brightness" \
                                                                                 -u low

case "${1}" in
    +) brightnessctl ${BRIGHTNESS_DEVICE:+-d "$BRIGHTNESS_DEVICE"} set "${BRIGHTNESS_VALUE:-5}%+" -q
    ;;
    -) brightnessctl ${BRIGHTNESS_DEVICE:+-d "$BRIGHTNESS_DEVICE"} set "${BRIGHTNESS_VALUE:-5}%-" -q
    ;;
esac

# Get the current brightness value
{
    BRIGHTNESS="$(brightnessctl ${BRIGHTNESS_DEVICE:+-d "$BRIGHTNESS_DEVICE"} info)" \
    BRIGHTNESS="${BRIGHTNESS#*\ \(}" \
    BRIGHTNESS="${BRIGHTNESS%%\%\)*}"

# Change the icon that will be displayed depending on the brightness 
    if [ "$BRIGHTNESS" -eq 0 ]; then
        ICON='notification-display-brightness-off'
    elif [ "$BRIGHTNESS" -lt 10 ]; then
        ICON='notification-display-brightness-low'
    elif [ "$BRIGHTNESS" -lt 70 ]; then
        ICON='notification-display-brightness-medium'
    elif [ "$BRIGHTNESS" -lt 100 ]; then
        ICON='notification-display-brightness-high'
    else
        ICON='notification-display-brightness-full'
    fi

# Display a notification when a brightness change occur
    exec dunstify "$BRIGHTNESS" -h "int:value:${BRIGHTNESS}" \
                                -a joyful_desktop \
                                -h string:synchronous:display-brightness \
                                -i "$ICON" \
                                -t 1000
} &

exit ${?}
