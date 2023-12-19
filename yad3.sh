#!/bin/bash

# Define the package list file
pkglist_file="pkglist.txt"

# Create pkglist file if it doesn't exist
touch "$pkglist_file"

# Get packages from the pkglist file
pkglist=$(cat "$pkglist_file")

# Get additional packages to install using Yad
packages_input=$(yad --form --title="Package Installation" --field="Enter additional packages to install::TXT" --field="Install:FBTN" "bash -c \"echo %1 >> $pkglist_file && zenity --info --text='Packages added to list'\"" --field="Cancel:FBTN" "bash -c \"zenity --info --text='Operation cancelled'\"")

# Check if the input is not empty
if [ -n "$packages_input" ]; then
    # Append the new input to the existing pkglist
    echo "${packages_input%%|*}" >> "$pkglist_file"

    # Function to display progress using Yad
    function show_progress() {
        (
        # Your progress bar logic goes here...
        echo "50"
        echo "# We Are At The Half 50/50 Point => %50." ; sleep 0.2
        echo "75"
        echo "# 3/4 Are You Getting Excited yet => %75." ; sleep 0.4
        echo "# You Are All Done!!!" ; sleep 0.5
        ) | yad --progress --text="Working on your downloads..." --percentage=0 --auto-close --auto-kill
    }

    # Function to display installation confirmation dialog
    function show_install_confirmation() {
        yad --question --text="Are you sure you want to install the selected packages?" --button="Install:0" --button="Cancel:1"
    }

    # Call the installation confirmation function
    if show_install_confirmation; then
        # Call the progress function
        show_progress

        # Additional logic or messages after completion
        yad --info --width=870 --height=650 --text "Do you want to copy and link this directory in the .config for easier access and configuration?" \
            --button="Yes:0" \
            --button="Ask Me Later:1" \
            --button="No:2"
    else
        yad --info --text="Installation canceled." --width=200 --height=100
    fi
else
    yad --warning --title="No Packages Entered" --text="Please enter at least one package name."
fi
