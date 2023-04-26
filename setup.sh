#!/bin/bash
# Refresh system first
echo "** Update apt and upgrade **"
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
 git \
 htop
echo ""
echo ""
sleep 2

# setup $USER not having to use sudo to run docker commands
echo "adding user -> $USER <- to docker group(so that you dont have to use sudo)"
sudo usermod -aG docker $USER
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
    sleep 2
    echo "Done!"
fi


# Refresh snap
echo "** refreshing snap store **"
echo ""
echo ""
sudo snap refresh
sleep 2
# Install snaps
echo ""
echo ""
echo "** Checking if snap apps are installed **"
echo ""
echo ""
if ! snap list | grep -q 'code' || ! snap list | grep -q 'chromium'; then
    echo "One or both snap packages are not installed"
    echo "Installing now..."
    sudo snap install chromium code
else
    echo "Both snap packages are installed"
    echo ""
    echo ""
fi

#Setup zero-tier network
echo "** installing zero-tier client **"
if [ -f  /usr/sbin/zerotier-cli ]; then
    echo "zero-tier binary already installed - skipping"
    echo ""
    echo ""
else
    echo ""
    echo ""
    curl -s https://install.zerotier.com | sudo bash
    echo ""
    echo ""
    sleep 2
fi

# Setup starship shell
echo "** Installing Starship shell **"
if [ -f /usr/local/bin/starship ]; then
    echo "Starship binary already installed - skipping"
    echo ""
    echo ""
else
    echo ""
    echo ""
    curl -sS https://starship.rs/install.sh | sh
    echo ""
    echo ""
    sleep 2
fi

# Adding setup config to ~/.bashrc for starship
echo "** Appending starship config to ~/.bashrc file **"
if grep -q "export STARSHIP_CONFIG*" ~/.bashrc; then
    echo "starship config already exists in ~/.bashrc, skipping"
    echo ""
    echo ""
else
    echo "cat $PWD/bashrc-starship >> ~/.bashrc"
    echo ".bashrc updated..."
    sleep .5
fi
sleep 2

# Copying starship.toml file to ~/.config/
echo "** Copying starship.toml file to ~/.config folder **"
if [ -f ~/.config/starship.toml ]; then
    echo "starship.toml file already exist in ~/-config/, skipping"
    echo ""
    echo ""
else
    mkdir -p ~/.config && cp $PWD/starship.toml ~/.config/starship.toml
    echo "starship.toml copied to ~/.config/"
    sleep .5
fi

echo ""
echo ""
echo "All done! You now have docker, curl, git, htop, ifconfig, starship-shell,"
echo "Chromium, Studio Code and zero-tier installed"
