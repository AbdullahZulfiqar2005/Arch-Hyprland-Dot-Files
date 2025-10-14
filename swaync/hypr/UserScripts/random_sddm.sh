#!/bin/bash
# Random wallpaper selector for SDDM

wallpapers_file="$HOME/.config/hypr/UserScripts/wall2.txt"
wallpapers_dir="$HOME/Pictures/wallpapers"
sddm_wallpaper_dir="/usr/share/sddm/themes/simple_sddm_2/Backgrounds"

# Pick a random wallpaper
random_name=$(shuf -n1 "$wallpapers_file")
random_wall="$wallpapers_dir/$random_name"

# Copy to SDDM theme directory with root permissions
sudo cp "$random_wall" "$sddm_wallpaper_dir/default"
sudo chown root:root "$sddm_wallpaper_dir/default"
sudo chmod 644 "$sddm_wallpaper_dir/default"

echo "SDDM wallpaper updated to: $random_name"
