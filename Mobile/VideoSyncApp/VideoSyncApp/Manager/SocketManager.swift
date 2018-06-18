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
    func receivedLoadVideoEvent(url: String)
}

class SocketClientManager {
    var manager: SocketManager?
    var socket: SocketIOClient?
    
    static let sharedInstance = SocketClientManager()
    var eventDelegate: SocketEventDelegate?
    
    var currentUser: UserData?
    
    func connectSocket(username: String, roomID: String, completion: @escaping () -> ()) {
        guard let manager = manager else { return }
        socket = manager.defaultSocket
        print("attempting to connect")
        socket?.connect()
        
        socket?.on(clientEvent: .connect) {data, ack in
            self.currentUser = UserData(username: username, roomID: roomID)
            self.socket?.emit("userConnected", self.currentUser!)
            print("socket connected")
            completion()
        }
    }
    
    func addHandlers() {
        socket?.on("roomConnectionsData", callback: { (data, awk) in
            print("got roomConnectionsData event")
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
        
        socket?.on("loadVideo", callback: { (data, awk) in
            print("got loadVideo event")
            if let urlData = data[0] as? [String: String] {
                if let url = urlData["url"] {
                    self.eventDelegate?.receivedLoadVideoEvent(url: url)
                }
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
    
    func pushVideoWith(url: String) {
        guard let roomID = currentUser?.roomID else { return }
        let data = VideoData(url: url, roomID: roomID)
        self.socket?.emit("pushVideo", data)
    }
}
