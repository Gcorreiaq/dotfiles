#!/bin/bash

if [[ $1 = "gap" ]];then
    if [[ $2 = "dec" ]];then
        num=$(bspc config window_gap)
        let "num=num-2"
        if [[ $num -lt 0 ]];then
            num=0
        fi
        bspc config window_gap $num
    fi
    if [[ $2 = "inc" ]];then
        num=$(bspc config window_gap)
        let "num=num+2"
        bspc config window_gap $num
    fi
    exit
fi
if [[ $1 = "single" ]];then
	if [[ $(bspc config -n $(bspc query -N -n) border_width) -eq 1 ]]; then
		bspc config -n $(bspc query -N -n) border_width 0
	else
		bspc config -n $(bspc query -N -n) border_width 1
	fi
	exit
fi

if [[ $(bspc config border_width) -eq 1 ]]; then
	bspc config border_width 0
else
	bspc config border_width 1
fi
