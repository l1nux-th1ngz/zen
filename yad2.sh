#!/bin/bash

# Define the package list file
pkglist_file="pkglist.txt"

# Create pkglist file if it doesn't exist
touch "$pkglist_file"

# Get packages from the pkglist file
pkglist=$(cat "$pkglist_file")

# Get additional packages to install using Yad
packages_input=$(yad --form --title="Package Installation" --field="Enter additional packages to install:" --field="Install!B" --field="Cancel!B")

# Check if the Install button was clicked
if [[ $packages_input == *TRUE* ]]; then
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
