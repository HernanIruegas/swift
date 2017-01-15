//
//  ViewController.swift
//  Maps
//
//  Created by Hernán Iruegas Villarreal on 22/12/16.
//  Copyright © 2016 Hernán Iruegas Villarreal. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let latitude: CLLocationDegrees = 40.7
        
        let longitude: CLLocationDegrees = -73.9
        
        //the zoom level of the map
        //number of degrees diference in latitude
        let latDelta: CLLocationDegrees = 0.05
        
        let lonDelta: CLLocationDegrees = 0.05
        
        //combination of latDelta and lonDelta; is the overall zoom of the map
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        let coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let region: MKCoordinateRegion = MKCoordinateRegion(center: coordinates, span: span)
        
        map.setRegion(region, animated: true)
        
        /****************/
        //the next code is to hardcode annotations
        let annotation = MKPointAnnotation()
        
        annotation.title = "Random place"
        
        annotation.subtitle = "One day I'll go here..."
        
        annotation.coordinate = coordinates
        
        map.addAnnotation(annotation)
        
        /****************/
        
        //the next code is for the user to make annotations in real time
        //this identifies a long press from the user
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longpress(gestureRecognizer:)))
        
        uilpgr.minimumPressDuration = 2
        
        map.addGestureRecognizer(uilpgr)
    }
    
    func longpress(gestureRecognizer: UIGestureRecognizer) {
        
        //the location we get within the map
        let touchPoint = gestureRecognizer.location(in: self.map)
        
        //from the map, it converts the touchPoint to a coordinate
        //the map recognizes where the long press occurred, and it converts it into a coordinate
        let coordinate = map.convert(touchPoint, toCoordinateFrom: self.map)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = coordinate
        
        annotation.title = "New place"
        
        annotation.subtitle = "Maybe I'll go here too..."
        
        map.addAnnotation(annotation)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

