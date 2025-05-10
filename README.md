# Arch Linux Icon Fix Script

This script helps fix missing, corrupted, or low-quality icons on Arch Linux systems. It's particularly useful after software removals or system updates that might have broken icon themes.

## Problem This Script Solves

Common icon issues on Arch Linux include:
- Missing icons (showing as error icons)
- Low-quality icons
- Wine application icons showing as generic .exe icons
- Inconsistent icon themes across applications

## What This Script Does

The script performs the following actions:

1. **Installs Common Icon Themes**:
   - hicolor-icon-theme (base theme)
   - adwaita-icon-theme (GNOME default)
   - gnome-icon-theme and extras
   - arc-icon-theme
   - papirus-icon-theme
   - Required utilities (gtk-update-icon-cache, librsvg)

2. **Detects Your Desktop Environment**:
   - Automatically installs appropriate icon themes for GNOME, KDE, XFCE, or Cinnamon

3. **Rebuilds Icon Caches**:
   - Updates system-wide icon caches
   - Updates user icon caches

4. **Updates System Databases**:
   - MIME database
   - Desktop database

5. **Fixes Wine Icon Associations** (if Wine is installed):
   - Installs icoutils
   - Updates Wine registry settings for icons

6. **Clears User Icon Caches**:
   - Forces regeneration of icon caches on next login

## How to Use

1. Open a terminal
2. Navigate to the script directory:
   ```bash
   cd /home/dominick-cherrie/CascadeProjects/icon_fix
   ```
3. Run the script with sudo:
   ```bash
   sudo ./fix_icons.sh
   ```
4. After the script completes, **log out and log back in** for all changes to take effect

## Requirements

- Arch Linux or Arch-based distribution (Manjaro, EndeavourOS, etc.)
- Root privileges (sudo)

## Notes

- This script is non-destructive and only adds/updates icon themes
- It may take a few minutes to complete depending on your internet connection speed
- Some icons may require a system restart to fully update

## Troubleshooting

If you still experience icon issues after running the script:

1. Try running the script again
2. Restart your system completely
3. Check if your desktop environment has a specific theme manager where you can manually select icon themes
4. For Wine applications, you may need to reinstall the application or use a tool like Bottles to manage Wine prefixes
