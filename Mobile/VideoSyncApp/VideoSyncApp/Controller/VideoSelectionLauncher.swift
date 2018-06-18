//
//  VideoSelectionLauncher.swift
//  VideoSyncApp
//
//  Created by Salman Fakhri on 6/17/18.
//  Copyright © 2018 Salman Fakhri. All rights reserved.
//

import Foundation
import UIKit

protocol VideoSelectionDelegate : class {
    func didSelectVideoWith(url: String)
}

class VideoSelectionLauncher: NSObject {
    
    let videos: [SampleVideo] = {
        let data = [
            SampleVideo(thumbnail: #imageLiteral(resourceName: "shimmer"), title: "Swift Animations: Facebook Shimmer using Gradient Masks", creator: "Let's Build That App", url: "https://www.youtube.com/watch?v=RRuQZSbueJE"),
            SampleVideo(thumbnail: #imageLiteral(resourceName: "storyboard"), title: "Not Using Storyboard Leads to Getting Hired as an iOS Developer", creator: "Let's Build That App", url: "https://www.youtube.com/watch?v=U1Ub-LFIqfA"),
            SampleVideo(thumbnail: #imageLiteral(resourceName: "generic"), title: "Advanced Swift Generics: Best Solution to Eliminate Code Duplication!", creator: "Let's Build That App", url: "https://www.youtube.com/watch?v=lpTNaBUFkno"),
            SampleVideo(thumbnail: #imageLiteral(resourceName: "zone"), title: "Getting out of your Coding Comfort Zone", creator: "Let's Build That App", url: "https://www.youtube.com/watch?v=lJf6ABLIufs"),
            SampleVideo(thumbnail: #imageLiteral(resourceName: "group"), title: "Brand New Swift 4 Grouping Function Solves all your Problems", creator: "Let's Build That App", url: "https://www.youtube.com/watch?v=poUZnT7N-Vk")
        ]
        return data
    }()
    
    let selectionView: VideoSelectionView = {
        let view = VideoSelectionView()
        view.backgroundColor = .white
        return view
    }()
    
    let spaceFromTop: CGFloat = 250
    
    weak var delegate: VideoSelectionDelegate?
    
    func showSelectionView() {
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(selectionView)
            selectionView.alpha = 0
            selectionView.frame = CGRect(x: 0, y: spaceFromTop, width: window.frame.width, height: window.frame.height - spaceFromTop)
            
            UIView.animate(withDuration: 0.1, animations: {
                self.selectionView.alpha = 1
            })
        }
    }
    
    override init() {
        super.init()
        setUpSelectionViewActions()
        selectionView.videosTableView.dataSource = self
        selectionView.videosTableView.delegate = self
    }
    
    func setUpSelectionViewActions() {
        selectionView.closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        selectionView.watchButton.addTarget(self, action: #selector(didTapWatch), for: .touchUpInside)
    }
    
    @objc func didTapClose() {
        closeView()
    }
    
    @objc func didTapWatch() {
        
    }
    
    func closeView() {
        UIView.animate(withDuration: 0.1, animations: {
            self.selectionView.alpha = 0
        }) { (bool) in
            self.selectionView.removeFromSuperview()
        }
    }
}

// MARK: VideoTableView DataSource

extension VideoSelectionLauncher: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: VideoCell.reuseIdentifier) as? VideoCell {
            cell.setUpCell(video: videos[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = videos[indexPath.row].url
        delegate?.didSelectVideoWith(url: url)
        closeView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}
