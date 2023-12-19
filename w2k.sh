#!/bin/bash

# Define the package list file
pkglist_file="pkglist.txt"

# Create pkglist file if it doesn't exist
touch "$pkglist_file"

# Get packages from the pkglist file
pkglist=$(cat "$pkglist_file")

# Get additional packages to install using Zenity
packages_input=$(zenity --entry --title="Package Installation" --text="Enter additional packages to install:" --entry-text="$pkglist")

# Check if the input is not empty
if [ -n "$packages_input" ]; then
    # Append the new input to the existing pkglist
    echo "$packages_input" >> "$pkglist_file"

    # Function to display progress using Zenity
    function show_progress() {
        (
        # Your progress bar logic goes here...
        echo "50"
        echo "# We Are At The Half 50/50 Point => %50." ; sleep 0.2
        echo "75"
        echo "# 3/4 Are You Getting Excited yet => %75." ; sleep 0.4
        echo "# You Are All Done!!!" ; sleep 0.5
        ) | zenity --progress --text="Working on your downloads..." --percentage=0 --auto-close --auto-kill
    }

    # Function to display installation confirmation dialog
    function show_install_confirmation() {
        zenity --question --text="Are you sure you want to install the selected packages?" --ok-label="Install" --cancel-label="Cancel"
    }

    # Call the installation confirmation function
    if show_install_confirmation; then
        # Call the progress function
        show_progress

        # Additional logic or messages after completion
        zenity --info --width=870 --height=650 --text "Do you want to copy and link this directory in the .config for easier access and configuration?" \
            --ok-label="Yes" \
            --extra-button="Ask Me Later" \
            --cancel-label="No"
    else
        zenity --info --text="Installation canceled." --width=200 --height=100
    fi
else
    zenity --warning --title="No Packages Entered" --text="Please enter at least one package name."
fi

