#!/bin/bash

WID=$(bspc query -N -n)
WX=$(wattr x $WID)
WY=$(wattr y $WID)

if [[ -z $(bspc query -N -n focused.floating) ]];then
    exit
fi

wtp $WX $WY 720 450 $WID
