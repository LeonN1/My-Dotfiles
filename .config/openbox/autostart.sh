#!/usr/bin/env sh

# shellcheck disable=SC3044,SC2091,SC2086

SYSTEM_LANG="$LANG"
export LANG='POSIX'
exec >/dev/null 2>&1

# This file is executed at the beggining of the X session, when Openbox loads.
# You can use this file to initialize programs with custom configurtations.

# Set wallpaper

WALLPAPERS_DIR="${HOME}/.wallpapers"
WALLPAPER_AUX=$(awk '/file/' "${HOME}/.config/nitrogen/bg-saved.cfg")
WALLPAPER=$(basename $WALLPAPER_AUX)

nitrogen --force-setter=xwindows --set-zoom-fill --save "${WALLPAPERS_DIR}/${WALLPAPER}"

# Set the tint2 config file 

tint2 -c "${HOME}/.config/tint2/Dark-Minimalist.tint2rc" &

# Set the dusnt config file

LANG="$SYSTEM_LANG" dunst -config "${HOME}/.config/dunst/Dark-Minimalist.dunstrc" &

# System Tray 
parcellite &
udiskie -t &
nm-applet &
xfce4-power-manager &

