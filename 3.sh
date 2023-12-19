#!/bin/bash

greeting="Welcome Back to the YAY & PARU Software Installer!"
user=$(whoami)
input=/home/$user
day=$(date +%A)
output=/tmp/${user}_home_$(date +%m-%d-%Y_%H%M%S).txt

# Get AUR repository URL from the user
aur_repo_url=$(zenity --entry --text "Enter AUR Repository URL:" --title "AUR Downloader")

# Verify the input is not empty
if [ -z "$aur_repo_url" ]; then
    zenity --error --text "Repository URL cannot be empty. Exiting."
    exit 1
fi

# Extract the name of the repository from the URL
repo_name=$(basename "$aur_repo_url" .git)

# Set the chosen directory to the Git-Clones directory in the home folder
chosen_directory="$HOME/Git-Clones/$repo_name"

# Clone the repository
git clone "$aur_repo_url" "$chosen_directory"

# Navigate to the downloaded directory
cd "$chosen_directory" || exit 1

# Build the AUR package and install without user interaction
yay -S --noconfirm "$repo_name"
paru -S --noconfirm "$repo_name"

# Check if the build was successful
if [ $? -eq 0 ]; then
    # Ask the user if they want to copy this directory to .config
    if zenity --question --text="Do You Want To Copy This Directory In The .config For Easier Access & Configuration?"; then
        cp -r "$chosen_directory" "$HOME/.config/$(basename "$chosen_directory")"
        zenity --info --text="Folder copied to .config successfully."
    else
        zenity --info --text="Folder not copied."
    fi
else
    # If the build failed, display the build output
    zenity --error --text="Build failed. Please check the build output for more information."
    cat PKGBUILD
fi

# Wait for user input before exiting
zenity --info --text="Press OK to exit."
