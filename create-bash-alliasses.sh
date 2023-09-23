#!/bin/bash

# Function to add/update the alias in .bashrc
update_alias_in_bashrc() {
    local alias_name="$1"
    local alias_commands="$2"

    if grep -q "# My manually added aliases" "$HOME/.bashrc"; then
        # Alias section exists, update it
        sed -i "/# My manually added aliases/,/^$/c\\$alias_name" "$HOME/.bashrc"
    else
        # Alias section doesn't exist, add it to the end
        echo -e "# My manually added aliases\n$alias_name" >> "$HOME/.bashrc"
    fi
}

# Check if flatpak is installed and install if not
if ! command -v flatpak &>/dev/null; then
    echo "Flatpak is not installed. Installing..."
    # You can add the installation command for flatpak here
fi

# Check if apt is installed
if command -v apt &>/dev/null; then
    # Check if snap is installed
    if command -v snap &>/dev/null; then
        alias_name="alias updateall='sudo apt update && sudo apt upgrade && sudo flatpak update && sudo snap refresh'"
        update_alias_in_bashrc "$alias_name"
    else
        alias_name="alias updateall='sudo apt update && sudo apt upgrade && sudo flatpak update'"
        update_alias_in_bashrc "$alias_name"
    fi
fi

# Check if pacman is installed
if command -v pacman &>/dev/null; then
    # Check if yay is installed and install it if not
    if ! command -v yay &>/dev/null; then
        echo "yay is not installed. Installing..."
        # You can add the installation command for yay here
    fi

    alias_name="alias updateall='yay -Syu && sudo flatpak update'"
    update_alias_in_bashrc "$alias_name"
fi

# Source the .bashrc file to make the alias available in the current shell
source "$HOME/.bashrc"

echo "Alias 'updateall' has been added/updated in .bashrc."
