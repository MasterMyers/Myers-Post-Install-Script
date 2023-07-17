#!/bin/bash

# Check if Flatpak is installed
if ! command -v flatpak &> /dev/null; then
    echo "Flatpak is not installed. Installing Flatpak..."

    # Check the package manager and install Flatpak accordingly
    if command -v pacman &> /dev/null; then
        sudo pacman -Syu
        sudo pacman -S flatpak
    elif command -v apt-get &> /dev/null; then
        sudo apt update
        sudo apt-get install flatpak
    else
        echo "Unable to determine the package manager. Exiting."
        exit 1
    fi

    # Add the Flathub repository
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
fi



# Check if pacman is installed
if command -v pacman &> /dev/null; then
    echo "Pacman package manager detected."
    package_manager="pacman"

    # Define package bundles for pacman
    base_packages=(
        "discord"
        "gimp"
        "gtypist-single-space"
        "htop"
        "keepassxc"
        "mpv"
        "nvtop"
        "protonvpn"
        "spotify-launcher"
        "ungoogled-chromium"
        "vim"
        "whatsapp-for-linux"
        )
    game_packages=(
        "heroic-games-launcher"
        "lutris"
        "prismlauncher"
        "protonup-qt"
        "steam"
        )
    work_packages=(
        "audacity"
        "dbeaver"
        "intellij-idea-community-edition"
        "kdenlive"
        "libreoffice-fresh"
        "obs-studio"
        "postman-bin"
        "thunderbird"
        "umlet"
        )
    all_packages=(
        "${base_packages[@]}"
        "${game_packages[@]}"
        "${work_packages[@]}"
        )

    # Check if yay is installed
    if ! command -v yay &> /dev/null; then
        echo "Yay is not installed. Installing Yay..."
        sudo pacman -S --needed yay
    fi

# Check if apt is installed
elif command -v apt-get &> /dev/null; then
    echo "Apt package manager detected."
    package_manager="apt"

    # Define package bundles for apt
    base_packages=(
        "gimp"
        "gtypist"
        "htop"
        "keepassxc"
        "mpv"
        "nvtop"
        "protonvpn"
        "vim"
        )
    base_packages_flatpak=(
        "discord"
        "spotify"
        "ungoogled-chromium"
        "whatsapp-for-linux"
        )
    game_packages=(
        "lutris"
        "steam"
        )
    game_packages_flatpak=(
        "heroic-games-launcher"
        "itch"
        "prismlauncher"
        "protonup-qt"
        )
    work_packages=(
        "audacity"
        "kdenlive"
        "libreoffice"
        "obs-studio"
        "thunderbird"
        )
    work_packages_flatpak=(
        "dbeaver-community"
        "intellij-idea-community-edition"
        "postman"
        "umlet"
        )
    all_packages=(
        "${base_packages[@]}"
        "${game_packages[@]}"
        "${work_packages[@]}"
        )
    all_packages_flatpak=(
        "${base_packages_flatpak[@]}"
        "${game_packages_flatpak[@]}"
        "${work_packages_flatpak[@]}"
        )
else
    echo "Unable to determine the package manager. Exiting."
    exit 1
fi



# Prompt user for package bundle choice
echo "Please select a package bundle to install:"
echo "1. Base Packages"
echo "2. Game Packages"
echo "3. Work Packages"
echo "4. All Packages"
read -rp "Enter your choice (1-4): " choice



# Install packages based on user choice
case $choice in
    1)
        packages=("${base_packages[@]}")
        packages_flatpak=("${base_packages_flatpak[@]}")
        ;;
    2)
        packages=("${game_packages[@]}")
        packages_flatpak=("${game_packages_flatpak[@]}")
        ;;
    3)
        packages=("${work_packages[@]}")
        packages_flatpak=("${work_packages_flatpak[@]}")
        ;;
    4)
        packages=("${all_packages[@]}")
        packages_flatpak=("${all_packages_flatpak[@]}")
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac



# Install selected packages using the package manager
if [ "$package_manager" == "pacman" ]; then
    sudo pacman -Syu
    yay -S --needed "${packages[@]}"
elif [ "$package_manager" == "apt" ]; then
    sudo apt update
    sudo apt install "${packages[@]}"
    sudo flatpak install "${packages_flatpak[@]}"
fi
