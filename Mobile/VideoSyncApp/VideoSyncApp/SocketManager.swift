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
    var manager: SocketManager?
    var socket: SocketIOClient?
    
    static let sharedInstance = SocketClientManager()
    
    func addHandlers() {
        guard let manager = manager else { return }
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
    
    func setUpSocketManger() {
        print("getting new socket url")
        if let path = Bundle.main.path(forResource: "url", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let content = try JSONDecoder().decode(EndpointData.self, from: data)
                if let url = URL(string: content.url) {
                    manager = SocketManager(socketURL: url)
                    print("got url")
                }
            } catch {
                print("error getting local file")
            }
        }
    }
}
