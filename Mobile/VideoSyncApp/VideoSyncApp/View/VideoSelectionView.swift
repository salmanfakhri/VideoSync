//
//  VideoSelectionView.swift
//  VideoSyncApp
//
//  Created by Salman Fakhri on 6/17/18.
//  Copyright © 2018 Salman Fakhri. All rights reserved.
//

import UIKit

class VideoSelectionView: UIView {
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textAlignment = .center
        button.setTitle("x", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont(name: "AvenirNext-Demibold", size: 20)
        button.backgroundColor = UIColor(displayP3Red: 36/255, green: 32/255, blue: 56/255, alpha: 1.0)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        return button
    }()
    
    let watchButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textAlignment = .center
        button.setTitle("WATCH", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 13)
        button.backgroundColor = UIColor(displayP3Red: 114/255, green: 90/255, blue: 193/255, alpha: 1.0)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        return button
    }()
    
    let urlField: VideoURLField = {
        let field = VideoURLField()
        field.placeholder = "Enter youtube video url"
        field.backgroundColor = UIColor(displayP3Red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        field.layer.cornerRadius = 20
        field.keyboardType = .URL
        return field
    }()
    
    func closeButtonConstraints() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(closeButton)
        closeButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func watchButtonConstraints() {
        watchButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(watchButton)
        watchButton.rightAnchor.constraint(equalTo: closeButton.leftAnchor, constant: -10).isActive = true
        watchButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        watchButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        watchButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    func urlFieldConstraints() {
        urlField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(urlField)
        urlField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        urlField.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        urlField.rightAnchor.constraint(equalTo: watchButton.leftAnchor, constant: -10).isActive = true
        urlField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        closeButtonConstraints()
        watchButtonConstraints()
        urlFieldConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class VideoURLField: UITextField {
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 13, 0, 10))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 13, 0, 10))
    }
}
