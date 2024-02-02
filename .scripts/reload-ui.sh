#!/usr/bin/env sh

# shellcheck disable=SC3044

SYSTEM_LANG="$LANG"
export LANG='POSIX'
#exec >/dev/null 2>&1

TINT2_DIR="${HOME}/.config/tint2"
DUNST_DIR="${HOME}/.config/dunst"

UI_ICON="${HOME}/.icons/Gladient/restart-ui.png"

killall tint2 dunst -q
killall -9 -q parcellite \
    udiskie \
    nm-applet \
    xfce4-power-manager

# Launch bspwm
bspc wm -r

# Launch sxhkd
pkill -USR1 -x sxhkd

# Launch dunst
LANG="$SYSTEM_LANG" dunst -config "${DUNST_DIR}/Dark-Minimalist.dunstrc" &

# Launch tint2
LANG="$SYSTEM_LANG" tint2 -c "${TINT2_DIR}/Dark-Minimalist.tint2rc" &

# Launch System Tray
parcellite &
udiskie -t &
nm-applet &
xfce4-power-manager &

dunstify 'User Interface' "<span size='larger'><u>${WALLPAPER}</u></span>\nSuccessfully reloaded!" \
         -h string:synchronous:wallpaper-set \
         -a "System" \
         -i "$UI_ICON" \
         -u low

exit ${?}
