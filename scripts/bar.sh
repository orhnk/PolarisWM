#!/bin/dash

# ^c$var^ = fg color
# ^b$var^ = bg color

interval=0

# load colors
. ~/.config/PolarisWM/scripts/bar_themes/catppuccin

cpu() {
  cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)

  printf "^c$black^ ^b$green^ CPU"
  printf "^c$white^ ^b$grey^ $cpu_val"
}

pkg_updates() {
  #updates=$(doas xbps-install -un | wc -l) # void
  updates=$(checkupdates 2>/dev/null | wc -l) # arch
  # updates=$(aptitude search '~U' | wc -l)  # apt (ubuntu,debian etc)

  if [ -z "$updates" ]; then
    printf "  ^c$green^    Fully Updated"
  else
    printf "  ^c$green^    $updates"" updates"
  fi
}

mem() {
  printf "^c$blue^^b$black^  "
  printf "^c$blue^ $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
}



clock() {
	printf "^c$black^ ^b$darkblue^ 󱑆 "
	printf "^c$black^^b$blue^ $(date '+%I:%M %p ')"
}


volume() {

  vol_val=$(pamixer --get-volume)
  printf "^c$blue^^b$black^ Volume:"
  printf "^c$blue$^ $vol_val"

}

while true; do

  [ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] && updates=$(pkg_updates)
  interval=$((interval + 1))

  sleep 1 && xsetroot -name " $(volume) $(cpu) $(mem) $(clock)"
done

