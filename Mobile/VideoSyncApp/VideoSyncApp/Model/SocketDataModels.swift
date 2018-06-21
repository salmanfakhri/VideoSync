//
//  SocketDataModels.swift
//  VideoSyncApp
//
//  Created by Salman Fakhri on 6/5/18.
//  Copyright © 2018 Salman Fakhri. All rights reserved.
//

import Foundation
import SocketIO

struct UserData : SocketData {
    let username: String
    let roomID: String
    
    func socketRepresentation() -> SocketData {
        return ["username": username, "roomID": roomID]
    }
}

struct VideoData : SocketData {
    let url: String
    let roomID: String
    func socketRepresentation() -> SocketData {
        return ["url": url, "roomID": roomID]
    }
}

struct EventData: SocketData {
    let type: String
    let time: String
    let roomID: String
    func socketRepresentation() -> SocketData {
        return ["type": type, "time": time, "roomID": roomID]
    }
}

struct EndpointData: Codable {
    let url: String
}

struct Connection {
    let name: String
}

struct SampleVideo {
    let thumbnail: UIImage
    let title: String
    let creator: String
    let url: String
}
