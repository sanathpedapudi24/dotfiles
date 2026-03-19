#!/bin/bash

# Path to store the last wallpaper
LAST_WALLPAPER="$HOME/Downloads/astronaut-2.png"
THUMBNAIL_DIR="$HOME/Downloads/astronaut-2.png"

# Wait a bit for everything to initialize
sleep 2

# Check if last wallpaper file exists and restore it
if [ -f "$LAST_WALLPAPER" ]; then
  wallpaper_path=$(cat "$LAST_WALLPAPER")
  if [ -f "$wallpaper_path" ]; then
    # Get file extension
    extension="${wallpaper_path##*.}"
    if [ "${extension,,}" = "mp4" ]; then
      # Handle MP4 animated wallpaper with gslapper
      killall gslapper 2>/dev/null
      gslapper -o "loop fill" "*" "$wallpaper_path" &
    else
      # Handle static image wallpaper
      swww img "$wallpaper_path" --transition-type fade --transition-duration 1
    fi
  fi
fi
