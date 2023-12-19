#!/bin/bash

pkglist_file="pkglist.txt"

# Create pkglist file if it doesn't exist
touch "$pkglist_file"

# Get packages from the pkglist file
pkglist=$(cat "$pkglist_file")

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

# Function to display "Copy to .config" dialog
function show_copy_to_config_dialog() {
    zenity --question --text="Do you want to copy and link this directory in the .config for easier access and configuration?" \
        --ok-label="Yes" \
        --extra-button="Ask Me Later" \
        --cancel-label="No"
}

# Get additional packages to install using Zenity
packages_input=$(zenity --entry --title="Package Installation" --text="Packages to Install (separated by space):" --entry-text="$pkglist")

# Check if the input is not empty
if [ -n "$packages_input" ]; then
    # Append the new input to the existing pkglist
    echo "$packages_input" >> "$pkglist_file"

    # Split the input into an array of packages
    IFS=' ' read -ra packages <<< "$packages_input"

    # Install packages using yay and paru with --noconfirm option
    yay -S --noconfirm "${packages[@]}"
    paru -S --noconfirm "${packages[@]}"

    # Call the progress function
    show_progress

    # Call the "Copy to .config" dialog function
    case $(show_copy_to_config_dialog) in
        "Ask Me Later")
            zenity --info --text="You can copy to .config later." --width=200 --height=100 ;;
        "Yes")
            zenity --info --text="Directory copied to .config for easier access and configuration." --width=250 --height=120 ;;
        "No")
            zenity --info --text="Directory not copied to .config." --width=200 --height=100 ;;
    esac
else
    zenity --warning --title="No Packages Entered" --text="Please enter at least one package name."
fi
