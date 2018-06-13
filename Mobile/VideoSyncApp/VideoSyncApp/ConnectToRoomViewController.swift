//
//  ConnectToRoomViewController.swift
//  VideoSyncApp
//
//  Created by Salman Fakhri on 6/12/18.
//  Copyright © 2018 Salman Fakhri. All rights reserved.
//

import UIKit

class ConnectToRoomViewController: UIViewController {
    
    var titleLabel: UILabel?
    var roomIDField: UITextField?
    var userNameField: UITextField?
    var connectButton: UIButton?
    var gradientLayer: CAGradientLayer?
    
    var touchRecognizer: UITapGestureRecognizer?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
        
        setUpIDField()
        setUpUserNameField()
        setUpTitleLabel()
        setUpConnectButton()
        
        setUpTouchGesture()
    }
    
    func setUpTouchGesture() {
        touchRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(touchRecognizer!)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func createGradientLayer() {
        //114 90 193 dark purple
        //141 134 201 light purple
        let secondary  = UIColor(displayP3Red: 114/255, green: 90/255, blue: 193/255, alpha: 1.0).cgColor
        let primary  = UIColor(displayP3Red: 141/255, green: 134/255, blue: 201/255, alpha: 1.0).cgColor
        gradientLayer = CAGradientLayer()
        gradientLayer?.frame = self.view.bounds
        gradientLayer?.colors = [primary, secondary]
        view.layer.addSublayer(gradientLayer!)
        navigationController?.isNavigationBarHidden = true
    }
    
    func setUpTitleLabel() {
        titleLabel = UILabel()
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel!)
        titleLabel?.text = "VideoSync"
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 30)
        titleLabel?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel?.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -120).isActive = true
    }
    
    func setUpIDField() {
        roomIDField = UITextField()
        roomIDField?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(roomIDField!)
        roomIDField?.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60).isActive = true
        roomIDField?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        roomIDField?.placeholder = "Room ID"
        roomIDField?.textColor = .white
        roomIDField?.font = UIFont(name: "AvenirNext", size: 17)
        roomIDField?.textAlignment = .center
    }
    
    func setUpUserNameField() {
        userNameField = UITextField()
        userNameField?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userNameField!)
        userNameField?.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        userNameField?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userNameField?.placeholder = "Username"
        userNameField?.textColor = .white
        userNameField?.font = UIFont(name: "AvenirNext", size: 17)
        userNameField?.textAlignment = .center
    }
    
    func setUpConnectButton() {
        //36 32 56 very dark purple
        connectButton = UIButton()
        connectButton?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(connectButton!)
        connectButton?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        connectButton?.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 60).isActive = true
        connectButton?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        connectButton?.widthAnchor.constraint(equalToConstant: 150).isActive = true
        connectButton?.titleLabel?.textAlignment = .center
        connectButton?.setTitle("connect", for: .normal)
        connectButton?.titleLabel?.textColor = .white
        connectButton?.titleLabel?.font = UIFont(name: "AvenirNext", size: 17)
        connectButton?.backgroundColor = UIColor(displayP3Red: 63/255, green: 50/255, blue: 106/255, alpha: 1.0)
        connectButton?.layer.cornerRadius = 25
        connectButton?.layer.masksToBounds = true
        connectButton?.addTarget(self, action: #selector(onConnectTap), for: .touchUpInside)
    }
    
    @objc func onConnectTap() {
        if roomIDField?.text != "" && userNameField?.text != "" {
            print(roomIDField?.text)
            print(userNameField?.text)
            roomIDField?.text = ""
            userNameField?.text = ""
            navigationController?.present(ViewController(), animated: true, completion: {
                print("presenting room view")
                self.navigationController?.isNavigationBarHidden = false
            })
        } else {
            print("is empty")
        }
    }
    
}
