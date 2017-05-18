//
//  SwipingViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Rob Percival on 08/07/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class SwipingViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var displayedUserID = ""//contains the userID of the current user being displayed to our logged in user, for him to swipe him/her right or left
    
    //most of the code of this function is copied from the video of dragging objects
    func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        
        /***********this code was copied***********************/
        
        let translation = gestureRecognizer.translation(in: view)
        
        let label = gestureRecognizer.view!
        
        label.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
        
        let xFromCenter = label.center.x - self.view.bounds.width / 2
        
        var rotation = CGAffineTransform(rotationAngle: xFromCenter / 200)
        
        let scale = min(abs(100 / xFromCenter), 1)
        
        var stretchAndRotation = rotation.scaledBy(x: scale, y: scale)
        
        label.transform = stretchAndRotation
        
        /**********************************/
        
        
        if gestureRecognizer.state == UIGestureRecognizerState.ended {
            
            var acceptedOrRejected = ""//keeps track of user preferences
            
            if label.center.x < 100 {
                
                acceptedOrRejected = "rejected"
                
            } else if label.center.x > self.view.bounds.width - 100 {
                
                acceptedOrRejected = "accepted"
                
            }
            
            if acceptedOrRejected != "" && displayedUserID != "" {
                
                PFUser.current()?.addUniqueObjects(from: [displayedUserID], forKey: acceptedOrRejected)//the content of displayedUserID is added to either the column of accepted or the column of rejected, which are in parse; and the value that gets saved in either columns is the one from the acceptedOrRejected array
                
                PFUser.current()?.saveInBackground(block: { (success, error) in
        
                    print(PFUser.current())
                    
                    self.updateImage()
                    
                })
            }
            
            /***********this code was copied***********************/
            
            rotation = CGAffineTransform(rotationAngle: 0)
            
            stretchAndRotation = rotation.scaledBy(x: 1, y: 1)
            
            label.transform = stretchAndRotation
            
            label.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
            
            /**********************************/
            
        }
    }

    func updateImage() {
        
        let query = PFUser.query()
        
        print(PFUser.current())
        
        query?.whereKey("isFemale", equalTo: (PFUser.current()?["isInterestedInWomen"])!)//we search for people that  interests our logged in user; in case our user is a man, isFemale will equal to true and so only females will appear to our user
        
        query?.whereKey("isInterestedInWomen", equalTo: (PFUser.current()?["isFemale"])!)//we search for people that are interested in the gender of our logged in user; in case our current user is a man, isInterestedInWomen will equal to false, so our user will only see persons interested in men
        
        var ignoredUsers = [""]//array that contains a combination of accepted and rejected users
        
        if let acceptedUsers = PFUser.current()?["accepted"] {//we check if there are accepted users
            
            ignoredUsers += acceptedUsers as! Array
            
        }
        
        if let rejectedUsers = PFUser.current()?["rejected"] {//we check if there are rejected users
            
            ignoredUsers += rejectedUsers as! Array
            
        }
        
        query?.whereKey("objectId", notContainedIn: ignoredUsers)//so we don't display users that have already been accepted or rejected by our logged in user
        
        query?.limit = 1//this serves to get get only one user at a time
        
        query?.findObjectsInBackground(block: { (objects, error) in
            
            if let users = objects {
                
                for object in users {
                 
                    if let user = object as? PFUser {
                        
                        //we need to display the photo of the user
                        
                        self.displayedUserID = user.objectId!//we obtain the userID of the current user being displayed to our logged in user
                        
                        let imageFile = user["photo"] as! PFFile
                        
                        imageFile.getDataInBackground(block: { (data, error) in
                            
                            if error != nil {
                                
                                print(error)
                                
                            }
                            
                            if let imageData = data {
                                
                                self.imageView.image = UIImage(data: imageData)
                            
                            }
                        })
                    }
                }
            }
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.wasDragged(gestureRecognizer:)))
        
        imageView.isUserInteractionEnabled = true
        
        imageView.addGestureRecognizer(gesture)
        
        updateImage()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //this function happens whenever a segueway is performed in this view controller
    func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "logoutSegue" {
            
            PFUser.logOut()
            
        }
        
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
