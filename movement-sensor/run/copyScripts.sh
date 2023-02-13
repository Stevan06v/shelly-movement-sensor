#!/bin/bash/

sudo apt install python3-pip # install pip3

sudo apt-get update && sudo apt full-upgrade -y # update and upgrade libs

sudo pip3 install adafruit-ampy # install ampy 

# define paths
DEVICE="/dev/ttyUSB0" # set serial-port-path
DEST_PATH="/pyboard"
FILES_PATH="../scripts/" # main.py-path
CONFIG_PATH="../config/config.json/" # config-file-path

# copy python-scripts to pico
for file in $FILES_PATH/*; do
  filename=$(basename "$file")
  echo "Copying $filename to $DEST_PATH"
  ampy --port $DEVICE put "$file" "$DEST_PATH/$filename"
done

echo "PYTHON-SCRIPTS COPIED TO [RASPBERRY-PI-PICO]"

# copy config.json to pico
ampy --port $DEVICE put $CONFIG_PATH "$DEST_PATH/config.json"
