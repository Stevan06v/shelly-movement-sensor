#!/bin/bash

clear

echo "
   ____ ___  _   _ _____ ___ ____        ____ _____ _   _ _____ ____      _  _____ ___  ____
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

echo "Type in the password for [$ssid]: "
read psk

echo "---------------------------------"

echo "Type in the ip-address of your server: "
read ipaddr

echo "---------------------------------"

echo "Type in the port of your server: "
read port

clear

function wirteConfigFile {
    json='{"device": "'"$device"'","ssid": "'"$ssid"'","psk": "'"$psk"'","server": "'"$ipaddr"'","port":"'"$port"'","devices":['
    
    echo $json > "../config/config.json"
    
    echo "How much devices do you want to manage (1-...):"
    read devices
    
    count=1
    
    while [ $count -le $devices ]
    do
        echo "Device[$count] type: "
        
        echo "[1]: Shelly 1/... WiFi Relay Switch"
        echo "[2]: Shelly RGBW2 Wireless"
        read -p "Enter your selection: " selection
        
        if [ $selection -eq 1 ]; then
            devicetype="relay"
            elif [ $selection -eq 2 ]; then
            devicetype="rgb"
        fi
        
        echo "---------------------------------"
        echo "Device[$count] ip-address: "
        read deviceip
        
        if [ $count -lt $devices ];then
            echo '{"type": "'"$devicetype"'","ip": "'"$deviceip"'"},' >> "../config/config.json"
        else
            echo '{"type": "'"$devicetype"'","ip": "'"$deviceip"'"}' >> "../config/config.json"
        fi
        
        clear
        
        count=$((count + 1))
    done
    echo "]}" >> "../config/config.json"
    echo "JSON-CONFIGURATION SUCCESSFULLY CREATED!"
    cat "../config/config.json"
}

DIR="../config/"

function createConfigFile {
    touch config.json
    mv config.json ../config/
}

if [ -d "$DIR" ]; then
    echo "exists"
    createConfigFile
    wirteConfigFile
else
    mkdir config
    mv config ../
    createConfigFile
    wirteConfigFile
fi