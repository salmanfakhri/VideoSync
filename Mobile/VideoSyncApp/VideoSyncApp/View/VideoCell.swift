//
//  VideoCell.swift
//  VideoSyncApp
//
//  Created by Salman Fakhri on 6/17/18.
//  Copyright © 2018 Salman Fakhri. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {
    
    static var reuseIdentifier = "videoCell"
    
    var thumbnail: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "titleLabel"
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext", size: 10)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        return label
    }()
    
    var creatorLabel: UILabel = {
        let label = UILabel()
        label.text = "creatorLabel"
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext", size: 5)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        return label
    }()
    
    func setUpCell(video: SampleVideo) {
        thumbnail.image = video.thumbnail
        titleLabel.text = video.title
        creatorLabel.text = video.creator
    }
    
    func setUpThumbnail() {
        thumbnail.translatesAutoresizingMaskIntoConstraints = false
        addSubview(thumbnail)
        thumbnail.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        thumbnail.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        thumbnail.heightAnchor.constraint(equalToConstant: 90).isActive = true
        thumbnail.widthAnchor.constraint(equalToConstant: 160).isActive = true
        thumbnail.contentMode = .scaleAspectFill
    }
    
    func setUpTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: thumbnail.rightAnchor, constant: 15).isActive = true
        titleLabel.topAnchor.constraint(equalTo: thumbnail.topAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
    }
    
    func setUpCreatorLabel() {
        creatorLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(creatorLabel)
        creatorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        creatorLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        creatorLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpThumbnail()
        setUpTitleLabel()
        setUpCreatorLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


