//
//  ViewController.swift
//  spinners-alerts
//
//  Created by Hernán Iruegas Villarreal on 30/12/16.
//  Copyright © 2016 Hernán Iruegas Villarreal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var activityIndicator = UIActivityIndicatorView()
    
    //alerts
    @IBAction func createAlert(_ sender: AnyObject) {
        
        //this var let us control the alert
        let alertController = UIAlertController(title: "Hey There!", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.alert)
        
        //alertController.addAction enables us to provide options for the user to click on when alert appears
        //handler = what is going to happen when button is pressed
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            print("OK button pressed")
            
            self.dismiss(animated: true, completion: nil) //this closes down the alert
            
        }))
        
        //this adds another option to click on the alert
        alertController.addAction(UIAlertAction(title: "No", style: .default, handler: { (action) in
            
            print("No button pressed")
            
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alertController, animated: true, completion: nil)//this is the part that displays the alert
        
    }
    
    //spinners
    @IBAction func pauseApp(_ sender: AnyObject) {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))//sets size of spinner
        
        activityIndicator.center = self.view.center //sets the location within the view
        
        activityIndicator.hidesWhenStopped = true
        
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        //UIApplication.shared.beginIgnoringInteractionEvents() //disables user interaciton while spinner is running
        
    }
    
    
    @IBAction func restoreApp(_ sender: AnyObject) {
        
        activityIndicator.stopAnimating()
        
       //UIApplication.shared.endIgnoringInteractionEvents() //to restore user interaction
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

