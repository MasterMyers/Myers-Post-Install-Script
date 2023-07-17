#!/bin/bash



# Check if Flatpak is installed
if ! command -v flatpak &> /dev/null; then
    echo "Flatpak is not installed. Installing Flatpak..."

    # Check the package manager and install Flatpak accordingly
    if command -v pacman &> /dev/null; then
        sudo pacman -Syu
        sudo pacman -S flatpak
    elif command -v apt-get &> /dev/null; then
        sudo apt update && sudo apt upgrade
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
        "proton-vpn"
        "spotify"
        "ungoogled-chromium"
        "vim"
        "whatsapp-for-linux")
    game_packages=(
        "heroic-games-launcher"
        "lutris"
        "prismlauncher"
        "protonup-qt"
        "steam")
    work_packages=(
        "audacity"
        "dbeaver-ce"
        "intellij-idea-community-edition"
        "kdenlive"
        "libreoffice-fresh"
        "obs"
        "postman"
        "thunderbird"
        "umlet")
    all_packages=(
        "audacity"
        "dbeaver-ce"
        "discord"
        "gimp"
        "gtypist-single-space"
        "heroic-games-launcher"
        "htop"
        "intellij-idea-community-edition"
        "itch"
        "keepassxc"
        "kdenlive"
        "libreoffice-fresh"
        "lutris"
        "mpv"
        "nvtop"
        "obs"
        "prismlauncher"
        "postman"
        "proton-vpn"
        "protonup-qt"
        "spotify"
        "steam"
        "thunderbird"
        "umlet"
        "ungoogled-chromium"
        "vim"
        "whatsapp-for-linux")
elif command -v apt-get &> /dev/null; then
    echo "Apt package manager detected."
    package_manager="apt"

    # Define package bundles for apt
    base_packages=(
        "discord"
        "gimp"
        "gtypist-single-space"
        "htop"
        "keepassxc"
        "mpv"
        "nvtop"
        "proton-vpn"
        "spotify"
        "ungoogled-chromium"
        "vim"
        "whatsapp-for-linux")
    game_packages=(
        "heroic-games-launcher"
        "lutris"
        "prismlauncher"
        "protonup-qt"
        "steam")
    work_packages=(
        "audacity"
        "dbeaver-ce"
        "intellij-idea-community-edition"
        "kdenlive"
        "libreoffice-fresh"
        "obs"
        "postman"
        "thunderbird"
        "umlet")
    all_packages=(
        "audacity"
        "dbeaver-ce"
        "discord"
        "gimp"
        "gtypist-single-space"
        "heroic-games-launcher"
        "htop"
        "intellij-idea-community-edition"
        "itch"
        "keepassxc"
        "kdenlive"
        "libreoffice-fresh"
        "lutris"
        "mpv"
        "nvtop"
        "obs"
        "prismlauncher"
        "postman"
        "proton-vpn"
        "protonup-qt"
        "spotify"
        "steam"
        "thunderbird"
        "umlet"
        "ungoogled-chromium"
        "vim"
        "whatsapp-for-linux")
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
        ;;
    2)
        packages=("${game_packages[@]}")
        ;;
    3)
        packages=("${work_packages[@]}")
        ;;
    4)
        packages=("${all_packages[@]}")
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

# Install selected packages using the package manager
if [ "$package_manager" == "pacman" ]; then
    sudo pacman -S "${packages[@]}"
elif [ "$package_manager" == "apt" ]; then
    sudo apt install "${packages[@]}"
fi
