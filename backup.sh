#!/bin/bash

cp -rv /etc/portage "$HOME/dotfiles/gentoo"
cp /etc/fstab "$HOME/dotfiles/gentoo"
equery l @world > "$HOME/dotfiles/gentoo/world-portage"
equery l @selected > "$HOME/dotfiles/gentoo/selected-portage"
cp "$HOME/.bashrc" "$HOME/dotfiles/gentoo"
