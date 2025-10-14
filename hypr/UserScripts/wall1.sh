#!/bin/bash

# File containing your wallpaper list
WALLPAPER_LIST="$HOME/.config/hypr/UserScripts/wall1.txt"

# File to keep track of already used wallpapers
USED_FILE="$HOME/.config/hypr/UserScripts/.used_wallpapers.txt"

# Directory where wallpapers are stored
WALLPAPER_DIR="$HOME/Pictures/wallpapers"

# File to store current wallpaper path
# CURRENT_FILE="$HOME/.config/hypr/wallpaper_effects/.wallpaper_current"

# If used file doesn't exist, create it
if [ ! -f "$USED_FILE" ]; then
    touch "$USED_FILE"
fi

# Count total wallpapers and used ones
TOTAL=$(wc -l < "$WALLPAPER_LIST")
USED=$(wc -l < "$USED_FILE")

# Reset if all are used
if [ "$TOTAL" -eq "$USED" ]; then
    echo "All wallpapers used. Resetting..."
    > "$USED_FILE"
fi

# Pick a random wallpaper not in used list
WALLPAPER=$(grep -vxFf "$USED_FILE" "$WALLPAPER_LIST" | shuf -n 1)

# Apply wallpaper using swww
swww img "$WALLPAPER_DIR/$WALLPAPER" --transition-type any --transition-fps 165 --transition-duration 1.0
$HOME/.config/hypr/UserScripts/random_sddm.sh

# Save current wallpaper path (absolute path)
# echo "$WALLPAPER_DIR/$WALLPAPER" > "$CURRENT_FILE"
cp "$WALLPAPER_DIR/$WALLPAPER" "$HOME/.config/hypr/wallpaper_effects/.wallpaper_current"

# Save it to used list
echo "$WALLPAPER" >> "$USED_FILE"

#Add it to rofi for qs
cp "$WALLPAPER_DIR/$WALLPAPER" "/home/abdullah/.config/rofi/.current_wallpaper"
