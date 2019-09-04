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
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func Login(_ sender: Any) {
        if (tfEmail.text ?? "").isEmpty || (tfPassword.text ?? "").isEmpty {
            showAlert(message: "The email and (or) the password cannot be empty")
        } else {
            LocationClient.login(username: tfEmail.text ?? "", password: tfPassword.text ?? "", completion: handleLoginResponse(success:error:))
        }
    }
    
    func handleLoginResponse(success: Bool, error: Error?) {
        if success {
            LocationClient.getUserData(completion: handleGetUserDataResponse(success:error:))
        } else {
            showAlert(message: error?.localizedDescription ?? "There was an error login in")
        }
    }
    
    func handleGetUserDataResponse(success: Bool, error: Error?) {
        if success {
            performSegue(withIdentifier: "completeLogin", sender: nil)
        } else {
            showAlert(message: error?.localizedDescription ?? "There was an error while getting the details")
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "There was an error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        show(alert, sender: nil)
    }
}
