#!/bin/bash

# Get the directory of the current script
script_dir="$(dirname "$0")"

# Define the package list file
pkglist_file="$script_dir/pkglist.txt"

# Check if the package list file exists
if [ ! -f "$pkglist_file" ]; then
    echo "Package list file not found: $pkglist_file"
    exit 1
fi

# Create a GUI with a download button
zenity --question --text="Do you want to start the installation?" --ok-label="Download"

# Check if the user clicked the download button
if [ $? -eq 0 ]; then
    # Read the package list file line by line
    while IFS= read -r package
    do
        # Install the package using yay and paru
        echo "Installing $package..."
        yay -S "$package" --noconfirm
        paru -S "$package" --noconfirm
    done < "$pkglist_file"

    echo "Installation completed."
else
    echo "Installation cancelled."
fi
