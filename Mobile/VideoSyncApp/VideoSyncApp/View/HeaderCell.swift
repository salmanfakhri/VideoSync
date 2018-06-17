//
//  HeaderCell.swift
//  VideoSyncApp
//
//  Created by Salman Fakhri on 6/13/18.
//  Copyright © 2018 Salman Fakhri. All rights reserved.
//

import UIKit

// MARK: HeaderButtonsProtocol
protocol HeaderCellDelegate : class {
    func didSelectVideoButton()
}


// MARK: Main
class HeaderCell: UITableViewCell {
    
    static var reuseIdentifier = "headerCell"
    
    var titleLabel: UILabel?
    var infoLabel: UILabel?
    var leaveButton: UIButton?
    var addVideoButton: UIButton?
    
    weak var delegate: HeaderCellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setUpTitleLabel(roomID: "Room Name")
        setUpInfoLabel(detail: "This is information")
        setUpAddVideoButton()
        setUpLeaveButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UI Setup
extension HeaderCell {
    
    func setUpTitleLabel(roomID: String) {
        titleLabel = UILabel()
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel!)
        titleLabel?.text = roomID
        titleLabel?.textColor = .black
        titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 20)
        titleLabel?.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        titleLabel?.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -15).isActive = true
    }
    
    func setUpInfoLabel(detail: String) {
        infoLabel = UILabel()
        infoLabel?.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(infoLabel!)
        infoLabel?.text = detail
        infoLabel?.textColor = .darkGray
        infoLabel?.font = UIFont(name: "AvenirNext", size: 10)
        infoLabel?.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        infoLabel?.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 15).isActive = true
    }
    
    func setUpLeaveButton() {
        //36 32 56 dark purple
        leaveButton = UIButton()
        leaveButton?.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(leaveButton!)
        if let rightAnchor = addVideoButton?.leftAnchor {
            leaveButton?.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        }
        leaveButton?.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        leaveButton?.heightAnchor.constraint(equalToConstant: 40).isActive = true
        leaveButton?.widthAnchor.constraint(equalToConstant: 70).isActive = true
        leaveButton?.titleLabel?.textAlignment = .center
        leaveButton?.setTitle("LEAVE", for: .normal)
        leaveButton?.titleLabel?.textColor = .white
        leaveButton?.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 13)
        let primary  = UIColor(displayP3Red: 36/255, green: 32/255, blue: 56/255, alpha: 1.0)
        leaveButton?.backgroundColor = primary
        leaveButton?.layer.cornerRadius = 20
        leaveButton?.layer.masksToBounds = true
//        connectButton?.addTarget(self, action: #selector(onConnectTap), for: .touchUpInside)
    }
    
    func setUpAddVideoButton() {
        //36 32 56 dark purple
        addVideoButton = UIButton()
        addVideoButton?.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(addVideoButton!)
        addVideoButton?.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
        addVideoButton?.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        addVideoButton?.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addVideoButton?.widthAnchor.constraint(equalToConstant: 70).isActive = true
        addVideoButton?.titleLabel?.textAlignment = .center
        addVideoButton?.setTitle("VIDEO", for: .normal)
        addVideoButton?.titleLabel?.textColor = .white
        addVideoButton?.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 13)
        let primary  = UIColor(displayP3Red: 114/255, green: 90/255, blue: 193/255, alpha: 1.0)
        addVideoButton?.backgroundColor = primary
        addVideoButton?.layer.cornerRadius = 20
        addVideoButton?.layer.masksToBounds = true
        addVideoButton?.addTarget(self, action: #selector(onVideoTap), for: .touchUpInside)
    }
    
    @objc func onVideoTap() {
        delegate?.didSelectVideoButton()
    }
}
