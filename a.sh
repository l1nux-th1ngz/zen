#!/bin/bash

# Get packages to install using Zenity
packages_input=$(zenity --entry --title="Package Installation" --text="Enter the packages to install:")

# Check if the input is not empty
if [ -n "$packages_input" ]; then
    # Split the input into an array of packages
    IFS=' ' read -ra packages <<< "$packages_input"

    # Install packages using yay and paru with --noconfirm option
    yay -S --noconfirm "${packages[@]}"
    paru -S --noconfirm "${packages[@]}"

    # Function to display progress using Zenity
    function show_progress() {
        (
        # Your progress bar logic goes here...
        echo "50"
        echo "# We Are At The Half 50/50 Point => %50." ; sleep 0.2
        echo "75"
        echo "# 3/4 Are You Getting Excited yet => %75." ; sleep 0.4
        echo "# You Are All Done!!!" ; sleep 0.5
        echo "100"
        ) | zenity --progress --text="Working on your downloads..." --percentage=0 --auto-close --auto-kill
    }

    # Call the progress function
    show_progress

    # Additional logic or messages after completion
    zenity --info --width=870 --height=650 --text "Do you want to copy and link this directory in the .config for easier access and configuration?" \
           --ok-label="Yes" \
           --extra-button="Ask Me Later" \
           --cancel-label="No"
else
    zenity --warning --title="No Packages Entered" --text="Please enter at least one package name."
fi

