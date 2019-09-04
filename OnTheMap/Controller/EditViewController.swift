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
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "There was an error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        show(alert, sender: nil)
    }
}
