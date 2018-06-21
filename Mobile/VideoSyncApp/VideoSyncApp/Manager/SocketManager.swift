//
//  SocketManager.swift
//  VideoSyncApp
//
//  Created by Salman Fakhri on 6/5/18.
//  Copyright © 2018 Salman Fakhri. All rights reserved.
//

import Foundation
import SocketIO
import YouTubePlayer

protocol SocketEventDelegate {
    func didGetConnectionsData(connections: [Connection])
    func receivedLoadVideoEvent(url: String)
    func receivedPauseEvent(forTime time: Float)
    func receivedPlayEvent(forTime time: Float)
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
        
        socket?.on("playerEvent", callback: { (data, awk) in
            print("got player event")
            if let eventData = data[0] as? [String: Any] {
                guard let type = eventData["type"] as? String else { return }
                guard let time = eventData["time"] as? Float else { return }
                self.handleEvent(type: type, time: time)
                print(eventData)
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
    
    func handleEvent(type: String, time: Float) {
        switch type {
        case YouTubePlayerState.Paused.rawValue:
            print("event: paused")
            eventDelegate?.receivedPauseEvent(forTime: time)
        case YouTubePlayerState.Playing.rawValue:
            print("event: playing")
            eventDelegate?.receivedPlayEvent(forTime: time)
        case YouTubePlayerState.Buffering.rawValue:
            print("event: Buffering")
        case YouTubePlayerState.Ended.rawValue:
            print("event: ended")
        case YouTubePlayerState.Unstarted.rawValue:
            print("event: unstarted")
        default:
            print("event: unknown event")
        }
    }
    
    func pushVideoWith(url: String) {
        guard let roomID = currentUser?.roomID else { return }
        let data = VideoData(url: url, roomID: roomID)
        self.socket?.emit("pushVideo", data)
    }
    
    func pushEvent(state: YouTubePlayerState, time: String) {
        guard let roomID = currentUser?.roomID else { return }
        let data = EventData(type: state.rawValue, time: time, roomID: roomID)
        self.socket?.emit("playerStateChanged", data)
    }
    
}
