//
//  ConnectToRoomViewController.swift
//  VideoSyncApp
//
//  Created by Salman Fakhri on 6/12/18.
//  Copyright © 2018 Salman Fakhri. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    unowned var loginView: LoginView { return self.view as! LoginView }
    unowned var roomIDField: UITextField { return loginView.roomIDField }
    unowned var userNameField: UITextField { return loginView.userNameField }
    unowned var connectButton: UIButton { return loginView.connectButton }
    
    var touchRecognizer: UITapGestureRecognizer?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view = LoginView(frame: view.frame)
        setUpTouchGesture()
        setUpConnectAction()
    }
    
    func setUpTouchGesture() {
        touchRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(touchRecognizer!)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func setUpConnectAction() {
        connectButton.addTarget(self, action: #selector(onConnectTap), for: .touchUpInside)
    }
    
    @objc func onConnectTap() {
        if roomIDField.text != "" && userNameField.text != "" {
            SocketClientManager.sharedInstance.connectSocket(username: userNameField.text!, roomID: roomIDField.text!, completion: {
                let roomVC = RoomViewController()
                roomVC.roomName = self.roomIDField.text!
                self.navigationController?.present(roomVC, animated: true, completion: {
                    print("presenting room view")
                    self.navigationController?.isNavigationBarHidden = false
                })
                SocketClientManager.sharedInstance.addHandlers()
                self.roomIDField.text = ""
                self.userNameField.text = ""
            })
        } else {
            print("is empty")
        }
    }
    
}
