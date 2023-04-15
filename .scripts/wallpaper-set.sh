#!/usr/bin/env sh

# shellcheck disable=SC2016

export LANG='POSIX'
exec >/dev/null 2>&1

WALLPAPERS_DIR="${HOME}/.wallpapers"

# List all images in the ${HOME}/.wallpapers folder
WALLPAPER="$(for LS in "$WALLPAPERS_DIR"/*.*; do
            [ ! -f "$LS" ] || echo "${LS##*/}"
        done \
        | rofi -theme-str '@import "config-wallpaper.rasi"' \
            -no-show-icons \
            -no-lazy-grab \
            -no-plugins \
            -p "󰉏" \
            -dmenu )"

# Check if one image was selected
[ -n "$WALLPAPER" ] || exit ${?}

# Set the wallpaper
nitrogen --force-setter=xwindows --set-zoom-fill --save "${WALLPAPERS_DIR}/${WALLPAPER}"

# Display notification
dunstify '' "<span size='larger'><u>${WALLPAPER}</u></span>\nSuccessfully applied!" \
         -h string:synchronous:wallpaper-set \
         -a "Wallpaper" \
         -i "$WALLPAPER_ICON" \
         -u low

exit ${?}
