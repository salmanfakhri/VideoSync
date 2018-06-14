//
//  SocketManager.swift
//  VideoSyncApp
//
//  Created by Salman Fakhri on 6/5/18.
//  Copyright © 2018 Salman Fakhri. All rights reserved.
//

import Foundation
import SocketIO

protocol SocketEventDelegate {
    func didGetConnectionsData(connections: [Connection])
}

class SocketClientManager {
    var manager: SocketManager?
    var socket: SocketIOClient?
    
    static let sharedInstance = SocketClientManager()
    var eventDelegate: SocketEventDelegate?
    
    var currentUser: UserData?
    
    func connectSocket() {
        guard let manager = manager else { return }
        socket = manager.defaultSocket
        print("attempting to connect")
        socket?.connect()
        
        socket?.on(clientEvent: .connect) {data, ack in
            self.currentUser = UserData(username: "salamander1012", roomID: "504")
            self.socket?.emit("userConnected", self.currentUser!)
            print("socket connected")
        }
    }
    
    func addHandlers() {
        socket?.on("roomConnectionsData", callback: { (data, awk) in
            print("got printData event")
            var connections: [Connection] = []
            if let connectionsData = data[0] as? [[String:String]] {
                connectionsData.forEach({
                    if let connectionName = $0["name"] {
                        connections.append(Connection(name: connectionName))
                    }
                })
                self.eventDelegate?.didGetConnectionsData(connections: connections)
            } else {
                print("Unable to decode connectionsData")
            }
        })
    }
    
    func setUpSocketManger() {
        if let path = Bundle.main.path(forResource: "url", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let content = try JSONDecoder().decode(EndpointData.self, from: data)
                if let url = URL(string: content.url) {
                    manager = SocketManager(socketURL: url)
                }
            } catch {
                print("error getting local file")
            }
        }
    }
    
    func handleDisconnection() {
        if let user = currentUser {
            self.socket?.emit("userDisconnected", user)
            self.socket?.disconnect()
        }
    }
}
