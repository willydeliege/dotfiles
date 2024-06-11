#!/bin/bash

SERVICE=hypridle

if pgrep -x "$SERVICE" >/dev/null; then
	killall $SERVICE
	notify-send "$SERVICE stopped"
else
	$SERVICE &
	notify-send "$SERVICE started"
fi
