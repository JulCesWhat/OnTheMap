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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }
    
    func createSignUpLink() {
        let attributedString = NSMutableAttributedString(string: "Don't have an account? Sign Up.")
        let url = URL(string: "https://auth.udacity.com/sign-up")!
        let linkRange = (attributedString.string as NSString).range(of: "Sign Up")
        
        // Set the 'click here' substring to be the link
        attributedString.setAttributes([.link: url], range: linkRange)
        
        tvSingUpLink.attributedText = attributedString
        tvSingUpLink.isUserInteractionEnabled = true
        tvSingUpLink.isEditable = false
        
        // Set how links should appear: blue and underlined
        tvSingUpLink.linkTextAttributes = [
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
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            if tfPassword.isEditing {
                view.frame.origin.y -= keyboardHeight / 4
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
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
            tfEmail.text = ""
            tfPassword.text = ""
            performSegue(withIdentifier: "completeLogin", sender: nil)
        } else {
            showAlert(message: error?.localizedDescription ?? "There was an error while getting the details")
        }
    }
}
