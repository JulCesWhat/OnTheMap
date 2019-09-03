//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Julio Cesar Whatley on 8/31/19.
//  Copyright © 2019 Capi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func Login(_ sender: Any) {
        LocationClient.login(username: tfEmail.text ?? "", password: tfPassword.text ?? "", completion: handleLoginResponse(success:error:))
    }
    
    func handleLoginResponse(success: Bool, error: Error?) {
        if success {
            LocationClient.getUserData(completion: handleGetUserDataResponse(success:error:))
        }
    }
    
    func handleGetUserDataResponse(success: Bool, error: Error?) {
        if success {
            performSegue(withIdentifier: "completeLogin", sender: nil)
        }
    }
}
