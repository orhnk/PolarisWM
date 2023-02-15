#!/bin/sh

xrdb merge ~/.Xresources 
feh --bg-fill /home/polaris/Documents/wallpaper.jpg &
picom --experimental-backend & 
xrandr --output DP-0 --right-of DP-2 --mode 2560x1440 --rate 120 &
xrandr --output DP-2 --primary --left-of DP-0 --mode 2560x1440 --rate 120 &
~/.config/PolarisWM/scripts/bar.sh &
while type dwm >/dev/null; do dwm && continue || break; done
