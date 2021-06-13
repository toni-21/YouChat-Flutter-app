var WebSocket = require("ws");
// var sqlite3 = require("sqlite3");
var port = process.env.PORT || 3000;

var server = new WebSocket.Server({
    host: 192.168,
    port: 3000,
})

let msg = "Server: Welcome"
console.log('listening on port %d', port);

server.on("connection", function connection(client) {
    client.send(msg);
    console.log('Connection established on port %d', port);
    client.on('message', function incoming(message) {
        msg = message;
        for (var cl of server.clients) {
            cl.send(message);
        }
        console.log("Received the following message:\n" + message);
    });
})