var app = require('express')();
var server = require('http').Server(app);
var io = require('socket.io')(server);

server.listen(8000, function() {
   console.log("Serving on port 8000");
});

app.get('/', function (req, res) {
  res.sendfile(__dirname + '/index.html');
});

io.on('connection', function (socket) { 
  
  socket.on('userConnected', (data) => {
    socket.join(data.roomID);
    console.log("New connection " + data.username + " connected to room " + data.roomID);
  });

  socket.on('userDisconnected', (username) => {
    console.log("user disconnected: " + username);
  });
 
});


