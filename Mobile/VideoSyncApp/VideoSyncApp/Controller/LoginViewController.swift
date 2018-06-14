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
            print(roomIDField.text)
            print(userNameField.text)
            roomIDField.text = ""
            userNameField.text = ""
            navigationController?.present(ViewController(), animated: true, completion: {
                print("presenting room view")
                self.navigationController?.isNavigationBarHidden = false
            })
        } else {
            print("is empty")
        }
    }
    
}
