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
            // Show error
            
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
            // Show error
        }
    }
    
    
}
