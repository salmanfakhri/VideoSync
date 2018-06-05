var app = require('express')();
var server = require('http').Server(app);
var io = require('socket.io')(server);

var tempDB = {}

server.listen(8000, function() {
   console.log("Serving on port 8000");
});

app.get('/', function (req, res) {
  res.sendfile(__dirname + '/index.html');
});

io.on('connection', function (socket) {

  socket.on('userConnected', (data) => {
    if (!roomExists(data.roomID)) {
      createRoom(data.roomID, data.username);
    } else {
      addUserToRoom(data.roomID, data.username);
    }
    socket.join(data.roomID);
    console.log("New connection " + data.username + " connected to room " + data.roomID);
    // socket.emit('printData', tempDB);
    io.sockets.in(data.roomID).emit('printData', tempDB);
    console.log("connections: ");
    console.log(tempDB);
  });

  socket.on('userDisconnected', (data) => {
    removeUserFromRoom(data.roomID, data.username);
    // socket.in(data.roomID).emit('printData', tempDB);
    socket.leave(data.roomID);
    console.log("user disconnected: " + data.username);
    console.log("connections: ");
    console.log(tempDB);
  });

});

function roomExists(roomID) {
  return tempDB.hasOwnProperty(roomID);
}

function createRoom(roomID, username) {
  tempDB[roomID] = {
    connections: [
      {name: username}
    ]
  }
}

function addUserToRoom(roomID, username) {
  tempDB[roomID].connections.push({name: username});
}

function removeUserFromRoom(roomID, username) {
  var connections = tempDB[roomID].connections
  for(var i = 0; i < connections.length; i++) {
    if(connections[i].name === username) {
      connections.splice(i, 1);
      break;
    }
  }
}
