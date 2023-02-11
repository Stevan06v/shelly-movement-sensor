#!/bin/bash
DIR="/config/"

echo "   ____ ___  _   _ _____ ___ ____        ____ _____ _   _ _____ ____      _  _____ ___  ____   
  / ___/ _ \| \ | |  ___|_ _/ ___|      / ___| ____| \ | | ____|  _ \    / \|_   _/ _ \|  _ \  
 | |  | | | |  \| | |_   | | |  _ _____| |  _|  _| |  \| |  _| | |_) |  / _ \ | || | | | |_) | 
 | |__| |_| | |\  |  _|  | | |_| |_____| |_| | |___| |\  | |___|  _ <  / ___ \| || |_| |  _ <  
  \____\___/|_| \_|_|   |___\____|      \____|_____|_| \_|_____|_| \_\/_/   \_\_| \___/|_| \_\
                                                                                               ";

echo "How would you like to name your device: "
read device

echo "---------------------------------"

echo "Type in your WLAN-SSID(2.4GHz): "
read ssid

echo "---------------------------------"

echo "Type in the password for $ssid: "
read psk

echo "---------------------------------"

echo "Type in the ip-address of your server: "
read 

echo "---------------------------------"

echo "Type in the port of your server "
read port


if [ -d "$DIR" ]; then
    echo "exists"
    touch config.json
    mv config.json config
else
    mkdir config
fi