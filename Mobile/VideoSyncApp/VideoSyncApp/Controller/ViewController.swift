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
    
    
    var loadView: UIView?
    var ytp: YouTubePlayerView?
    var usersTableView: UITableView?
    var connections: [Connection] = [Connection(name: "salman"), Connection(name: "salman"), Connection(name: "salman"), Connection(name: "salman"), Connection(name: "salman")] {
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
        //loadVideoWithURL(urlString: "https://www.youtube.com/watch?v=hHApdmoYsY8")
        
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
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.reuseIdentifier) as? HeaderCell {
                return cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ConnectionCell.reuseIdentifier) as? ConnectionCell {
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
//        SocketClientManager.sharedInstance.setUpSocketManger()
//        SocketClientManager.sharedInstance.connectSocket()
//        SocketClientManager.sharedInstance.addHandlers()
        SocketClientManager.sharedInstance.eventDelegate = self
    }
    
    func setUpLoadView() {
        loadView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 250))
        loadView?.backgroundColor = UIColor(displayP3Red: 141/255, green: 134/255, blue: 201/255, alpha: 1.0)
        let loadLabel = UILabel()
        
    }
    
    func setUpYoutubePlayer() {
        ytp = YouTubePlayerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 250))
        ytp?.playerVars["playsinline"] = "1" as AnyObject?
        view.addSubview(ytp!)
        ytp?.delegate = self
    }
    
    func setUpUsersTableView() {
        usersTableView = UITableView()
        usersTableView?.delegate = self
        usersTableView?.dataSource = self
        usersTableView?.register(ConnectionCell.self, forCellReuseIdentifier: ConnectionCell.reuseIdentifier)
        usersTableView?.register(HeaderCell.self, forCellReuseIdentifier: HeaderCell.reuseIdentifier)
        usersTableView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usersTableView!)
        let tableViewConstraints: [NSLayoutConstraint] = [
            NSLayoutConstraint(item: usersTableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 250),
            NSLayoutConstraint(item: usersTableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: usersTableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: usersTableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        ]
        tableViewConstraints.forEach { $0.isActive = true }
        view.addConstraints(tableViewConstraints)
        
    }
}

