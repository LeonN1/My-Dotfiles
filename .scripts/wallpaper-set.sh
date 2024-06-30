#!/usr/bin/env sh

# shellcheck disable=SC2016

export LANG='POSIX'
#exec >/dev/null 2>&1

WALLPAPER_ICON="${HOME}/.icons/Gladient/wallpaper.png"

# Set the wallpaper
echo debug
echo ${1}
nitrogen --force-setter=xwindows --set-zoom-fill --save "$1"

# Display notification
dunstify 'Wallpaper' "<span size='larger'><u>Successfully applied!</u></span>" \
         -h string:synchronous:wallpaper-set \
         -a "Wallpaper" \
         -i "$WALLPAPER_ICON" \
         -u low

exit ${?}
