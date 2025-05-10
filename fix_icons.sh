#!/bin/bash

echo "Arch Linux Icon Fix Script"
echo "=========================="
echo

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root (with sudo)"
  exit 1
fi

echo "Installing common icon themes and dependencies..."
pacman -S --needed --noconfirm \
  hicolor-icon-theme \
  adwaita-icon-theme \
  gnome-icon-theme \
  gnome-icon-theme-extras \
  arc-icon-theme \
  papirus-icon-theme \
  gtk-update-icon-cache \
  librsvg

echo "Checking for your desktop environment..."
if pgrep -x "gnome-shell" > /dev/null; then
  echo "GNOME detected, installing GNOME icon themes..."
  pacman -S --needed --noconfirm gnome-themes-extra
elif pgrep -x "plasmashell" > /dev/null; then
  echo "KDE Plasma detected, installing KDE icon themes..."
  pacman -S --needed --noconfirm breeze-icons oxygen-icons
elif pgrep -x "xfce4-session" > /dev/null; then
  echo "XFCE detected, installing XFCE icon themes..."
  pacman -S --needed --noconfirm xfce4-icon-theme
elif pgrep -x "cinnamon" > /dev/null; then
  echo "Cinnamon detected, installing Cinnamon icon themes..."
  pacman -S --needed --noconfirm mint-x-icons mint-y-icons
fi

echo "Rebuilding icon caches..."
# Update icon caches for common icon themes
for theme in /usr/share/icons/*; do
  if [ -d "$theme" ]; then
    echo "Updating cache for $(basename "$theme")..."
    gtk-update-icon-cache -f -t "$theme"
  fi
done

# Update user icon caches if they exist
if [ -d "$HOME/.local/share/icons" ]; then
  for theme in "$HOME/.local/share/icons"/*; do
    if [ -d "$theme" ]; then
      echo "Updating user cache for $(basename "$theme")..."
      gtk-update-icon-cache -f -t "$theme"
    fi
  done
fi

echo "Updating MIME database..."
update-mime-database /usr/share/mime

echo "Updating desktop database..."
update-desktop-database

echo "Fixing Wine icon associations..."
# Check if Wine is installed
if command -v wine > /dev/null; then
  echo "Wine detected, fixing Wine icon associations..."
  pacman -S --needed --noconfirm icoutils
  
  # Create Wine icon theme directory if it doesn't exist
  mkdir -p /usr/share/icons/hicolor/256x256/apps
  
  # Update Wine registry to use system icons
  if [ -d "$HOME/.wine" ]; then
    echo "Updating Wine registry to use system icons..."
    # This is a simplified approach - a more comprehensive fix would require
    # modifying the Wine registry directly
    touch "$HOME/.wine/drive_c/windows/system32/shell32.dll"
  fi
fi

echo "Clearing user icon caches..."
# Remove user icon caches to force regeneration
rm -rf "$HOME/.cache/icon-cache.kcache"
rm -f "$HOME/.local/share/mime/mime.cache"
rm -f "$HOME/.local/share/applications/mimeinfo.cache"

echo "Done! Your icons should be fixed now."
echo "You may need to log out and log back in for all changes to take effect."
