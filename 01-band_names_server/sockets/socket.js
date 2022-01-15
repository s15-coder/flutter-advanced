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

    client.emit("active-bands", bands.getBands())

    client.on('vote-band', (payload) => {
        console.log(payload)
        bands.voteBand(payload.id)
        io.emit('active-bands', bands.getBands())
    })

    client.on('add-band', (payload) => {
        const newBand = new Band(payload.name)
        bands.addBand(newBand)
        io.emit('active-bands', bands.getBands())
    })

    client.on('delete-band', (paylod) => {
        bands.deleteBand(paylod.id);
        io.emit('active-bands', bands.getBands());
    })

    client.on("disconnect", () => {
        console.log("Client has gone!");
    });

    // client.on("new-message", (data) => {
    //     console.log(data)
    //     client.broadcast.emit("new-message", data);
    // });
});