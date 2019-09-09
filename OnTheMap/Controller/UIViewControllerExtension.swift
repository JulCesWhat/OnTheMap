//
//  UIViewControllerExtension.swift
//  OnTheMap
//
//  Created by Julio Cesar Whatley on 9/8/19.
//  Copyright © 2019 Capi. All rights reserved.
//

import UIKit

extension UIViewController {
    
//    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
//        TMDBClient.logout {
//            DispatchQueue.main.async {
//                self.dismiss(animated: true, completion: nil)
//            }
//        }
//    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "There was an error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        show(alert, sender: nil)
    }
}
