# re-install

a git repo for setting up your computer with the needed tools and utilities which I personally always have to add manually after a re-install of my linux computer. 

Have only been tested on Ubuntu 23.04, and on win10 wls, but should work just fine on any linux dist - there is no magic being done here, just a dumb bash script installing stuff...


## setup.sh

This file installs all the tools which I need to most, aswell as downloads the other configurations files which the setup.sh file needs to completely run.

This file is quite brutal in it's approach - it does not accept any arguments(besides asking for confirmation before starting) so use this at your own risk. It does however, check if configs/applications exists, and if they do, it skips that part of the installation/file copying.

## How to run the script directly through your bash terminal

run these two commands

    wget https://raw.githubusercontent.com/magnuszetterberg/re-install/main/setup.sh && \
    bash setup.sh

It first installs

    - docker-compose
    - net-tools
    - curl
    - git
    - htop

It then downloads nerdfonts to your local directory the script was run from, and then unpacks the .zip file to ~/.fonts
    
    wget -N https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/JetBrainsMono.zip

Then it refreshes the font-cache on your computer

    fc-cache -f -v ~/.fonts

It then downloads starship configs through wget along with this readme.md file

    https://raw.githubusercontent.com/magnuszetterberg/re-install/main/starship.toml
    
    https://raw.githubusercontent.com/magnuszetterberg/re-install/main/bashrc-starship
    
    https://raw.githubusercontent.com/magnuszetterberg/re-install/main/readme.md



it then sets up a ssh-key on you machine

    ssh-keygen

It then refreshes your snap store

    - snap refresh

and then installs snap apps

    - code
    - chromium
    - mqtt-explorer


It then runs a curl command to install zero-tier

    curl -s https://install.zerotier.com | sudo bash

Then it installs starship shell

    curl -sS https://starship.rs/install.sh | sh

Then it copies the configuration for starship into your ~/.config folder and appends settings to your ~/.bashrc
