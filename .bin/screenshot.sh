#!/usr/bin/env sh


grim -g "`slurp`" /tmp/screenshot.png


if [ $# -gt "0" ]; then
	PREV=`wl-paste`
	wl-copy -of "/tmp/screenshot.png"
	wl-copy "${PREV}"
fi
