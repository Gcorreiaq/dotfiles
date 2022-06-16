#!/bin/sh

sleep 10s

while bspc subscribe -c 1 node_remove; do
    windows=$(cat ~/windows | sed 's/-/ /g' | awk '{print $3}')
    for window in $windows; do
        status=$(bspc query -N -n "$window")
        if [[ -z $status ]];then
            replace=$(cat ~/windows | sed "/$window/d")
            echo "$replace" > ~/windows
        fi
    done
done
