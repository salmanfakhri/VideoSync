//
//  SocketManager.swift
//  VideoSyncApp
//
//  Created by Salman Fakhri on 6/5/18.
//  Copyright © 2018 Salman Fakhri. All rights reserved.
//

import Foundation
import SocketIO

class SocketClientManager {
    let manager = SocketManager(socketURL: URL(string: "https://86bafa43.ngrok.io")!)
    var socket: SocketIOClient?
    
    static let sharedInstance = SocketClientManager()
    
    func addHandlers() {
        socket = manager.defaultSocket
        print("attempting to connect")
        socket?.connect()
        
        socket?.on(clientEvent: .connect) {data, ack in
            self.socket?.emit("userConnected", CustomData(username: "salamander1012", roomID: "504"))
            print("socket connected")
        }
        
        socket?.on("printData", callback: { (data, awk) in
            print("got printData event")
            print(data)
        })
        
        
    }
}
