#!/bin/bash


# refresh system first
echo "** Updateing apt and upgrading**"
echo ""
echo ""
sudo apt update && sudo apt upgrade -y && sudo apt autoremove
echo ""
echo ""
sleep 2
#install usefull tools!
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

# create new ssh-key
echo "** creating ssh-key **"
echo ""
echo ""
#ssh-keygen
sleep 2

# refresh snap
echo "** refreshing snap store **"
echo ""
echo ""
sudo snap refresh
sleep 2
# install snaps
echo "** installing snap tools **"
echo ""
echo ""
sudo snap install \
 chromium \
 code \
sleep 2

#Setup zero-tier network
echo "** installing zero-tier client **"
echo ""
echo ""
curl -s https://install.zerotier.com | sudo bash

sleep 2
