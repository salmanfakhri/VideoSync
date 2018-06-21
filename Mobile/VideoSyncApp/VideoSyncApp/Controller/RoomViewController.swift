//
//  ViewController.swift
//  VideoSyncApp
//
//  Created by Salman Fakhri on 6/5/18.
//  Copyright © 2018 Salman Fakhri. All rights reserved.
//

import UIKit
import SocketIO
import YouTubePlayer

class RoomViewController: UIViewController {
    
    unowned var roomView: RoomView { return self.view as! RoomView }
    unowned var playerView: YouTubePlayerView { return roomView.playerView }
    unowned var usersTableView: UITableView { return roomView.usersTableView }
    
    lazy var videoSelectionLauncher = VideoSelectionLauncher()
    
    var roomName: String?
    
    var connections: [Connection] = [] {
        didSet {
            print("changed connections data")
            print(connections)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = RoomView(frame: view.frame)
        usersTableView.dataSource = self
        videoSelectionLauncher.delegate = self
        setUpPlayerView()
        setUpSocket()
        view.backgroundColor = .white
        loadVideoWithURL(urlString: "https://www.youtube.com/watch?v=hHApdmoYsY8")
    }
}

// MARK: YoutubePlayer Delegate
extension RoomViewController: YouTubePlayerDelegate {
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        print(playerState)
        let time = playerView.getCurrentTime() ?? "notime"
        SocketClientManager.sharedInstance.pushEvent(state: playerState, time: time)
    }
}

// MARK: UsersTableView DataSource
extension RoomViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.reuseIdentifier) as? HeaderCell {
                cell.delegate = self
                if let name = roomName {
                    cell.titleLabel?.text = name
                }
                cell.infoLabel?.text = "\(connections.count) connections present"
                return cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ConnectionCell.reuseIdentifier) as? ConnectionCell {
                cell.titleLabel?.text = connections[indexPath.row].name
                return cell
            }
        }
        return UITableViewCell()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return connections.count
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100
        default:
            return 60
        }
    }
}

// MARK: Socket Delegate
extension RoomViewController: SocketEventDelegate {
    // TODO: fix bug cyclic bug caused by state change 
    func receivedPauseEvent(forTime time: Float) {
        playerView.pause()
    }
    
    func receivedPlayEvent(forTime time: Float) {
        playerView.seekTo(time, seekAhead: true)
        playerView.play()
    }
    
    func receivedLoadVideoEvent(url: String) {
        loadVideoWithURL(urlString: url)
    }
    
    func didGetConnectionsData(connections: [Connection]) {
        self.connections = connections
        DispatchQueue.main.async {
            self.usersTableView.reloadData()
        }
    }
}

// MARK: HeaderCellDelegate

extension RoomViewController: HeaderCellDelegate {
    func didSelectVideoButton() {
        videoSelectionLauncher.showSelectionView()
    }
}

// MARK: VideoSelectionDelegate

extension RoomViewController: VideoSelectionDelegate {
    func didSelectVideoWith(url: String) {
        SocketClientManager.sharedInstance.pushVideoWith(url: url)
    }
    
    
}

// MARK: Page Setup
extension RoomViewController {
    func loadVideoWithURL(urlString: String) {
        if let url = URL(string: urlString) {
            playerView.loadVideoURL(url)
        }
    }
    
    func setUpPlayerView() {
        playerView.playerVars["playsinline"] = "1" as AnyObject?
        playerView.delegate = self
    }
    
    func setUpSocket() {
        SocketClientManager.sharedInstance.eventDelegate = self
    }
}

