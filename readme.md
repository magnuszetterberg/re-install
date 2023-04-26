# re-install

a git repo for setting up your computer with the needed tools and utilities which I personally always have to add manually after a re-install of my linux computer.


## setup.sh

This file installs all the tools which I need to most, aswell as downloads the other configurations files which the setup.sh file needs to completely run.

This file is quite brutal in it's approach - it does not have any arguments it accepts or anything, so us this at your own risk. It does however, check if some configs or folders already exists, and if they do, it skips that part of the file copying.

## How to run the script directly through your bash terminal

Simply copy/paste this in your terminal 

    curl https://raw.githubusercontent.com/magnuszetterberg/re-install/main/setup.sh | bash


It first installs

    - docker-compose
    - net-tools
    - curl
    - git

It then downloads through curl

    https://raw.githubusercontent.com/magnuszetterberg/re-install/main/starship.toml
    
    https://raw.githubusercontent.com/magnuszetterberg/re-install/main/bashrc-starship
    
    https://raw.githubusercontent.com/magnuszetterberg/re-install/main/readme.md



it then sets up a ssh-key on you machine

    ssh-keygen

It then refreshes your snap store

    - snap refresh

and then installs through snap

    - code
    - chromium


It then runs a curl command to install zero-tier

    curl -s https://install.zerotier.com | sudo bash

Then it installs starship shell

    curl -sS https://starship.rs/install.sh | sh

Then it copies the configuration for starship into your ~/ dir

        echo "cat .bashrc-starship >> ~/.bashrc"

        mkdir -p ~/.config && cp starship.toml ~/.config/starship.toml
