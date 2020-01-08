#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"


WIDGET=$(/usr/local/bin/fish $DIR/../ambient-widgets | tr '\n' ' ')

if [ -z "$WIDGET" ]; then
	echo "🚄"
else 
	echo $WIDGET
	echo "---"
	echo $(/usr/local/bin/fish $DIR/../ambient | tr '\n' '\r\n')
fi
