#!/bin/bash

focused_desktop_id=1
desktops_id=2
date_id=3
windows_id=4

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
    dunstify -h string:bgcolor:#000000 -r $date_id "$(date "+%a %h-%m %d %H:%M:%S") mem: $(free -m | grep Mem: | awk '{print $3}') "
    exit
fi

if [[ $1 = "windows" ]];then
    dunstify -h string:bgcolor:#000000 -r $windows_id "$(printf "windows:\n$(~/dotfiles/bspwm/nodes.sh | sort)\nhidden:\n$(~/dotfiles/bspwm/nodes.sh hidden | sort)") " 
    exit
fi
