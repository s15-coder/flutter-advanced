const path = require("path");
const express = require("express");
const app = express();

//Enable enviroment variables
require("dotenv").config();

//Create http server and make it compatible with express
const server = require("http").createServer(app);

//Enable sockets
module.exports.io = require("socket.io")(server);
require("./sockets/socket");
//Enable public directory
const publicPath = path.resolve(__dirname, "public");
app.use(express.static(publicPath));

server.listen(process.env.PORT, (e) => {
  if (e) throw new Error(e);

  console.log("Conectado al puerto ", process.env.PORT);
});
