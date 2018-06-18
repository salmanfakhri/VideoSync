var app = require('express')();
var server = require('http').Server(app);
var io = require('socket.io')(server);
var fs = require('fs');
const ngrok = require('ngrok');


var tempDB = {}



server.listen(8000, function() {
  console.log("Serving on port 8000");
  (async function() {
    const url = await ngrok.connect(8000);
    console.log("Public url: " + url);
    updateMobileURL(url);
  })();
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
    io.sockets.in(data.roomID).emit('roomConnectionsData', tempDB[data.roomID].connections);
    console.log("connections: ");
    console.log(tempDB);
  });

  socket.on('userDisconnected', (data) => {
    removeUserFromRoom(data.roomID, data.username);
    io.sockets.in(data.roomID).emit('roomConnectionsData', tempDB[data.roomID].connections);
    socket.leave(data.roomID);
    console.log("user disconnected: " + data.username);
    console.log("connections: ");
    console.log(tempDB);
  });

  socket.on('pushVideo', (data) => {
    console.log("got pushVideo event");
    io.sockets.in(data.roomID).emit('loadVideo', {url: data.url});
  });

});



function updateMobileURL(url) {
  var data = fs.readFileSync('../Mobile/VideoSyncApp/url.json', 'utf-8');
  //console.log("Old: " + data);
  fs.writeFileSync('../Mobile/VideoSyncApp/url.json', '{"url":"' + url + '"}', 'utf-8');
  var newData = fs.readFileSync('../Mobile/VideoSyncApp/url.json', 'utf-8');
  //console.log("New: " + newData);
  console.log('Updated mobile endpoint with new url');
}

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
