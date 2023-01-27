#!/bin/bash

for win in $(bspc query -N -n .hidden.local.window)
do
	window+="$win - $(xprop -id $win | grep ^WM_NAME | awk '{for(i=3;i<=NF;++i) printf "%s ",$i;print ""}' | sed 's/"//g')\n"
done

selected=$(echo -e "$window" | dmenu -sb "#000000" -sf red -sb "#3f0000" -l 15 -p hidden)

[[ -z $selected ]] && exit;

bspc node $(echo $selected | awk '{print $1}') --flag hidden=off -f

