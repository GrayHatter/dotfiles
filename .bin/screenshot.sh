#!/usr/bin/env sh


grim -g "`slurp`" /tmp/screenshot.png


PREV=`wl-paste`
wl-copy -of "/tmp/screenshot.png"
wl-copy "${PREV}"
