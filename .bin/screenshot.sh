#!/usr/bin/env sh
SSHMOUNT="/home/grayhatter/i"
SITE="https://gr.ht/i"


grim -g "`slurp && sleep 0.8`" /tmp/screenshot.png

if [ $# -gt "0" ]; then
	if mount | grep "$SSHMOUNT"; then
		echo "true"
		cp /tmp/screenshot.png "${SSHMOUNT}/${1}.png"
		wl-copy -of "${SITE}/${1}.png"
	else 
		PREV=`wl-paste`
		wl-copy -of "/tmp/screenshot.png"
		wl-copy "${PREV}"
	fi
fi
