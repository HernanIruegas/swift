//
//  ViewController.swift
//  Swipe Demo
//
//  Created by Rob Percival on 07/07/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //label is an object
        let label = UILabel(frame: CGRect(x: self.view.bounds.width / 2 - 100, y: self.view.bounds.height / 2 - 50, width: 200, height: 100))//creates a rectangle in the middle of the screen to contain our label
        
        label.text = "Drag me!"
        
        label.textAlignment = NSTextAlignment.center
        
        view.addSubview(label)
        
        //Pan = means we are moving our fingeracross the screen or dragging
        //action = the method we want to call when a gesture is recognized
        //by adding the colon " : " we are saying that we want info. about the gesture to be passed to the method
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.wasDragged(gestureRecognizer:)))
        
        label.isUserInteractionEnabled = true
        
        label.addGestureRecognizer(gesture)//we add the functionality of the gesture to our label
        
    }
    
    func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        
        //describes a movement from one point of the screen to another; let us help identify where the user has dragged the label
        //gives us the coordinates of where the user has dragged to
        let translation = gestureRecognizer.translation(in: view)
        
        //we get back our label that we declared in viewDidLoad
        let label = gestureRecognizer.view!
        
        //we update the new coordinates of the label using the translation
        label.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
        
        /******this code handles the change in appearence of the label*************************/
        
        let xFromCenter = label.center.x - self.view.bounds.width / 2//tells us how far is the label from the center of the screen
        
        var rotation = CGAffineTransform(rotationAngle: xFromCenter / 200)//to rotate our image, increases as label moves away from center; (rotationAngle = is in radians)
        
        //min(abs(100 / xFromCenter), 1) means that our max. scale we will ever get is 1...since the min will take the smalles value between the two numbers, so either abs(100 / xFromCenter or 1
        let scale = min(abs(100 / xFromCenter), 1)//the further it is from the center, the smaller the scale will be
        
        var stretchAndRotation = rotation.scaledBy(x: scale, y: scale)//to change size of our image, applying rotation too
        
        label.transform = stretchAndRotation//transform = let us change the appeareance of our label
        
        /*******************************/
        
        //this condition checks if the user has stopped dragging the label; if he has lifted his finger
        if gestureRecognizer.state == UIGestureRecognizerState.ended {
            
            //we determine if the user has dragged the label to the left or to the right
            
            if label.center.x < 100 {
                
                print("Not chosen")
                
            } else if label.center.x > self.view.bounds.width - 100 {
                
                print("Chosen")
                
            }
            
            /******this code handles the change in appearence of the label*************************/
            
            //we reset the appeareance of our label to how originally was, not rotated and original size
            
            rotation = CGAffineTransform(rotationAngle: 0)
            
            stretchAndRotation = rotation.scaledBy(x: 1, y: 1)
            
            label.transform = stretchAndRotation
            
            /*******************************/
            
            //after the drag (either to right or left), we set our label again to the center
            label.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

