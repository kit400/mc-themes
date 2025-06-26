#!/bin/bash

# Source theme file
THEME_SRC="kit256.ini"

# Check if mc is installed
if ! command -v mc &> /dev/null
then
    echo "❌ Midnight Commander is not installed. Please install it first."
    exit 1
fi

# Define skin directories
USER_SKIN_DIR="$HOME/.local/share/mc/skins"
SYSTEM_SKIN_DIR="/usr/share/mc/skins"

# Ask user for installation type
echo "Choose installation type:"
echo "1) User-wide (to $USER_SKIN_DIR)"
echo "2) System-wide (to $SYSTEM_SKIN_DIR, requires sudo)"
read -p "Enter choice (1 or 2): " INSTALL_TYPE

case $INSTALL_TYPE in
    1)
        mkdir -p "$USER_SKIN_DIR"
        cp "$THEME_SRC" "$USER_SKIN_DIR/"
        echo "✅ Theme installed to $USER_SKIN_DIR"
        TARGET_DIR="$USER_SKIN_DIR"
        ;;
    2)
        if [ "$(id -u)" -ne 0 ]; then
            echo "⚠️ This requires sudo access."
            read -p "Proceed with sudo? (y/n): " CONFIRM
            if [[ "$CONFIRM" != "y" ]]; then
                echo "❌ Installation cancelled."
                exit 1
            fi
        fi
        mkdir -p "$SYSTEM_SKIN_DIR"
        sudo cp "$THEME_SRC" "$SYSTEM_SKIN_DIR/"
        echo "✅ Theme installed to $SYSTEM_SKIN_DIR"
        TARGET_DIR="$SYSTEM_SKIN_DIR"
        ;;
    *)
        echo "❌ Invalid choice. Installation cancelled."
        exit 1
        ;;
esac

# Ask if user wants to apply the theme automatically
echo ""
echo "Do you want to set 'kit256' as your current theme now? (y/n)"
read -p "Apply theme automatically? " APPLY_THEME

if [[ "$APPLY_THEME" == "y" ]]; then
    MC_INI="$HOME/.config/mc/ini"
    
    # Ensure .config/mc directory exists
    mkdir -p "$(dirname "$MC_INI")"

    # Apply or update the skin setting
    if grep -q '^skin=' "$MC_INI"; then
        sed -i 's|^skin=.*|skin=kit256|' "$MC_INI"
        echo "🎨 Theme updated in $MC_INI"
    else
        echo "skin=kit256" >> "$MC_INI"
        echo "🎨 Theme added to $MC_INI"
    fi
else
    echo "💡 To apply the theme later, edit ~/.config/mc/ini and set: skin=kit256"
fi

echo ""
echo "🎉 Installation complete!"
echo "Launch Midnight Commander (mc), press F9 → Options → Appearance, and select 'kit256'."