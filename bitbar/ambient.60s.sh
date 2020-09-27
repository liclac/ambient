#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

PATH="/usr/local/bin:$PATH" # to find Homebrew-installed fish

# look for config file in XDG config dirs
while IFS=: read -d: -r p; do
    if [ -z "$config_path" ] && [ -r "$p/bitbar/plugins/ambient.json" ]; then
        config_path="$p/bitbar/plugins/ambient.json"
    fi
done <<<$(printf '%s:\0' "${XDG_CONFIG_HOME:-"${HOME}/.config"}:${XDG_CONFIG_DIRS:-/etc/xdg}")
if [ -z "$config_path" ]; then
    config='{}'
else
    config="$(cat "$config_path")"
fi

WIDGET=$(/usr/local/bin/fish $DIR/../ambient-widgets | tr '\n' ' ')

if [ -z "$WIDGET" ]; then
    if echo "$config" | jq -e 'if has("showIfEmpty") then .showIfEmpty else true end' > /dev/null; then
        echo "🚄"
    fi
else
    echo $WIDGET
    echo "---"
    echo "Go to map|href=https://iceportal.de/Karte_neu"
    echo $(/usr/local/bin/fish $DIR/../ambient | tr '\n' '\r\n')
fi
