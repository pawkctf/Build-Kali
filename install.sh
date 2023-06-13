#!/bin/bash
#
#Description:
#This script is for updating and configuring Kali Linux after a fresh install
#
#RUN AS SUDO

# Fix Errors
sudo apt --fix-broken install -y
sudo dpkg --configure -a

# Update Keys
wget -q -O - archive.kali.org/archive-key.asc | apt-key add

# Current version info
echo ""
printf "${LGREEN}Current version info...${NC}\n"
lsb_release -irdc
printf "Kernal Version: ";uname -r
printf "Processor Type: ";uname -m

# Add User to Sudo
adduser pawkctf sudo

# Assign text colour for alert lines:  
RED='\033[0;31m' # Red
GREEN='\033[0;32m' # Green
LGREEN='\033[1;32m' # Light Green 
NC='\033[0m' # No Color
#change {TEXTCOLOR} to {RED}, {GREEN}, or {LGREEN} to change text colour.

### Perform System Updates (leave enabled, these are the primary actions of this script):
echo ""
printf "${LGREEN}Performing System Updates - This may take some time...${NC}\n"
sudo apt clean
sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y

### Install & Run Unattended Upgrades - automatic installation of security upgrades (leave enabled):
echo ""
printf "${LGREEN}Installing Security Upgrades...${NC}\n"
sudo apt install -y unattended-upgrades
sudo unattended-upgrades

### Update SearchSploit
searchsploit -u

### Install Python and update PIP (it appears the system default is Python 2.7, change this to v3 at your own risk):
echo ""
printf "${LGREEN}Installing Python & Updating PIP...${NC}\n"

### Install Python 3:
sudo apt install -y python3 python3-pip python3-dev python3-picamera

### Install Python 2:
sudo apt install -y python-pip python-dev
sudo pip install virtualenv

#Upgrade PIP
pip install --upgrade pip

###Install SSH client & server
echo ""
printf "${LGREEN}Configuring SSH client & server...${NC}\n"
sudo apt install -y ssh #install and enable sshd
sudo apt install -y openssh-server
sudo apt install -y openssh-client
sudo apt install -y putty #gui ssh client

### Install Internet applications:
echo ""
printf "${LGREEN}Installing Internet applications...${NC}\n"
sudo apt install -y uget #Download Manager
sudo apt install -y filezilla filezilla-common #FTP client
sudo apt install -y nodejs npm # NodeJS & NPM JavaScript Web Development

### Non Default Packages
sudo apt install feroxbuster
sudo apt install subfinder
sudo apt install eyewitness


### Install Snap Packages
sudo apt install snapd
systemctl enable --now snapd apparmor
service snapd.apparmor enable
service snapd.apparmor start
sudo snap install code --classic
sudo snap install postman
sudo snap install notepad-plus-plus
sudo snap install libreoffice
sudo apparmor_parser -r /etc/apparmor.d/*snap-confine*
sudo apparmor_parser -r /var/lib/snapd/apparmor/profiles/snap-confine*


# Add to path
export PATH="$PATH:/snap/bin"

## Github Repos
cd /opt
sudo git clone https://github.com/danielmiessler/SecLists.git


#Clean-up unused packages (leave enabled):
echo ""
printf "${LGREEN}Cleaning Up...${NC}\n"
sudo apt autoclean -y
sudo apt autoremove -y

### Prompt user to restart system after completing updates (leave enabled):
echo ""
printf "${LGREEN}Updates Completed - Consider restarting the system!${NC}\n"

printf "${LGREEN}System will reboot automatically in FIVE minutes - please save your work!${NC}\n"
sudo sync && sudo shutdown -r +5


