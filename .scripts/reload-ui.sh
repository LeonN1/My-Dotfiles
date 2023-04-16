#!/usr/bin/env sh

# shellcheck disable=SC3044

SYSTEM_LANG="$LANG"
export LANG='POSIX'
#exec >/dev/null 2>&1

TINT2_DIR="${HOME}/.config/tint2"
DUNST_DIR="${HOME}/.config/dunst"

killall tint2 dunst -q

openbox --reconfigure 

# Launch dunst
LANG="$SYSTEM_LANG" dunst -config "${HOME}/.config/dusnt/Dark-Minimalist.dunstrc" &

# Launch tint2
LANG="$SYSTEM_LANG" tint2 -c "${TINT2_DIR}/Dark-Minimalist.tint2rc"

exit ${?}
