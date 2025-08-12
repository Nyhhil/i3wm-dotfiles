#!/bin/sh

# System wallpaper
feh --bg-scale ~/Downloads/07.jpg

# Disks
udiskie -t &

# Battery icon
cbatticon &

# Picom
picom -f &

