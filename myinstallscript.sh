#!/bin/bash

#THIS IS NOT FINISHED VERSION OF SCRIPT
#SHOULD NOT BE USED!!!

echo "This is my personal install script for Debian/Ubuntu based distros"
sleep 1
echo "Would you like to install following packages ? (Type exactly Yes/No)"
cat pckglst.txt

read yn

if [ "$yn" == "Yes" ]; then
	echo "Installing..."
	sleep 4
#Update and Upgrade
	sudo apt update && sudo apt upgrade -y
#Nala-better front-end for apt
	sudo apt install nala -y
	sudo nala update && sudo nala upgrade -y
#Installign packages using nala
	sudo nala install python-is-python3 starship nmap neofetch mlocate htop net-tools wireless-tools git gcc g++ curl wget ssh gparted nano mc nvtop sensors intel-gpu-tools tlpui flameshot gimp vlc obs-studio audacity cargo -y
#Spotify
	curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
	echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
	sudo nala update && sudo nala install spotify-client -y
#VS CODE
	wget https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64
	sudo dpkg -i code*.deb
#HOTSPOTSHIELD VPN
	
#Minecraft
	wget https://launcher.mojang.com/download/Minecraft.deb
	sudo dpkg -i Mine*.deb
#Discord
	wget https://discord.com/api/download?platform=linux&format=deb
	sudo dpkg -i dis*.deb
#Exa (better ls)
	sudo cargo install exa -y


elif [ "$yn" == "No" ]; then
	echo "Installation canceled !!"
	sleep 2
else
	echo "Invalid input !!"
	sleep 2
fi
