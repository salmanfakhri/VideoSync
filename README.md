# VideoSync
An app for synchronized youtube video playback.

![showcase](showcase.png) 

## Getting Started
These instructions will get a copy of the project up and running on your local machine.

### Prerequisites
Make sure you have Xcode as well as the following dependencies installed before attempting to install this project

- Cocoapods
- Node.js

You can install Cocoapods using the following command  
 
`sudo gem install cocoapods`

To install Node go [here](https://nodejs.org/en/) and follow the download instructions.

### Installing
First clone the repository  

`git clone https://github.com/Salamander1012/VideoSync.git`

Next navigate to the Server directory and install the node dependencies  

`npm install`

Next navigate to the VideoSyncApp directory inside Mobile and install the pods  

`pod install`  

Cool you now have everything installed. Before we run the app in xcode make sure to start up the server. To do this navigate back to the Server directory use the following command  

`node index.js`

Finally open the VideoSyncApp.xcworkspace file in xcode and run the project.

## Server Dependencies

[Node.js](https://nodejs.org/en/)  
[Express.js](https://expressjs.com/)  
[Socket.io](https://socket.io/)  

## Mobile Dependencies

[SocketIO Swift Client](https://github.com/socketio/socket.io-client-swift)  
[Alamofire](https://github.com/Alamofire/Alamofire)  
[Youtube Video Player](https://github.com/gilesvangruisen/Swift-YouTube-Player)  

