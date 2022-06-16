#!/bin/bash

parent=$(bspc query -D -d --names | awk '{print $1}')
wname=$(bspc query -D -d --names | awk '{print $2}')
if [[ $1 = "add" ]];then
    rofi=$(echo $RANDOM)
    parent=$(bspc query -D -d --names | awk '{print $1}' | sed 's/-//')
    bspc monitor -a "$parent $rofi"
    bspc desktop -f "$parent $rofi"
    exit
fi

if [[ $1 = "group" ]];then
    if [[ $2 = "focus" ]];then
        rofi=$(bspc query -D --names | grep _-.*$ | sed 's/^.*_-//' | sort -u | rofi -dmenu -p focus-group)
        next=$(bspc query -D --names | grep "_-$rofi$" | awk 'NR==1 {print}')
        bspc desktop -f "$next"
        exit
    fi
    if [[ $2 = "toggle" ]];then
        if [[ -n $(bspc query -D -d --names | grep _-) ]];then
            group=$(bspc query -D -d --names | sed 's/^.*_-//')
            rename=$(bspc query -D -d --names | sed "s/_-.*$code$//")
            bspc desktop -n "$rename"
            exit
        fi
        rofi=$(rofi -dmenu -p group)
        if [[ -z $rofi ]];then
            exit
        fi
        rename=$(bspc query -D -d --names)$(echo _-$rofi)
        bspc desktop -n "$rename"
        exit
    fi
    if [[ -z $(bspc query -D -d --names | grep _-) ]];then
        exit
    fi
    group=$(bspc query -D -d --names | sed 's/^.*_-//')
    mod=$(bspc query -D --names | grep "_-$group$" | awk '{print NR}' | sed '$!d')
    current=$(bspc query -D --names | grep "_-$group$" | awk '{print NR, $2}' | grep "$wname"$ | awk '{print $1}')
    next=$(bspc query -D --names | grep "_-$group$" | awk "NR==$(expr "$current" % "$mod" + 1){print}")
    bspc desktop -f "$next"
    exit
fi

if [[ $1 = "toggle" ]];then
    if [[ -n $(bspc query -D -d --names | grep ^.-) ]];then
        parent=$(bspc query -D -d --names | awk '{print $1}' | sed 's/-//')
        next=$(bspc query -D --names | grep "$parent "| awk 'NR==1 {print}')
        bspc desktop -f "$next"
        exit
    fi
    if [[ -z $(bspc query -D -d --names | grep \ ) ]];then
        parent=$(bspc query -D -d --names | awk '{print $1}' | sed 's/-//')
        next=$(bspc query -D -d last --names)
        if [[ -n $(echo $next | grep "$parent[ -]") ]];then
            bspc desktop -f "$next"
            exit
        fi
        next=$(bspc query -D --names | grep "$parent "| awk 'NR==1 {print}')
        bspc desktop -f "$next"
        exit
    fi
    mod=$(bspc query -D --names | grep "$parent "| awk '{print NR}' | sed '$!d')
    current=$(bspc query -D --names | grep "$parent "| awk '{print NR, $2}' | grep "$wname"$ | awk '{print $1}')

    if [[ $2 = "previous" ]];then
        case $current in
            $mod)
                expr=$(expr $current - 1);;
            1)
                expr=$(echo $mod);;
            *)
                expr=$(expr "$current" % "$mod" - 1);;
        esac
        next=$(bspc query -D --names | grep "$parent "| awk "NR==$(echo $expr){print}")
    else
        next=$(bspc query -D --names | grep "$parent "| awk "NR==$(expr "$current" % "$mod" + 1){print}")
    fi

    bspc desktop -f "$next"
    exit
fi

if [[ $1 = "focus" ]];then
    if [[ $2 = "parent" ]];then
        parent=$(bspc query -D -d --names | awk '{print $1}' | sed 's/-//')
        bspc desktop -f "$parent"
        exit
    fi
    if [[ -n $2 ]];then
        parent=$(echo $2 | sed 's/-//')
        next=$(bspc query -D --names | grep "$parent "| awk 'NR==1 {print}')
        bspc desktop -f "$next"
        exit
    fi

    parent=$(bspc query -D -d --names | awk '{print $1}' | sed 's/-//')
    rofi=$(bspc query -D --names | grep -v _- | grep "$parent[ -]"|awk '{print $2}' | rofi -dmenu -p focus)
    if [[ -z $rofi ]];then
        exit
    fi
    next=$(bspc query -D --names | grep ^"$parent[ -]" | grep $rofi$)
    bspc desktop -f "$next"
    exit
fi

if [[ $1 = "send" ]];then
    parent=$(bspc query -D -d --names | awk '{print $1}' | sed 's/-//')
    rofi=$(bspc query -D --names | grep "$parent[ -]"|awk '{print $2}' | rofi -dmenu -p send)
    if [[ -z $rofi ]];then
        exit
    fi
    next=$(bspc query -D --names | grep ^"$parent[ -]" | grep $rofi$)
    bspc node -d "$next"
    exit
fi

if [[ $1 = "rename" ]];then
    rofi=$(rofi -dmenu -p rename)
    if [[ -z $rofi ]];then
        exit
    fi
    if [[ -n $(bspc query -D -d --names | grep _-) ]];then
        name="$rofi$(bspc query -D -d --names | sed 's/^.*_-/_-/')"
    else
        name="$rofi"
    fi
    bspc desktop -n "$parent $name"
    exit
fi

if [[ $1 = "query" ]];then
    desktops=$(bspc query -D)
    focused_desktop=$(bspc query -D -d)
    for desktop in $desktops; do
        if [[ "$desktop" = "$focused_desktop" ]];then
            printf "* %s\n" "$(bspc query -D -d $desktop --names)"
        else
            printf "  %s\n" "$(bspc query -D -d $desktop --names)"
        fi
    done
    exit
fi
if [[ $1 = "hide" ]];then
    if [[ -n $(bspc query -D -d --names | grep ^.-) ]];then
        bspc desktop -n "$(bspc query -D -d --names | sed 's/-//')"
        exit
    fi
    bspc desktop -n "$(bspc query -D -d --names | sed 's/\ /-\ /')"
    exit
fi
parent=$(bspc query -D -d --names | awk '{print $1}' | sed 's/-//')
rofi=$(bspc query -D --names | grep "$parent[ -]"| awk '{print $2}' | rofi -dmenu -p del)

if [[ -z $rofi ]];then
    exit
fi

next=$(bspc query -D --names | grep ^"$parent[ -]" | grep $rofi$)
bspc desktop "$next" -r
