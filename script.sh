#!/bin/bash
set -e
RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
NO_COL="\033[0m"
echo -e "${BLUE}Updating...${NO_COL}"
sudo dfn update --refresh
echo -e "${BLUE}Installing utilities...${NO_COL}"
sudo dfn xdotool neofetch btop
#gaming specific programs
echo -e "${BLUE}Installing gaming apps...${NO_COL}"
echo -e "${BLUE}Installing steam for fedora version: $(rpm -E %fedora)...${NO_COL}"
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf install steam lutris heroic

#disable composition
echo -e "${BLUE}Disabling composition...${NO_COL}"
xdotool key shift+alt+F12

#gamemode 
echo -e "${BLUE}Installing gamemode...${NO_COL}"
dnf install meson systemd-devel pkg-config git dbus-devel inih-devel
if git clone https://github.com/FeralInteractive/gamemode.git; then
    echo "${GREEN}Gamemode clonato con successo${NO_COL}"
else 
    echo "${RED}Clonazione di gamemode fallita${NO_COL}"
    exit 1
fi
cd gamemode
git checkout 1.8.2 # omit to build the master branch
./bootstrap.sh
wget https://raw.githubusercontent.com/FeralInteractive/gamemode/refs/heads/master/example/gamemode.ini ~/.config/gamemode.ini
echo -e "${GREEN}Done!${NO_COL}"
echo -e "type 'gamemoded -t' to verify installation"