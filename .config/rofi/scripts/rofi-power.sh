#!/usr/bin/env sh

SYSTEM_LANG="$LANG"
export LANG='POSIX'
exec >/dev/null 2>&1

SYSTEM_LANG="$SYSTEM_LANG" \
exec rofi -theme-str '@import "config-power.rasi"' \
          -modi "power:${0%/*}/modi-session.sh" \
          -no-show-icons \
          -no-lazy-grab \
          -no-plugins \
          -show "power"
exit ${?}
