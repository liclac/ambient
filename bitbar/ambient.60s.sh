#!/bin/bash

WIDGET=$(/usr/local/bin/fish ~/dev/ambient/ambient-widgets | tr '\n' ' ')

if [ -z "$WIDGET" ]; then
	echo "🚄"
else 
	echo $WIDGET
fi