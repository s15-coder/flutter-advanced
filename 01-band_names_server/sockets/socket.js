const { io } = require("../index");
const Band = require("../models/band");
const Bands = require('../models/bands')
const bands = new Bands()

console.log('init server')
bands.addBand(new Band("Born Jamericans"));
bands.addBand(new Band("Bob Marley"));
bands.addBand(new Band("Canserbero"));
bands.addBand(new Band("Doble Porción"));

io.on("connection", (client) => {
    console.log("Client connected");

    client.emit("   ", bands.getBands())

    client.on("disconnect", () => {
        console.log("Client has gone!");
    });
    client.on("new-message", (data) => {
        console.log(data)
        client.broadcast.emit("new-message", data);
    });
});