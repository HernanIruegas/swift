//
//  ViewController.swift
//  Swipes & Shakes
//
//  Created by Rob Percival on 21/06/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //detects a swipe
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swiped(gesture:)))
        
        //detects a swipe to the right
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        
        //adding the swipe to a UI element
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swiped(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        
        
    }
    
    //this function detects motion of the phone
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        
        if event?.subtype == UIEventSubtype.motionShake {//detect shake motion
            
            print("Device was shaken")
            
        }
        
    }
    
    func swiped(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {//if a swipe exists; we cast UIGestureRecognizer as a UISwipeGestureRecognizer
            
            switch swipeGesture.direction {
                
                case UISwipeGestureRecognizerDirection.right:
                    print("User Swiped Right")
                case UISwipeGestureRecognizerDirection.left:
                    print("User Swiped Left")
                default:
                    break
                
            }
            
            
        }
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

