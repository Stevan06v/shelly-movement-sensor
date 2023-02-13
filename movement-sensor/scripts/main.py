from machine import Pin
from utime import sleep
import json
import network
import urequests

ssid =""
psk =""
server =""
port =""
devices = []

def devicesStatusJson(status, devices):
    try:
        data ={
            "status":status,
            "devices": json.loads(devices) 
        }
        print("-------------------------")
        print(data)
        print("-------------------------") 
        return data
    except:
        print("error occured while creating status string...")

def initDevices():
    try:
        devices = config['devices']
        print(devices)
    except:
        print("error occured while loading devices from ['config.json']");

try:
    with open('config.json') as config:
      data = json.load(config)
    print(data)
    
    # dumps the json object into an element
    json_str = json.dumps(data)

    # load the json to a string
    config = json.loads(json_str)

    ssid = config['ssid']
    psk = config['psk']
    server = config['server']
    port = config['port']
    
    devices = json.dumps(config['devices'])
    
    # loads the devices from json
    initDevices()
        
    print(server)
except:
    print("['config.json'] missing!")

wlan = network.WLAN(network.STA_IF)
def wlanConnect(ssid,psk):
    wlan.active(True)
    if psk != "" or ssid !="":
        print(ssid + ": " + psk)
        wlan.connect(ssid, psk)
        print(wlan.isconnected())
    else:
        print("Invalid WLAN-format!")

wlanConnect(ssid,psk) 
while wlan.isconnected() == False:
    print("Trying to connect to: " + ssid)
    wlanConnect(ssid,psk)
    sleep(3)
print("Successfully connected to " + ssid + "!")

def sendStatus(value):
    try:
        print(server + ":" + port)
        url = 'http://' + server + ':'+ port +'/getMovement?value=' + str(json.dumps(devicesStatusJson(value, devices)))
        print(url)
        response = urequests.get(url)
        print(response.text)
        if response.text == "detected":
            sleep(30)
    except:
        print(server + ":" + port + " is unreachable")
        print("Trying to reconnect...")

# Initialisierung des PIR-Moduls
pir = Pin(21, Pin.IN, Pin.PULL_DOWN)

while True:
    sleep(1)
    pir_value = pir.value()
    sendStatus(pir_value)
    print(pir_value)
    
