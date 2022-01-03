const express = require("express");
const app = express();

app.listen(3000, (e) => {
  if (e) throw new Error(e);

  console.log("Conectado al puerto ", 3000);
});
