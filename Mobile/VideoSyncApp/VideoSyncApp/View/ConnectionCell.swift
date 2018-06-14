//
//  ConnectionCell.swift
//  VideoSyncApp
//
//  Created by Salman Fakhri on 6/13/18.
//  Copyright © 2018 Salman Fakhri. All rights reserved.
//

import UIKit

// MARK: Main
class ConnectionCell: UITableViewCell {

    static var reuseIdentifier = "connectionCell"
    
    var titleLabel: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setUpTitleLabel(roomID: "User")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UI Setup
extension ConnectionCell {
    func setUpTitleLabel(roomID: String) {
        titleLabel = UILabel()
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel!)
        titleLabel?.text = roomID
        titleLabel?.textColor = .black
        titleLabel?.font = UIFont(name: "AvenirNext", size: 15)
        titleLabel?.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        titleLabel?.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}
