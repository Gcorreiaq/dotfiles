#!/bin/bash

if [[ $1 = "all" ]];then
    for p in {windows,flags};do
        ~/dotfiles/bspwm/notification_info.sh $p
    done
    exit
fi

if [[ $1 = "date" ]];then
    dunstify -h "string:bgcolor:#000000" -h "string:x-dunst-stack-tag:date" \
    "$(date "+%d/%m %a/%h %H:%M:%S") mem: $(free -h | grep Mem: | awk '{print $3}')" \
    "$(printf "$(cal)")" \
    exit
fi

if [[ $1 = "windows" ]];then
    dunstify \
        -h "string:bgcolor:#000000" \
        -h "string:x-dunst-stack-tag:windows" \
        "$(printf "windows:\n$(~/dotfiles/bspwm/nodes.sh info | sort)\
        \nhidden:\n$(~/dotfiles/bspwm/nodes.sh info hidden | sort)") " 
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

if [[ $1 = "song" ]];then
    mocp -i
    err=$(echo $?)

    if [[ $err -eq 2 ]];then
        exit
    fi

    music=$(mocp -i | grep ^Title | sed 's/Title: //')
    total=$(mocp -i | grep TotalTime: | sed 's/TotalTime: //')
    current=$(mocp -i | grep CurrentTime: | sed 's/CurrentTime: //')
    
    if [[ $2 = "temp" ]];then
        c="dunstify -t 2000"
    else
        c="dunstify"
    fi
    $c -h string:bgcolor:#000000 -h string:x-dunst-stack-tag:song "$(printf "$music\n$current/$total")"

    exit
fi

if [[ $1 = "flags" ]];then
    marked=$(~/dotfiles/bspwm/nodes.sh info marked)
    sticky=$(~/dotfiles/bspwm/nodes.sh info sticky)
    locked=$(~/dotfiles/bspwm/nodes.sh info locked)
    
    dunstify -h string:bgcolor:#000000 -h string:x-dunst-stack-tag:flags "$(printf "marked:\n$marked\nsticky:\n$sticky\nlocked:\n$locked")"
    exit
fi
