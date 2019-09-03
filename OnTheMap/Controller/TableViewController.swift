//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Julio Cesar Whatley on 8/31/19.
//  Copyright © 2019 Capi. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocationClient.studentLocation.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell")!
        let location = LocationClient.studentLocation[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.textLabel?.text = location.firstName + " " + location.lastName
        cell.imageView?.image = UIImage(named: "icon_pin")
        cell.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = LocationClient.studentLocation[(indexPath as NSIndexPath).row]
        if !location.mediaURL.isEmpty {
            let app = UIApplication.shared
            app.open(URL(string: location.mediaURL)!)
        }
    }
    
    
    @IBAction func editLocation(_ sender: Any) {
        performSegue(withIdentifier: "editLocation", sender: nil)
    }
}
