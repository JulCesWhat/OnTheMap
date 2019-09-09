//
//  EditViewController.swift
//  OnTheMap
//
//  Created by Julio Cesar Whatley on 8/31/19.
//  Copyright © 2019 Capi. All rights reserved.
//

import UIKit

class EditViewController: UIViewController  {
    
    @IBOutlet weak var tfLocation: UITextField!
    @IBOutlet weak var tfUrl: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }
    
    @IBAction func addLocation(_ sender: Any) {
        if (tfLocation.text ?? "").isEmpty || (tfUrl.text ?? "").isEmpty {
            showAlert(message: "The location and (or) url cannot be empty")
        } else {
            OpenCageClient.search(query: tfLocation.text ?? "", completion: rerouteToAddLocation(result:error:))
        }
    }
    
    @IBAction func cancelEditLocation(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            if tfUrl.isEditing {
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
    
    func rerouteToAddLocation(result: [Result], error: Error?) {
        if result.count > 0 {
            let addController = self.storyboard!.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
            addController.newResultLocation = result[0]
            addController.newMediaURL = tfUrl.text
            addController.userDetail = LocationClient.Auth.user
            self.navigationController!.pushViewController(addController, animated: true)
        } else {
            showAlert(message: error?.localizedDescription ?? "There was an error while getting the details")
        }
    }
}
