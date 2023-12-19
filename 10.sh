#!/bin/bash

# Define the package list file
pkglist_file="pkglist.txt"

# Create pkglist file if it doesn't exist
touch "$pkglist_file"

# Get packages from the pkglist file
pkglist=$(cat "$pkglist_file")

# Create a Yad dialog with buttons
yad --title "Package Installation" \
    --form \
    --field="Enter additional packages to install::TXT" \
    --field="Enter Git repositories to clone::TXT" \
    --field="Install Packages!B":fbtn "bash -c 'echo %1 >> $pkglist_file && echo Packages added to list'" \
    --field="Clone Git Repositories!B":fbtn "bash -c 'echo Cloning... && sleep 2 && echo Done.'" \
    --field="View AUR!B":fbtn "xdg-open https://aur.archlinux.org" \
    --field="Cancel!B":fbtn "bash -c 'echo Operation cancelled.'"
