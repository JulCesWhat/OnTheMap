//
//  ViewController.swift
//  OnTheMap
//
//  Created by Julio Cesar Whatley on 8/30/19.
//  Copyright © 2019 Capi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnLogin(_ sender: Any) {
        
    }
    
    @IBAction func Login(_ sender: Any) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        present(detailController, animated: true, completion: nil)
    }
}

