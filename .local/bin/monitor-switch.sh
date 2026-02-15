#!/bin/sh
if swaymsg -t get_outputs | grep -q '"name": "DP-1"'; then
    swaymsg output eDP-1 disable
    swaymsg output DP-1 enable
else
    swaymsg output eDP-1 enable
fi

