#!/bin/bash

pkglist_file="pkglist.txt"

# Create pkglist file if it doesn't exist
touch "$pkglist_file"

# Function to display the main options using Yad
function show_main_options() {
    yad --form \
        --title="Package Installation Options" \
        --text="Select an option:" \
        --field="Copy to .config:CHK" \
        --field=" " \
        --button="Install!gtk-execute:0" \
        --button="Quit!gtk-quit:1" \
        --width=400 \
        --height=150 \
        --image=dialog-question \
        --image-on-top \
        --fore=#000000 \
        --back=#FFD700
}

# Function to display the "Copy to .config" dialog using Zenity
function show_copy_to_config_dialog() {
    zenity --question \
        --text="Do you want to copy and link this directory for faster and easier access?" \
        --width=570 \
        --height=385
}

# Call the main options function
main_options=$(show_main_options)

# Extract the values from the Yad output
IFS='|' read -r copy_to_config <<< "$main_options"

# Check if the user clicked "Install"
if [ "$?" -eq 0 ]; then
    # Check if "Copy to .config" is selected
    if [ "$copy_to_config" = TRUE ]; then
        # Call the "Copy to .config" dialog function for each installation
        while true; do
            if show_copy_to_config_dialog; then
                yad --info --text="Directory copied to .config for faster and easier access." --width=250 --height=120 --fore=#FFFFFF --back=#4CAF50
            else
                yad --info --text="Installation completed." --width=200 --height=100 --fore=#FFFFFF --back=#2196F3
            fi

            # Ask if the user wants to install another package
            if ! yad --question --text="Do you want to install another package?" --width=300; then
                break
            fi
        done
    else
        yad --info --text="Installation completed." --width=200 --height=100 --fore=#FFFFFF --back=#2196F3
    fi
else
    yad --info --text="Installation canceled." --width=200 --height=100 --fore=#FFFFFF --back=#FF0000
fi
