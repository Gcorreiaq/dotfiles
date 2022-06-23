#!/bin/bash

windows=$(bspc query -N -n .window.!hidden)
parent=$(bspc query -D -d --names | awk '{print $1}')
focused_desktop=$(bspc query -D -d)

if [[ $1 = "add" ]];then
    parent=$(echo $parent | sed 's/-//')
    if [[ -n $(grep "$(bspc query -N -n)" ~/windows) ]];then
        ~/dotfiles/bspwm/nodes.sh remove
        exit
    fi
    group=$(dmenu -b -p group_name | sed 's/[^a-z]//g')
    if [[ -z $group ]];then
        exit
    fi
    add=$parent-$group-$(bspc query -N -n)
    echo "$add" >> ~/windows
    exit
fi

if [[ $1 = "remove" ]];then
    group=$(grep "$(bspc query -N -n)" ~/windows | sed 's/-/ /g' | awk '{print $2}' | dmenu -b -p group_remove)
    if [[ -z $group ]];then
        exit
    fi

    cat ~/windows | sed "/$group-$(bspc query -N -n)/d" > ~/windows
    exit
fi

if [[ $1 = "focus" ]];then
    group=$(cat ~/windows | sed 's/-/ /g' | awk '{print $2}' | sort -u | dmenu -b -p focus_group_node)
    if [[ -z $group ]];then
        exit
    fi
    next=$(grep "\-$group\-" ~/windows | sed 's/-/ /g' | awk 'NR==1{print $3}')
    bspc node "$next" -d "$(bspc query -D -d)"
    if [[ -z $(bspc query -D -d) ]];then
        bspc node "$next" -g hidden=off
        bspc node -f "$next"
        exit
    fi
    bspc node -i
    bspc node "$next" -n 'any.leaf.!window'
    bspc node "$next" -g hidden=off
    bspc node -f "$next"
    exit
fi

if [[ $1 = "toggle" ]];then
    group=$(grep "$(bspc query -N -n)" ~/windows | sed 's/-/ /g' | awk '{print $2}')
    if [[ -z $group ]];then
        exit
    fi
    parent=$(echo "$parent" | sed 's/-//')
    windows=$(grep "$parent\-$group\-" ~/windows | sed 's/-/ /g' | awk '{print $3}')
    mod=$(echo "$windows" | awk '{print NR}' | sed '$!d')
    if [[ $mod -eq 1 ]];then
        exit
    fi
    current=$(echo "$windows" | awk '{print NR, $1}' | grep "$(bspc query -N -n)" | awk '{print $1}')
    next=$(echo "$windows" | awk "NR==$(expr "$current" % "$mod" + 1){print}")
    echo "mod:$mod current:$current next:$next" > test
    bspc node "$next" -d "$(bspc query -D -d)"
    bspc node -s "$next"
    bspc node "$(bspc query -N -n)" -g hidden=on
    bspc node "$next" -g hidden=off
    bspc node -f "$next"
    exit
fi

if [[ $1 = "info" ]];then
    nodes=$windows

    if [[ $2 = "marked" ]];then
        nodes=$(bspc query -N -n .marked)
    fi
    
    if [[ $2 = "sticky" ]];then
        nodes=$(bspc query -N -n .sticky)
    fi

    if [[ $2 = "locked" ]];then
        nodes=$(bspc query -N -n .locked)
    fi

    if [[ $2 = "hidden" ]];then
        nodes=$(bspc query -N -n .window.hidden)
    fi

    for node in $nodes;do
        info=$(xprop -id "$node" WM_NAME | sed 's/.*=//' | sed 's/\"//g' 2>/dev/null)
        desktop=$(bspc query -D -n $node --names)

        if [[ $focused_desktop = $(bspc query -D -n "$node") ]];then
            printf "* %10s | %s\n" "$desktop" "$info"
        else
            printf "  %10s | %s\n" "$desktop" "$info"
        fi
    done

    exit
fi

