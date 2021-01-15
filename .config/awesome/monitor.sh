#!/bin/bash

xrandr --listactivemonitors | grep eDP1 >/dev/null && xrandr --output eDP1 --off || xrandr --output eDP1 --left-of HDMI1 --mode 1920x1080
