#!/bin/bash

bspc node -c

if [[ $(bspc query -N -n .floating) ]];then
    ~/dotfiles/bspwm/toggle_floating_window.sh
fi

