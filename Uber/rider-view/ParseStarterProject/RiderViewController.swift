//
//  RiderViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Rob Percival on 11/07/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
import MapKit

class RiderViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    func displayAlert(title: String, message: String) {
        
        let alertcontroller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertcontroller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alertcontroller, animated: true, completion: nil)
        
    }

    var locationManager = CLLocationManager()//for the map
    
    var riderRequestActive = true//to keep track if our user has an ongoing request for an uber
    
    //we need to have an initial value for a CLLocationCoordinate2D, that is the reason for the zeroes
    var userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    @IBOutlet var map: MKMapView!
    
    @IBAction func callAnUber(_ sender: AnyObject) {
        
        //we save the username and its location to parse
        
        if riderRequestActive {
            
            //if there is an ongoig request, then we cancel it
            //so users can't make multiple active requests
            
            callAnUberButton.setTitle("Call An Uber", for: [])
            
            riderRequestActive = false
            
            //we need to delete the active request of the user
            
            let query = PFQuery(className: "RiderRequest")
            
            query.whereKey("username", equalTo: (PFUser.current()?.username)!)
            
            query.findObjectsInBackground(block: { (objects, error) in
                
                if let riderRequests = objects {//this array should only contain 1 uber request
                    
                    for riderRequest in riderRequests {
                        
                            riderRequest.deleteInBackground()
                        
                    }
                }
            })
            
        } else {
        
        if userLocation.latitude != 0 && userLocation.longitude != 0 {//if we have the user's location
            
            riderRequestActive = true
            
            self.callAnUberButton.setTitle("Cancel Uber", for: [])
        
            let riderRequest = PFObject(className: "RiderRequest")
        
            riderRequest["username"] = PFUser.current()?.username
        
            //we save the user's location in parse
            riderRequest["location"] = PFGeoPoint(latitude: userLocation.latitude, longitude: userLocation.longitude)
            
            riderRequest.saveInBackground(block: { (success, error) in
                
                if success {
                    
                    print("Called an uber")
                    
                    
                } else {
                    
                    //if the request could not be made
                    
                    self.callAnUberButton.setTitle("Call An Uber", for: [])
                    
                    self.riderRequestActive = false
                    
                    self.displayAlert(title: "Could not call Uber", message: "Please try again!")
                   
                }
            })
            
        } else {
            
            displayAlert(title: "Could not call Uber", message: "Cannot detect your location.")
            
        }
        
        }
        
    }
    @IBOutlet var callAnUberButton: UIButton!
    
    //to perform the segue to initial view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "logoutSegue" {
            
            PFUser.logOut()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /****for the map**************/
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        
         /******************/
        
        callAnUberButton.isHidden = true//we first need to confirm that the user has no ongoing requests
        
        /**we check if the user has an active uber request****************/
        
        let query = PFQuery(className: "RiderRequest")
        
        query.whereKey("username", equalTo: (PFUser.current()?.username)!)
        
        query.findObjectsInBackground(block: { (objects, error) in
            
            if let riderRequests = objects {
                
               self.riderRequestActive = true
                
                self.callAnUberButton.setTitle("Cancel Uber", for: [])
 
            }
            
        /******************/
            
            self.callAnUberButton.isHidden = false
            
            
        })

        
    }
    
    //this func. is to actually do something with the map
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //we can either use the locations array to get the user's location, or the manager itself (which we are in this case)
        
        if let location = manager.location?.coordinate {
            
            //this is to set the center of the map (which we need it to be the user's lcoation)
            userLocation = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            
            let region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            self.map.setRegion(region, animated: true)
            
            //we need to remove any annotations from the map before adding any new ones, if this is not the case and the user is moving (changing locations), then the user will be presented with lots of red pins (annotations) that represent past user's locations besides his current location
            self.map.removeAnnotations(self.map.annotations)
            
            //let's show the user location with a red pin
            let annotation = MKPointAnnotation()//to graphically represent the user's location
            
            annotation.coordinate = userLocation
            
            annotation.title = "Your Location"
            
            self.map.addAnnotation(annotation)
            
            //we need to update the user's location, in case the user is moving
            
            let query = PFQuery(className: "RiderRequest")
            
            query.whereKey("username", equalTo: (PFUser.current()?.username)!)
            
            query.findObjectsInBackground(block: { (objects, error) in
                
                if let riderRequests = objects {
                    
                    for riderRequest in riderRequests {
                        
                        riderRequest["location"] = PFGeoPoint(latitude: self.userLocation.latitude, longitude: self.userLocation.longitude)
                        
                        riderRequest.saveInBackground()
                        
                    }
                    
                }
                
                
            })

            
            
        }
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
