#!/bin/bash

# Wallpaper Script for SWWW && Hyprlock using Zenity

wpppath=$(zenity --file-selection --title="Select a Wallpaper" --file-filter="Pictures | *.png *.jpg *.jpeg *.gif")
wppdest="$HOME/.config/background"

if [ -n "$wpppath" ]; then
    cp "$wpppath" "$wppdest"
    swww img "$wppdest"
fi