#!/bin/bash

while bspc subscribe -c 1 node_focus; do
    if [[ -n $(bspc query -N -n "$(bspc query -N -n last).sticky") ]];then
        bspc node last -l above
    else
        bspc node last -l normal
    fi
    bspc node focused -l above
done
