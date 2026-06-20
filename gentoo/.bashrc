#!/bin/bash

export PATH=$PATH:/home/g/.local/bin
#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=ibus
#export QT_IM_MODULE=ibus
#ibus-daemon -drx
(cat ~/.config/wpg/sequences &)

mkdir -p /tmp/telegram
