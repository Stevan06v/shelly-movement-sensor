const express = require('express');
const app = express();
const port = 3034;
const axios = require('axios');
const { log } = require('console');


async function toggleRelay(val,ip) {

    let switcher = val == 0 ? "off" : "on";

    console.log(switcher);

    try {
        const response = await axios.post(`http://${ip}/relay/0/?turn=${switcher}`, {
            turn: switcher
        });
        console.log(response.data);
    } catch (error) {
        console.error(error);
    }
}

async function toggleRGB(val,ip) {
    let switcher = val == 0 ? "off" : "on";

    try {
        const response = await axios.post(`http://${ip}/color/0?turn=${switcher}`, {
            turn: switcher
        });
        console.log(response.data);
    } catch (error) {
        console.error(error);
    }
}

app.get('/getMovement', (req, res) => {
    const data = JSON.parse(req.query.value)

    let status = data.status
    let devices = data.devices
    console.log(status);
    console.log(devices);


    for (let i = 0; i < devices.length; i++) {
        switch (devices[i].type) {
            case "relay":
                toggleRelay(status,devices[i].ip)
                break;
            case "rgb":
                toggleRGB(status,devices[i].ip)
                break;
        }
    }    
    res.send("deteced")
})


app.listen(port, (err) => {
    if (err) {
        console.log(err);
    } else {
        console.log("Server starting...");
        console.log("Server is Listening now at: " + `http://localhost:${port}`);
    }
})
