#!/bin/bash

focused_desktop_id=1
desktops_id=2
date_id=3
windows_id=4
flags_id=5

if [[ $1 = "cal" ]];then
    notify-send -h string:bgcolor:#000000 "$(cal) "
    exit
fi

if [[ $1 = "focused_desktop" ]];then
    dunstify -h string:bgcolor:#000000 -r $focused_desktop_id "$(printf "focused_desktop\n$(bspc query -D -d --names)") "
    exit
fi

if [[ $1 = "desktops" ]];then
    dunstify -h string:bgcolor:#000000 -r $desktops_id "$(printf "desktops:\n$(~/dotfiles/bspwm/desktops.sh query | sort)") "
    exit
fi

if [[ $1 = "date" ]];then
    dunstify -h string:bgcolor:#000000 -r $date_id "$(date "+%a %h-%m %d %H:%M:%S") mem: $(free -m | grep Mem: | awk '{print $3}') cpu_temp: $(sensors | tail -n 2 | sed 's/[^0-9.°C]//g')"
    exit
fi

if [[ $1 = "windows" ]];then
    dunstify -h string:bgcolor:#000000 -r $windows_id "$(printf "windows:\n$(~/dotfiles/bspwm/nodes.sh info | sort)\nhidden:\n$(~/dotfiles/bspwm/nodes.sh info hidden | sort)") " 
    exit
fi

if [[ $1 = "volume" ]];then
    volume=$(amixer get Master | tail -1 | awk '{print $5}' | sed 's/[^0-9]//g')
    mute=$(amixer get Master | tail -1 | awk '{print $6}')
    sink_name=$(pactl get-default-sink | sed 's/\./ /g' | awk '{print $NF}')
    if [[ $mute = "[on]" ]];then
        mute=
    fi
    dunstify -t 1000 -h string:bgcolor:#000000 -h string:hlcolor:#6F0000 -h string:frcolor:#000000 -h string:x-dunst-stack-tag:volume -h int:value:"$volume" "$(printf "$sink_name\n$volume $mute")"
    exit
fi

if [[ $1 = "flags" ]];then
    marked=$(~/dotfiles/bspwm/nodes.sh info marked)
    sticky=$(~/dotfiles/bspwm/nodes.sh info sticky)
    locked=$(~/dotfiles/bspwm/nodes.sh info locked)
    
    dunstify -h string:bgcolor:#000000 -r $flags_id "$(printf "marked:\n$marked\nsticky:\n$sticky\nlocked:\n$locked")"
    exit
fi
