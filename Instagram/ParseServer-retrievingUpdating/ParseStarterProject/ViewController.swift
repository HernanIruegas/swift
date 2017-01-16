/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       /* this code is for running a demo of how the app integrates with parser on ec2 instance
         we are saving an object with a class of "Users" and assigning a value of "Rob" to its name attribute
         
       let user = PFObject(className: "Users") //a class under the name "Users" is created in parse
        
        user["name"] = "Rob" //a PFObject works like a dictionary, in this case "name" is the attr. and Rob is the value
        
        user.saveInBackground { (success, error) in 
         
         //success = bool; error = object
            
            if success {
                
                print ("Object saved")
                
            } else {
                
                if let error = error {
                    
                    print (error)
                    
                } else {
                    
                    print ("Error")
                    
                }
            }
        } */
        
        //to retrieve info. from parse
        let query = PFQuery(className: "Users")
        query.getObjectInBackground(withId: "FlmMnJgfI1") { (object, error) in//the id is automatically generated in parse
            if error != nil {
                
                print (error)
                
            } else {
                
                if let user = object {//if the user exists (object contains the user)
                    //user will be a PFObject
                    
                    user["name"] = "Kirsten" //this will update the value of the user
                    
                    user.saveInBackground(block: { (success, error) in //this saves the updated value for the user
                        if success {
                            
                            print ("Saved")
                        
                        } else {
                            
                            print (error)
                            
                        }
                    })
                    
                
                }
            }
        }
       
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
