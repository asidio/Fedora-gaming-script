#!/bin/bash
set -e
RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
NO_COL="\033[0m"
echo -e "${BLUE}==============================${NO_COL}"
echo -e "${BLUE}      Updating System...      ${NO_COL}"
echo -e "${BLUE}==============================${NO_COL}"
sudo dnf update --refresh -y
echo -e "${BLUE}==============================${NO_COL}"
echo -e "${BLUE}    Installing utilities...   ${NO_COL}"
echo -e "${BLUE}==============================${NO_COL}"
sudo dnf install -y xdotool gcc fastfetch btop
#gaming specific programs
echo -e "${BLUE}==============================${NO_COL}"
echo -e "${BLUE}   Installing gaming apps...  ${NO_COL}"
echo -e "${BLUE}==============================${NO_COL}"
echo -e "${BLUE}Installing steam for fedora version: $(rpm -E %fedora)...${NO_COL}"
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf install -y steam lutris
sudo dnf copr enable atim/heroic-games-launcher
sudo dnf install -y heroic-games-launcher-bin

#disable composition
echo -e "${GREEN}Composition disabled.${NO_COL}"
xdotool key shift+alt+F12

#gamemode 
echo -e "${BLUE}=========================================${NO_COL}"
echo -e "${BLUE}   Installing gamemode dependencies...   ${NO_COL}"
echo -e "${BLUE}=========================================${NO_COL}"
sudo dnf install -y meson systemd-devel pkg-config git dbus-devel inih-devel
echo -e "${BLUE}==============================${NO_COL}"
echo -e "${BLUE}    Installing gamemode...    ${NO_COL}"
echo -e "${BLUE}==============================${NO_COL}"
if git clone https://github.com/FeralInteractive/gamemode.git; then
    echo "${GREEN}Gamemode successfully cloned${NO_COL}"
else 
    echo "${RED}Error cloning gamemode${NO_COL}"
    exit 1
fi
cd gamemode
git checkout 1.8.2 # omit to build the master branch
echo -e "${BLUE}Running bootstrap script...${NO_COL}"
./bootstrap.sh
if command -v gamemoded &> /dev/null; then
    echo "${GREEN}Gamemoded correctly installed${NO_COL}"
else
    echo "${RED}Errore gamemoded can't be installed${NO_COL}"
    exit 1
fi
if ! command -v wget &> /dev/null; then
    echo "${RED}wget not found, installing it now...${NO_COL}"
    sudo dnf install -y wget
fi
wget https://raw.githubusercontent.com/FeralInteractive/gamemode/refs/heads/master/example/gamemode.ini ~/.config/gamemode.ini
echo -e "${GREEN}===========================${NO_COL}"
echo -e "${GREEN}            Done!          ${NO_COL}"
echo -e "${GREEN}===========================${NO_COL}"
echo -e "type 'gamemoded -t' to verify installation\n"
echo -e "${GREEN}Enjoy!😁${NO_COL}"