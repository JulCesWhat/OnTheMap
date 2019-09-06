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
    @IBOutlet weak var tvSingUpLink: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSignUpLink()
    }
    
    func createSignUpLink() {
        let attributedString = NSMutableAttributedString(string: "Don't have an account? Sign Up.")
        let url = URL(string: "https://auth.udacity.com/sign-up")!
        let linkRange = (attributedString.string as NSString).range(of: "Sign Up")
        
        // Set the 'click here' substring to be the link
        attributedString.setAttributes([.link: url], range: linkRange)
        
        self.tvSingUpLink.attributedText = attributedString
        self.tvSingUpLink.isUserInteractionEnabled = true
        self.tvSingUpLink.isEditable = false
        
        // Set how links should appear: blue and underlined
        self.tvSingUpLink.linkTextAttributes = [
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
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
