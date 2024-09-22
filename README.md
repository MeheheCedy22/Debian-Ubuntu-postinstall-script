# Postinstall script for Debian/Ubuntu based distros

NOTE: Script is in phase of testing and usage is not recommended

Supported distributions: Ubuntu 22.04 (and higher)

This is because the script uses the `nala` package which is missing in older versions.
You do not need to install `nala`. The script will install the package.

Nala is used because it supports rollback from history.

My personal post-install script for Debian/Ubuntu based distros

# How to run

## Download git if you have not already
```bash
sudo apt update && sudo apt install git
```

## Clone the repository and run the script
```bash
cd ~/Downloads
git clone https://github.com/MeheheCedy22/Debian-Ubuntu-postinstall-script.git
cd Debian-Ubuntu-postinstall-script
chmod +x myinstallscript.sh
./myinstallscript.sh
```
