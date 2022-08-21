#!/bin/bash

#THIS IS NOT FINISHED VERSION OF SCRIPT

#SHOULD NOT BE USED!!!

echo "This is my personal install script for Debian/Ubuntu based distros"
sleep 3
echo "Would you like to install following packages ? (Type exactly Yes/No)"

read yn

if ($yn == "Yes"); then
	echo "Installing..."
	sleep 2
	sudo apt update && sudo apt upgrade -y
	sudo apt install nala -y
	sudo nala update && sudo nala upgrade -y
	sudo nala install python-is-python3 starship nmap neofetch mlocate htop net-tools wireless-tools git gcc g++ curl wget ssh gparted nano mc nvtop sensors intel-gpu-tools tlpui flameshot gimp vlc obs-studio audacity -y
	
elif ($yn == "No"); then
	echo "Installation canceled !!"
	sleep 2
else
	echo "Error!"
	sleep 2
fi
