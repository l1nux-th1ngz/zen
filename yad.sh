#!/bin/bash

pkglist_file="pkglist.txt"

# Create pkglist file if it doesn't exist
touch "$pkglist_file"

# Get packages from the pkglist file
pkglist=$(cat "$pkglist_file")

# Function to display the main options using Yad
function show_main_options() {
    yad --form \
        --title="Package Installation Options" \
        --text="Select an option:" \
        --field="Packages to Install:" "$pkglist" \
        --field="Copy to .config:CHK" \
        --buttons-layout=center \
        --button="Install!gtk-execute:0" \
        --button="Quit!gtk-quit:1" \
        --width=350 \
        --height=200
}

# Call the main options function
main_options=$(show_main_options)

# Extract the values from the Yad output
IFS='|' read -r packages copy_to_config <<< "$main_options"

# Check if the user clicked "Install"
if [ "$?" -eq 0 ]; then
    # Append the new input to the existing pkglist
    echo "$packages" >> "$pkglist_file"

    # Split the input into an array of packages
    IFS=' ' read -ra packages_array <<< "$packages"

    # Install packages using yay and paru with --noconfirm option
    yay -S --noconfirm "${packages_array[@]}"
    paru -S --noconfirm "${packages_array[@]}"

    # Check if "Copy to .config" is selected
    if [ "$copy_to_config" = TRUE ]; then
        yad --info --text="Directory copied to .config for easier access and configuration." --width=250 --height=120
    else
        yad --info --text="Installation completed." --width=200 --height=100
    fi
else
    yad --info --text="Installation canceled." --width=200 --height=100
fi
