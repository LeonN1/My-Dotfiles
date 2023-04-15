#!/usr/bin/env sh

# Desc:   User's preferred applications launcher.
# Author: Harry Kurn <alternate-se7en@pm.me>
# URL:    https://github.com/owl4ce/dotfiles/tree/ng/.scripts/launch-apps.sh

# SPDX-License-Identifier: ISC

SYSTEM_LANG="$LANG"
export LANG='POSIX'
exec 2>/dev/null

APPS_FILE="${HOME}/.scripts/apps"                  

siq()
{
    while IFS='"' read -r KEY VAL _; do
        case "${KEY%%\ *}" in
            "${1}") echo "$VAL"
                    break
            ;;
        esac
    done <"${2}"
}

hold()
{
    APP="$(siq "${1}" "$APPS_FILE")"

    [ -n "$APP" ] || exit ${?}
}

case "${1}" in
    -g) hold "${2}"

        # If the value of $APP contains double-quotes, escape it
        # to preserve double-quotes when displayed to output.
        if [ -z "${APP##*\"*\"*}" ]; then
            ZAPP="$(sed -e '1s|"|\\"|g' <<- APP
						${APP}
					APP
                  )"
        fi

        eval "echo \"${ZAPP:-${APP}}\""
    ;;
    * ) hold "${1}"

        eval "LANG=\"$SYSTEM_LANG\" exec ${APP} \${*#\"${1}\"} >&2 &"
    ;;
esac

exit ${?}
