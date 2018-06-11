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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SocketClientManager.sharedInstance.setUpSocketManger()
        SocketClientManager.sharedInstance.addHandlers()
        
        ytp = YouTubePlayerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 400))
        ytp?.playerVars["playsinline"] = "1" as AnyObject?
        view.addSubview(ytp!)
        
        
        
        playVideoWithURL(urlString: "https://www.youtube.com/watch?v=hHApdmoYsY8")
        
    }
    
    func playVideoWithURL(urlString: String) {
        if let url = URL(string: urlString), let player = ytp {
            player.loadVideoURL(url)
            while player.ready == false {}
            player.play()
        }
    }


}

