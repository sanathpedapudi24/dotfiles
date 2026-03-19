#!/bin/bash

echo "==> Installing yay (AUR helper)..."
if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si
    cd -
fi

echo "==> Installing packages..."
yay -S --needed - < packages.txt

echo "==> Linking configs..."
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

cp -r "$DOTFILES_DIR"/.config/* ~/.config/

echo "==> Done! Please reboot."
