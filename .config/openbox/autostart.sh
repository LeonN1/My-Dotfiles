#!/usr/bin/env sh

# shellcheck disable=SC3044,SC2091,SC2086

exec >/dev/null 2>&1

WALLPAPERS_DIR="${HOME}/.wallpapers"
WALLPAPER_SAVED="${HOME}/.config/nitrogen/bg-saved.cfg"
WALLPAPER_AUX=$(awk '/file/' "$WALLPAPER_SAVED")
WALLPAPER=$(basename $WALLPAPER_AUX)

nitrogen --force-setter=xwindows --set-zoom-fill --save "${WALLPAPERS_DIR}/${WALLPAPER}"


