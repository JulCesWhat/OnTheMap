//
//  AddViewController.swift
//  OnTheMap
//
//  Created by Julio Cesar Whatley on 9/1/19.
//  Copyright © 2019 Capi. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class AddViewController: UIViewController, MKMapViewDelegate {
    
    var newResultLocation: Result!
    var userDetail: UserDataResponse!
    var newMediaURL: String!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setNewUserLocation()
    }
    
    func setNewUserLocation() {
        // We will create an MKPointAnnotation for each dictionary in "locations". The
        // point annotations will be stored in this array, and then provided to the map view.
        var annotations = [MKPointAnnotation]()

        // The lat and long are used to create a CLLocationCoordinates2D instance.
        let coordinate = CLLocationCoordinate2D(latitude: newResultLocation.geometry.lat, longitude: newResultLocation.geometry.lng)
        
        // Here we create the annotation and set its coordiate, title, and subtitle properties
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "\(userDetail.firstName) \(userDetail.lastName)"
        annotation.subtitle = newMediaURL
        
        // Finally we place the annotation in an array of annotations.
        annotations.append(annotation)
        
        // When the array is complete, we add the annotations to the map.
        self.mapView.addAnnotations(annotations)
        
        let location = CLLocationCoordinate2DMake(newResultLocation.geometry.lat, newResultLocation.geometry.lng)
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region =  MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(region, animated: true)

    }
    
    // Here we create a view with a "right callout accessory view". You might choose to look into other
    // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
    // method in TableViewDataSource.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    @IBAction func finishAddingLocation(_ sender: Any) {
        let body = getUserLocation()
        if (MapLocation.userLocation != nil) {
            LocationClient.updateLocation(body: body, completion: handleAddingLocation(success:error:))
        } else {
            LocationClient.setLocation(body: body, completion: handleAddingLocation(success:error:))
        }
    }
    
    func handleAddingLocation(success: Bool, error: Error?) {
        if success {
            if let _ = MapLocation.userLocation {
                MapLocation.studentLocations.removeLast()
            }
            let location = getUserLocation()
            MapLocation.userLocation = location
            MapLocation.userLocationUpdated = true
            MapLocation.studentLocations.append(location)
            
            self.dismiss(animated: false, completion: {
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            // Throw error
            showAlert(message: error?.localizedDescription ?? "There was an error while posting the details")
        }
    }
    
    func getUserLocation() -> Location {
        let body = Location(latitude: newResultLocation.geometry.lat, longitude: newResultLocation.geometry.lng, firstName: userDetail.firstName, lastName: userDetail.lastName, mapString: newResultLocation.formatted, mediaURL: newMediaURL, uniqueKey: LocationClient.Auth.userId, createdAt: "", updatedAt: "", objectId: "")
        return body
    }
    
    @IBAction func cancelAddLocation(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
