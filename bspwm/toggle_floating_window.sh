#!/bin/bash

if [[ -n $(bspc query -N -n $(bspc query -N -n).tiled) ]];then
    bspc node -f last.local.floating.!hidden.!locked
    exit
fi

bspc node -f next.local.!hidden.window.floating.!locked
