#!/bin/bash
RED = '\033[0;31m'
NO_COL = '\033[0m'
echo "${RED}Updating...${NO_COL}"
sudo dfn update --refresh
echo "${RED}Installing utilities...${NO_COL}"
sudo dfn neofetch btop
#steam
echo "${RED}Installing gaming apps...${NO_COL}"
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf install steam lutris heroic

#disable composition
echo "${RED}Disabling composition...${NO_COL}"
xdotool key shift+alt+F12

#gamemode 
echo "${RED}Installing gamemode...${NO_COL}"
dnf install meson systemd-devel pkg-config git dbus-devel inih-devel
git clone https://github.com/FeralInteractive/gamemode.git
cd gamemode
git checkout 1.8.2 # omit to build the master branch
./bootstrap.sh
#gamemoded -t per verificare l'istallazione
wget https://raw.githubusercontent.com/FeralInteractive/gamemode/refs/heads/master/example/gamemode.ini ~/.config/gamemode.ini
echo -e "\033[0;32mDone!${NO_COL}"
echo "gamemoded -t to verify installation"