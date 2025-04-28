#!/bin/bash

#---> Ensure privileges <---#
if [ "$EUID" -ne 0 ]; then
  exec sudo "$0" "$@"
fi

#---> Check if YAY is available and install it if not <---# 
if ! command -v yay &> /dev/null; then
  echo "yay not found. Installing..."

  pacman -S --noconfirm --needed git base-devel

  TMPDIR=$(mktemp -d)
  git clone https://aur.archlinux.org/yay.git "$TMPDIR/yay"

  cd "$TMPDIR/yay"
  makepkg -si --noconfirm

  cd /
  rm -rf "$TMPDIR"

  echo "yay installed successfully."
else
  echo "yay it's already installed."
fi