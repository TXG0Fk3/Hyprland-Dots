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

#---> Install packages <---#
Hyprland=(hyprland-git waybar-git rofi-wayland swaync-git hyprshot-git hyprpicker-git hyprlock-git swww catppuccin-cursors-mocha papirus-icon-theme)
Deps=(xdg-desktop-portal-hyprland-git xdg-desktop-portal-gtk zenity polkit-gnome ttf-jetbrains-mono ttf-jetbrains-mono-nerd noto-fonts noto-fonts-cjk noto-fonts-emoji pavucontrol qt5ct qt6ct nwg-look)
Other=(superfile-bin btop-git kitty loupe mpv zsh)

echo "Installing Packages..."

yay -S --noconfirm --needed --removemake $Hyprland $Deps $Other

#---> Copy DotFiles <---#
REPO_DIR="$(dirname "$(readlink -f "$0")")"

cp -aRf "$REPO_DIR/.config" ~/
cp -aRf "$REPO_DIR/.local" ~/