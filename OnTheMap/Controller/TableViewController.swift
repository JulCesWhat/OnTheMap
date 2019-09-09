//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Julio Cesar Whatley on 8/31/19.
//  Copyright © 2019 Capi. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MapLocation.studentLocations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell")!
        let location = MapLocation.studentLocations[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.textLabel?.text = location.firstName + " " + location.lastName
        cell.imageView?.image = UIImage(named: "icon_pin")
        cell.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = MapLocation.studentLocations[(indexPath as NSIndexPath).row]
        if !location.mediaURL.isEmpty {
            let app = UIApplication.shared
            app.open(URL(string: location.mediaURL)!)
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        LocationClient.logout {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func editLocation(_ sender: Any) {
        if MapLocation.userLocation != nil {
            let alert = UIAlertController(title: "Do you want to update your location?", message: "You have already posted a student location. Would you like to override your current location?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                self.performSegue(withIdentifier: "editLocation", sender: nil)
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        } else {
            performSegue(withIdentifier: "editLocation", sender: nil)
        }
    }
    
}
