#!/bin/bash

greeting="Welcome Back to the YAY & PARU Software Installer!"
user=$(whoami)
input=/home/$user
day=$(date +%A)
output="/tmp/${user}_home_$(date +%m-%d_%Y_%H%M%S).sh"

# Install packages using yay and paru with --noconfirm option
yay -S --noconfirm
paru -S --noconfirm

function progress() {
    (
    # =================================================================
    zenity --progress --pulsate --text="Working on your downloads..." --percentage=0
    echo "# Just Getting Started => %0." ; sleep 2
    # Command for the first task goes on this line.
    echo "24"
    echo "# Things Are Going Smooth => %25." ; sleep 0.5

    # =================================================================
    echo "50"
    echo "# We Are At The Half 50/50 Point => %50." ; sleep 0.2
    # Command for the third task goes on this line.

    # =================================================================
    echo "75"
    echo "# 3/4 Are You Getting Excited yet => %75." ; sleep 0.4

    # Command for the third task goes on this line.
    # =================================================================
    zenity --progress --pulsate --text="We are progressing..." --percentage=0
    echo "# You Are All Done!!!" ; sleep 0.5
    echo "100"
    ) | zenity --progress --text="Working on your downloads..." --percentage=0

    # Additional logic or messages after completion
    echo "Welcome back, $user! Today you downloaded # Number of apps downloaded!"
    zenity --info --width=870 --height=650 --text "Do you want to copy and link this directory in the .config for easier access and configuration?" \
           --ok-label="Yes" \
           --extra-button="Ask Me Later" \
           --cancel-label="No"
}

echo "You are # (give a percentage of the apps that was installed and a number installed over how many) back $user! Today You Downloaded, # Number of apps downloaded!"
zenity --progress --text="Working On Your Downloads" --percentage=0
zenity --progress --text="We are progressing" --percentage=0 --pulsate

zenity --question --text="Do You Want To Copy &  This Directory In The .config For Easier Access & Configuration?" --ok-label="Yes" --extra-button="Ask Me Later" --cancel-label="No"

zenity --info --width=870 --height=650 --text "Do you want to copy and link of this directory in the .config for easier access and configuration?" \
       --ok-label="Yes" \
       --extra-button="Ask Me Later" \
       --cancel-label="No"
