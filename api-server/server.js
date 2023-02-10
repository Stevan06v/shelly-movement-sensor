const express = require('express');
const app = express();
const port = 3000;


const axios = require('axios');
const { log } = require('console');

async function turnOffRelay() {
    try {
        const response = await axios.post('http://192.168.0.12/relay/0/?turn=off', {
            turn: "off"
        });
        console.log(response.data);
    } catch (error) {
        console.error(error);
    }
}

async function turnOnRelay() {
    try {
        const response = await axios.post('http://192.168.0.12/relay/0/?turn=on', {
            turn: "on"
        });
        console.log(response.data);
    } catch (error) {
        console.error(error);
    }
}


async function turnOffRGBLights() {
    try {
        const response = await axios.post('http://192.168.0.13/color/0?turn=off', {
            turn: "off"
        });
        console.log(response.data);
    } catch (error) {
        console.error(error);
    }
}

async function turnOnRGBLights() {
    try {
        const response = await axios.post('http://192.168.0.13/color/0?turn=on', {
            turn: "on"
        });
        console.log(response.data);
    } catch (error) {
        console.error(error);
    }
}


app.get('/getMovement', (req, res) => {
    const value = req.query.value
    if(value == 1){
        turnOnRGBLights()
        turnOnRelay()
        res.send("deteced")
    }else{
        turnOffRGBLights()
        turnOffRelay()
        res.send("not detected")
    }

    console.log(value)
})



app.listen(port, function (err) {
    if (err) {
        console.log(err);
    } else {
        console.log("Server starting...");
        console.log("Server is Listening now at: " + `http://localhost:${port}`);
    }
})
