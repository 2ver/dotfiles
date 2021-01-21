#!/bin/bash

xrandr --listactivemonitors | grep eDP-1 >/dev/null && xrandr --output eDP-1 --off || xrandr --output eDP-1 --same-as HDMI-1 --mode 1920x1080
