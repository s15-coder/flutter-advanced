const path = require("path");
const express = require("express");
const app = express();
require("dotenv").config();
const publicPath = path.resolve(__dirname, "public");

app.use(express.static(publicPath));

app.listen(process.env.PORT, (e) => {
  if (e) throw new Error(e);

  console.log("Conectado al puerto ", process.env.PORT);
});
