#!/bin/bash
clear
echo ""
echo "This will install apt packages, snap apps and install application from the internet over curl."
read -p "Do you want to continue? (Y/n)" choice
if [[ $choice =~ ^[Yy]$|^$ ]]; then

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
    echo "Adding user -> $USER <- to docker group(so that you dont have to use sudo)"
    sudo usermod -aG docker $USER
    echo ""
    echo ""
    sleep 2

    # Downloading nerdfonts to since starship-shell requries it
    echo "** Downloading nerdfonts(JetNrainsMono) **"
    wget -N https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/JetBrainsMono.zip
    echo ""
    echo ""
    echo "Unzipping file into ~/.fonts(Skipping if they already exists)"
    echo ""
    echo ""
    unzip -n JetBrainsMono.zip -d ~/.fonts
    echo ""
    echo ""
    echo "Now refreshing your font-cache..."
    fc-cache -f -v ~/.fonts
    echo ""
    echo ""

    # Now download the other config files from the repo
    echo "** Download config files from github **"
    echo ""
    echo ""
    wget -N https://raw.githubusercontent.com/magnuszetterberg/re-install/main/starship.toml
    wget -N https://raw.githubusercontent.com/magnuszetterberg/re-install/main/bashrc-starship
    wget -N https://raw.githubusercontent.com/magnuszetterberg/re-install/main/readme.md
    echo ""
    echo ""
    sleep 2

    # Create new ssh-key
    echo "** Creating ssh-key **"
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
        echo "One or several snap packages are not installed"
        echo "Installing now..."
        sudo snap install chromium code
    else
        echo "Snap packages are installed"
        echo ""
        echo ""
    fi

    #Setup zero-tier network
    echo "** Installing zero-tier client **"
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

else 
    echo "exiting script"
fi