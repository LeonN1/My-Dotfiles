#!/bin/sh

result=$(xrandr --query | grep "HDMI-1-0 connected")

sleep 1

# Check if the variable is not empty
if [ -n "$result" ]; then
    ~/.screenlayout/main.sh
    bspc monitor "%eDP-1" -d VI VII VIII IX X
    bspc monitor "%HDMI-1-0" -d I II III IV V
else
    ~/.screenlayout/laptop.sh
    bspc monitor "%eDP-1" -d I II III IV V VI VII VIII IX X
fi
