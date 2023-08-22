# Postinstall script for Debian/Ubuntu based distros

NOTE: Script is phase of testing and usage is not recommended

Supported distributions: Ubuntu 22.04

This is because the script uses the `nala` package which is missing in older distributions.
You do not need to install `nala`. The script will install the package.

My personal post-install script for Debian/Ubuntu based distros

# How to run

```
# Download git if you have not already

sudo apt update && sudo apt install git

cd ~/Downloads
git clone https://github.com/MeheheCedy22/Debian-Ubuntu-postinstall-script.git
cd Debian-Ubuntu-postinstall-script
chmod +x myinstallscript.sh
./myinstallscript.sh
```
