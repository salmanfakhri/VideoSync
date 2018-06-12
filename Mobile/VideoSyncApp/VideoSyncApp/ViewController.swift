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

class ViewController: UIViewController {
    
    
    
    var ytp: YouTubePlayerView?
    var usersTableView: UITableView?
    
    var connections: [Connection] = [Connection(name: "salman")] {
        didSet {
            print("changed connections data")
            print(connections)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUsersTableView()
        setUpSocket()
        setUpYoutubePlayer()
        
        view.backgroundColor = .white
        
        loadVideoWithURL(urlString: "https://www.youtube.com/watch?v=hHApdmoYsY8")
        
    }
}

// MARK: YoutubePlayer Delegate
extension ViewController: YouTubePlayerDelegate {
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        print(playerState)
    }
}

// MARK: UsersTableView Delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId")
        cell?.textLabel?.text = connections[indexPath.row].name
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return connections.count
    }
}

// MARK: Socket Delegate
extension ViewController: SocketEventDelegate {
    func didGetConnectionsData(connections: [Connection]) {
        self.connections = connections
        //print(self.connections)
        DispatchQueue.main.async {
            self.usersTableView?.reloadData()
        }
    }
}

// MARK: Page Setup
extension ViewController {
    func loadVideoWithURL(urlString: String) {
        if let url = URL(string: urlString), let player = ytp {
            player.loadVideoURL(url)
        }
    }
    
    func setUpSocket() {
        SocketClientManager.sharedInstance.setUpSocketManger()
        SocketClientManager.sharedInstance.connectSocket()
        SocketClientManager.sharedInstance.addHandlers()
        SocketClientManager.sharedInstance.eventDelegate = self
    }
    
    func setUpYoutubePlayer() {
        ytp = YouTubePlayerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 350))
        ytp?.playerVars["playsinline"] = "1" as AnyObject?
        view.addSubview(ytp!)
        ytp?.delegate = self
    }
    
    func setUpUsersTableView() {
        usersTableView = UITableView()
        usersTableView?.delegate = self
        usersTableView?.dataSource = self
        usersTableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        usersTableView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usersTableView!)
        let tableViewConstraints: [NSLayoutConstraint] = [
            NSLayoutConstraint(item: usersTableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 350),
            NSLayoutConstraint(item: usersTableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: usersTableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: usersTableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        ]
        tableViewConstraints.forEach { $0.isActive = true }
        view.addConstraints(tableViewConstraints)
        
    }
}

