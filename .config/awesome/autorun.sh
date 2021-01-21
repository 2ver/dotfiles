#!/usr/bin/env bash

function run {
	if ! pgrep -f $1;
	then
		$@&
	fi
}

run xrandr --output HDMI-1 --primary --rate 119.98
run xrandr --output EDP-1 --same-as HDMI-1
xinput --set-prop "Logitech M570" "libinput Accel Speed" -1
xinput --set-prop "TPPS/2 Elan TrackPoint" "Coordinate Transformation Matrix" 0.3 0 0 0 0.3 0 0 0 1
xset mouse 0 0
run picom -b
