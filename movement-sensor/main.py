# Bibliotheken laden
from machine import Pin
from utime import sleep
import json
import network
import urequests

ssid =""
psk =""

# read config-data 
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


def sendStatus(value):
    url = 'http://192.168.0.163:3000/getMovement?value='+str(value)
    response = urequests.get(url)
    print(response.text)
    if response.text == "detected":
        sleep(30)

# Initialisierung des PIR-Moduls
pir = Pin(21, Pin.IN, Pin.PULL_DOWN)

while True:
    sleep(3)
    pir_value = pir.value()
    sendStatus(pir_value)
    print(pir_value)
    

