//
//  SocketDataModels.swift
//  VideoSyncApp
//
//  Created by Salman Fakhri on 6/5/18.
//  Copyright © 2018 Salman Fakhri. All rights reserved.
//

import Foundation
import SocketIO

struct CustomData : SocketData {
    let username: String
    let roomID: String
    
    func socketRepresentation() -> SocketData {
        return ["username": username, "roomID": roomID]
    }
}

struct EndpointData: Codable {
    let url: String
}
