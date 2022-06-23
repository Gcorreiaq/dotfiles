#!/bin/bash

marked_nodes=$(bspc query -N -n .marked)

if [[ -z $marked_nodes ]];then
    exit
fi

if [[ $1 = "move" ]];then
    if [[ $2 = "desktop" ]];then
        for marked_node in $marked_nodes;do
            bspc node "$marked_node" -d focused
            bspc node "$marked_node" -g marked
        done
        exit
    fi
    
    if [[ $2 = "tabbed" ]];then
        for marked_node in $marked_nodes;do
            xdotool windowreparent "$marked_node" "$(bspc query -N -n)"
            bspc node "$marked_node" -g marked
        done
        exit
    fi
fi


