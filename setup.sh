#!/bin/bash
# Refresh system first
echo "** Update apt and upgrade**"
echo ""
echo ""
sudo apt update && sudo apt upgrade -y && sudo apt autoremove
echo ""
echo ""
sleep 2

# Install usefull tools!
echo "** Installing tools through apt **"
echo ""
echo ""
sudo apt install -y \
 docker-compose \
 curl \
 net-tools \
 git
echo ""
echo ""
sleep 2

# Now download the other config files from the repo
echo "** Download config files from github **"
curl -O https://raw.githubusercontent.com/magnuszetterberg/re-install/main/starship.toml
curl -O https://raw.githubusercontent.com/magnuszetterberg/re-install/main/bashrc-starship
curl -O https://raw.githubusercontent.com/magnuszetterberg/re-install/main/readme.md
echo ""
echo ""
sleep 2

# Create new ssh-key
echo "** creating ssh-key **"
echo ""
echo ""
# check if a file already exist,if true - skip
if [ -f ~/.ssh/id_rsa.pub ]; then
    echo "id_rsa.pub file already exist, skipping"
    echo ""
    echo ""
else
    echo ""
    echo ""
    ssh-keygen
fi
sleep 2

# Refresh snap
echo "** refreshing snap store **"
echo ""
echo ""
sudo snap refresh
sleep 2
# Install snaps
echo "** installing snap tools **"
echo ""
echo ""
sudo snap install \
 chromium \
 code
sleep 2

#Setup zero-tier network
echo "** installing zero-tier client **"
echo ""
echo ""
curl -s https://install.zerotier.com | sudo bash
sleep 2

echo ""
echo ""
# Setup starship shell
echo "** Installing Starship shell **"
echo ""
echo ""
curl -sS https://starship.rs/install.sh | sh
sleep 2

# Adding setup config to ~/.bashrc for starship
echo "** Adding starship config to ~/.bashrc file **"
# check if a file already exist,if true - skip
if grep -q "export STARSHIP_CONFIG*" ~/.bashrc; then
    echo "starship config already exists in ~/.bashrc, skipping"
    echo ""
    echo ""
else
    echo "cat bashrc-starship >> ~/.bashrc"
fi
sleep 2

# Copying starship.toml file to ~/.config/
echo "** Copying starship.toml file to ~/.config folder"
# check if a file already exist,if true - skip
if [ -f ~/.config/starship.toml ]; then
    echo "starship.toml file already exist, skipping"
    echo ""
    echo ""
else
    mkdir -p ~/.config && cp starship.toml ~/.config/starship.toml
fi

