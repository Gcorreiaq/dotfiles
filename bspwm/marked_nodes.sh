#!/bin/bash

marked_nodes=$(bspc query -N -n .marked)

is_tabbed() {
    ~/dotfiles/bspwm/nodes.sh
    if $?;then
        return 1
    fi

    return 0
}

if [[ $1 = "move" ]];then
    if [[ $2 = "desktop" ]];then
        for marked_node in $marked_nodes;do
            bspc node "$marked_node" -d focused
            bspc node "$marked_node" -g marked
        done
        exit
    fi
    
    if [[ $2 = "tabbed" ]];then
        focused=$(bspc query -N -n)
        tabbed=$(~/dotfiles/bspwm/nodes.sh class tabbed)

        if [[ $? = 0 ]];then
            tabbed=$(tabbed -d)
        fi

        if [[ -z $marked_nodes ]];then
            xdotool windowreparent "$focused" "$tabbed"
            exit
        fi

        for marked_node in $marked_nodes;do
            xdotool windowreparent "$marked_node" "$tabbed"
            bspc node "$marked_node" -g marked
        done

        exit
    fi
fi

