//
//  LoginView.swift
//  VideoSyncApp
//
//  Created by Salman Fakhri on 6/14/18.
//  Copyright © 2018 Salman Fakhri. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    // MARK: Subviews
    
    let gradientLayer: CAGradientLayer = {
        //114 90 193 dark purple
        //141 134 201 light purple
        let layer = CAGradientLayer()
        let secondary  = UIColor(displayP3Red: 114/255, green: 90/255, blue: 193/255, alpha: 1.0).cgColor
        let primary  = UIColor(displayP3Red: 141/255, green: 134/255, blue: 201/255, alpha: 1.0).cgColor
        layer.colors = [primary, secondary]
        return layer
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "VideoSync"
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-Bold", size: 30)
        return label
    }()
    
    let roomIDField: UITextField = {
        let field = UITextField()
        field.placeholder = "Room ID"
        field.textColor = .white
        field.font = UIFont(name: "AvenirNext", size: 17)
        field.textAlignment = .center
        return field
    }()
    
    let userNameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username"
        field.textColor = .white
        field.font = UIFont(name: "AvenirNext", size: 17)
        field.textAlignment = .center
        return field
    }()
    
    let connectButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textAlignment = .center
        button.setTitle("connect", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont(name: "AvenirNext", size: 17)
        button.backgroundColor = UIColor(displayP3Red: 63/255, green: 50/255, blue: 106/255, alpha: 1.0)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        return button
    }()
    
    func createGradientLayer() {
        gradientLayer.frame = self.bounds
        self.layer.addSublayer(gradientLayer)
    }
    
    func titleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -120).isActive = true
    }
    
    func idFieldConstrains() {
        roomIDField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(roomIDField)
        roomIDField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -60).isActive = true
        roomIDField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func userNameFieldConstraints() {
        userNameField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(userNameField)
        userNameField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        userNameField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func connectButtonConstraints() {
        connectButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(connectButton)
        connectButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        connectButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 60).isActive = true
        connectButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        connectButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createGradientLayer()
        titleLabelConstraints()
        idFieldConstrains()
        userNameFieldConstraints()
        connectButtonConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
