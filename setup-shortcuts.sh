#!/bin/bash

# Setup keyboard shortcuts for nerd-dictation in GNOME

NERD_DICT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/nerd-dictation"

echo "Setting up nerd-dictation keyboard shortcuts..."
echo "Using nerd-dictation at: $NERD_DICT_PATH"

# GNOME Setup
if command -v gsettings &> /dev/null; then
    echo ""
    echo "Setting up GNOME shortcuts..."
    
    # Get current custom keybindings
    CUSTOM_KEYBINDINGS=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)
    
    # Remove the trailing ] to add new entries
    if [ "$CUSTOM_KEYBINDINGS" = "@as []" ]; then
        CUSTOM_KEYBINDINGS="["
    else
        CUSTOM_KEYBINDINGS="${CUSTOM_KEYBINDINGS%]}, "
    fi
    
    # Add our shortcuts
    CUSTOM_KEYBINDINGS="${CUSTOM_KEYBINDINGS}'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/nerd-dictation-begin/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/nerd-dictation-end/']"
    
    # Set the custom keybindings list
    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$CUSTOM_KEYBINDINGS"
    
    # Configure begin shortcut
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/nerd-dictation-begin/ name 'Start Dictation'
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/nerd-dictation-begin/ command "$NERD_DICT_PATH begin"
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/nerd-dictation-begin/ binding 'F9'
    
    # Configure end shortcut
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/nerd-dictation-end/ name 'End Dictation'
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/nerd-dictation-end/ command "$NERD_DICT_PATH end"
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/nerd-dictation-end/ binding 'F10'
    
    echo "✓ GNOME shortcuts configured (F9: begin, F10: end)"
else
    echo "✗ GNOME not found"
fi

echo "Setup complete! You can now use:"
echo "  F9  - Start dictation"
echo "  F10 - End dictation"
echo ""
echo "Note: If F9/F10 are already in use, you can change them in the settings."
