const express = require('express');
const path = require('path');
require('dotenv').config();

//Connect database 
require('./database/config').connectDB();

// App de Express
const app = express();

// Node Server
const server = require('http').createServer(app);
module.exports.io = require('socket.io')(server);
require('./sockets/socket');

//Enable obtain json body
app.use(express.json());
app.use(express.urlencoded({ extended: true }));



// Path público
const publicPath = path.resolve(__dirname, 'public');
app.use(express.static(publicPath));


//Listen routes
app.use('/api/login', require('./routes/auth'))


server.listen(process.env.PORT, (err) => {

    if (err) throw new Error(err);

    console.log('Servidor corriendo en puerto', process.env.PORT);

});