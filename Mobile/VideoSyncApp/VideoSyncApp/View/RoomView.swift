//
//  RoomView.swift
//  VideoSyncApp
//
//  Created by Salman Fakhri on 6/16/18.
//  Copyright © 2018 Salman Fakhri. All rights reserved.
//

import UIKit
import YouTubePlayer

class RoomView: UIView {
    
    let playerHeight = 250
    
    var playerView: YouTubePlayerView = {
        let player = YouTubePlayerView()
        return player
    }()
    
    let usersTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HeaderCell.self, forCellReuseIdentifier: HeaderCell.reuseIdentifier)
        tableView.register(ConnectionCell.self, forCellReuseIdentifier: ConnectionCell.reuseIdentifier)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpPlayerView()
        tableViewConstraints()
        usersTableView.delegate = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpPlayerView() {
        playerView = YouTubePlayerView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 250))
        addSubview(playerView)
    }
    
    func tableViewConstraints() {
        usersTableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(usersTableView)
        usersTableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 250).isActive = true
        usersTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        usersTableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        usersTableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    }

}

extension RoomView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100
        default:
            return 60
        }
    }
}
