#!/bin/bash

if [[ $1 = "cal" ]];then
    notify-send -h string:bgcolor:#000000 "$(cal) "
    exit
fi

if [[ $1 = "focused_desktop" ]];then
    notify-send -h string:bgcolor:#000000 "$(printf "focused_desktop\n$(bspc query -D -d --names)") "
    exit
fi

if [[ $1 = "desktops" ]];then
    notify-send -h string:bgcolor:#000000 "$(printf "desktops:\n$(~/dotfiles/bspwm/desktops.sh query | sort)") "
    exit
fi

if [[ $1 = "date" ]];then
    notify-send -h string:bgcolor:#000000 "$(date "+%a %h-%m %d %H:%M:%S") mem: $(free -m | grep Mem: | awk '{print $3}') "
    exit
fi

if [[ $1 = "windows" ]];then
    notify-send -h string:bgcolor:#000000 "$(printf "windows:\n$(~/dotfiles/bspwm/nodes.sh | sort)\nhidden:\n$(~/dotfiles/bspwm/nodes.sh hidden | sort)") " 
    exit
fi
