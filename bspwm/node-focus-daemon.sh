#!/bin/bash

above() {
    for w in $1;do
        bspc node "$w" -l above
    done
}

below() {
    for w in $1;do
        bspc node "$w" -l below
    done
}
normal() {
    for w in $1;do
        bspc node "$w" -l normal
    done
}

while bspc subscribe -c 1 node_focus; do
    floating=$(bspc query -N -n '.local.window.!hidden.!sticky.floating')
    tiled=$(bspc query -N -n '.local.window.!hidden.!sticky.!floating')

    if [[ $(bspc query -N -n 'focused.!floating') ]];then
        above "$tiled"
        normal "$floating"
    else
        below "$floating"
        bspc node -l above
        normal "$tiled"
    fi 
done
