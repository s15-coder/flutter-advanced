const { io } = require("../index");
io.on("connection", (client) => {
  console.log("Client connected");

  client.on("disconnect", () => {
    console.log("Client has gone!");
  });
  client.on("message", (data) => {
    console.log("New Data:", data);
    io.emit("message", { admin: "New message!" });
  });
});
