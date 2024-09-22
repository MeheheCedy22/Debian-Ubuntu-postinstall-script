#!/bin/bash

# Script Variables
package_file="pckglst.txt"
optional="optional-programs.txt"
distribution=$(lsb_release -is)
LOGFILE="myinstallscript.log"

debug=false

automatic=false
force=false

# Text formatting variables, with echo use -e flag to interpret them (backslashes)
BOLD="\e[1m"
RESET="\e[0m"

help() {
    echo "$(basename "$0") (C) Marek Čederle"
    echo ""
    echo "Usage: $(basename "$0") [-h] [-y] [-f]"
    echo "-h - This help message."
    echo "-y - Automatic install without prompts. Says yes every package."
    echo "-f - Force install. It will skip the prompts for speacial configuration for some packages. For example says yes to wireshark configuration if the non-super users can capture packets."
}

# Function to log and print messages
log_and_print() {
    echo -e "$1" | tee -a "$LOGFILE"
}


# Parse command-line options
while getopts ":hyf" opt; do
    
    if [ "$debug" = true ]; then
        echo "Debug: \$opt \$OPTARG"
        echo "Debug: $opt $OPTARG"
    fi
    
    case $opt in
        h)
            help
            exit 0
        ;;
        y)
			automatic=true
        ;;
        f)
			force=true
        ;;
        \?)
            echo "Error: '-$OPTARG': is not valid argument" >&2
            exit 1
        ;;
    esac
done


echo "----- DEBIAN / UBUNTU POST-INSTALL SCRIPT -----"
echo "--- For now, only with GNOME DE ---"
echo "You are using $distribution"
sleep 3
echo "If you wish to adjust the packages/optional programs to be installed, please edit the files:"
echo "$package_file"
echo "$optional"
echo "Then run this script again."
echo "NOTE: The files must be located in the same directory as this script."
echo "	You can add your own (distro) packages to the $package_file file."
echo "	For now, when you delete some packages from the $optional file, it will have no effect."


echo "Would you like to start the script and install following packages ?"
echo "Distro Packages:"
sleep 3
# writing nala to stdout as first package so it dont need to be in the file because installing anyway and preventing to install it twice
echo "nala"
cat $package_file
sleep 3
echo "Optional Packages:"
sleep 3
cat $optional
echo "(Type exactly Yes/No)"

read -r choice

if [ "$choice" == "Yes" ]; then

		echo "Updating and upgrading..."
		sleep 3

	# Update and Upgrade
		sudo apt update && sudo apt upgrade -y

	# Nala-better front-end for apt
		sudo apt install nala -y
		sudo nala update && sudo nala upgrade -y

	# Installing packages using nala
	
		echo "Reading packages and installing them..."
		sleep 3
		# Check if the package list file exists
			if [ -f "$package_file" ]; then
			# Read each line from the package list file and install the packages
				while read -r package; do
					sudo nala install "$package" -y
				done < "$package_file"
			else
				echo "Package list file not found: $package_file"
				exit 1
			fi

	echo "Setting up a firewall..."
	sleep 3

	# Firewall setup
		sudo ufw default deny incoming
		sudo ufw default allow outgoing
		sudo ufw enable
		
	echo "Cloning personal configuration files..."
	echo ".bashrc"
	echo "starship.toml"
	echo "alacritty.yml"

	sleep 3

	# Change directory and clone personal dotfiles repo and copy .bashrc
		cd ~/Downloads/ || exit 1
		git clone https://github.com/MeheheCedy22/dotfiles.git
		cp ~/Downloads/dotfiles/.bashrc ~/
		# no need to source because not using any alias from .bashrc
		# source /home/"$USER"/.bashrc

#
echo "Installing packages/programs from other sources..."
sleep 3
#

	# Starship
		curl -sS https://starship.rs/install.sh | sh
		# Already in .bashrc
		# echo "eval \"$(starship init bash)\"" >> ~/.bashrc
		# source ~/.bashrc
		mkdir -p ~/.config
		cp ~/Downloads/dotfiles/starship.toml ~/.config/

	# Using Cargo
		# Exa
			cargo install exa
			# Already in .bashrc
			# echo "alias lss=\"exa -alh --color=always --group-directories-first\"" >> ~/.bashrc
			# source ~/.bashrc
		# Alacritty
			cargo install alacritty
			mkdir -p ~/.config/alacritty
			cp ~/Downloads/dotfiles/alacritty.yml ~/.config/alacritty/
		# Dust
			cargo install du-dust

	# .deb
		#Spotify
			curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
			echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
			sudo nala update && sudo nala install spotify-client -y
		#VS CODE , backslash is for escaping the & character
			wget https://code.visualstudio.com/sha/download?build=stable\&os=linux-deb-x64
			sudo dpkg -i code*.deb

		#Minecraft
			wget https://launcher.mojang.com/download/Minecraft.deb
			sudo dpkg -i Mine*.deb
			
	# Flatpak
		flatpak install app.getclipboard.Clipboard
		flatpak install com.discordapp.Discord
		flatpak install com.github.Eloston.UngoogledChromium
		flatpak install com.github.Eloston.UngoogledChromium.Codecs
		flatpak install com.github.d4nj1.tlpui
		flatpak install com.mattjakeman.ExtensionManager
		flatpak install com.sindresorhus.Caprine
		flatpak install io.github.realmazharhussain.GdmSettings
		flatpak install io.missioncenter.MissionCenter

	# Snap
		# Core (to work with snap i guess xd)
			sudo snap install core -y
			# sudo snap install core20 -y
		# btop
			sudo snap install btop -y

	# Only for Lenovo Legion Y520 laptop
		echo "Do you have Lenovo Legion Y520 laptop ? (type exactly Yes)"
		echo "!! WARNING !! DO NOT INSTALL THIS ON OTHER LAPTOPS !!"
		read -r laptop
		
		if [ "$laptop" == "Yes" ]; then
			sudo nala install python3-gi python3-gi-cairo gir1.2-gtk-3.0 python3-portio -y
			git clone https://gitlab.com/OdinTdh/extremecooling4linux.git
			cd ~/Downloads/extremecooling4linux || exit 1
			sudo make install
			cd ~/Downloads/ || exit 1
		fi

	# For Zorin OS only
		echo "Zorin OS programs only"

		if [ "$distribution" == "Zorin" ]; then
			sudo nala install zorin-os-upgrader -y
		else
			echo "You are not using Zorin OS, so skipping"	
		fi

	# Colorscript for terminal, must be enabled
		git clone https://gitlab.com/dwt1/shell-color-scripts.git
		cd shell-color-scripts || exit 1
		sudo make install
		cd ~/Downloads/ || exit 1

	#Dracula Themes for most of the programs

	# Lutris
		
	# Ripgrep

	# Nvidia drivers

	# OpenJDKs
	
	# HOTSPOTSHIELD VPN

	#
		echo "Cleaning up nala..."
		sleep 3
		sudo nala clean
		echo "For cleaning up ~/Downloads/ directory, please do it manually."
	#
	
	echo "Source your .bashrc manually to apply aliases:"
	echo "source /home/$USER/.bashrc"

	echo "Do you want to reboot your computer ? (type exactly Yes)"
	read -r reboot
	if [ "$reboot" == "Yes" ]; then
		reboot
	fi
elif [ "$choice" == "No" ]; then
	echo "Installation canceled !!"
else
	echo "Invalid input !!"
fi




