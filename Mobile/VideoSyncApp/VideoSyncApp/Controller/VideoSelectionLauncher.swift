//
//  VideoSelectionLauncher.swift
//  VideoSyncApp
//
//  Created by Salman Fakhri on 6/17/18.
//  Copyright © 2018 Salman Fakhri. All rights reserved.
//

import Foundation
import UIKit

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
        selectionView.closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
    }
    
    @objc func didTapClose() {
        UIView.animate(withDuration: 0.1, animations: {
            self.selectionView.alpha = 0
        }) { (bool) in
            self.selectionView.removeFromSuperview()
        }
    }
}
