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
    
    var signupMode = true//keeps track of wether the user is in Sign up mode or Log in mode

    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var signupOrLoginButton: UIButton!//button under "Sign Up"
    @IBOutlet var changeSignupModeButton: UIButton!//button under "Log in"
    
    @IBAction func signupOrLogin(_ sender: AnyObject) {
        
        if signupMode {
            
        //we create a user in parse
            
        let user = PFUser()//we create a user
        
        //we set the user's attrs.
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground { (success, error) in//we save the user in parse
            
            if error != nil {
                
                var errorMessage = "Signup failed - please try again"
                
                let error = error as! NSError
                
                if let parseError = error.userInfo["error"] as? String {
                    
                    errorMessage = parseError
                    
                }
                
                self.errorLabel.text = errorMessage
                
            } else {
                
                print("Signed up")
                
            }
        }
        
        } else {
            
            //we look for the user in parse and log it in
            
            PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!, block: { (user, error) in
                
                if error != nil {
                    
                    var errorMessage = "Signup failed - please try again"
                    
                    let error = error as NSError?
                    
                    if let parseError = error?.userInfo["error"] as? String {
                        
                        errorMessage = parseError
                        
                    }
                    
                    self.errorLabel.text = errorMessage
                    
                } else {
                    
                    print("Logged In")
                    
                }
            })
        }
    }
    
    //this funct changes state between Sign up mode and Log in mode and viceversa
    @IBAction func changeSignupMode(_ sender: AnyObject) {
        
        if signupMode {
            
            //change to log in mode
            
            signupMode = false
            
            signupOrLoginButton.setTitle("Log In", for: [])
            
            changeSignupModeButton.setTitle("Sign Up", for: [])
            
        } else {
            
            //change to Sign Up mode
            
            signupMode = true
            
            signupOrLoginButton.setTitle("Sign Up", for: [])
            
            changeSignupModeButton.setTitle("Log In", for: [])
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let testObject = PFObject(className: "TestObject2")
        testObject["foo"] = "bar"
        testObject.saveInBackground { (success, error) -> Void in
            if error != nil {
                
                print(error)
                
            } else {
            
                print("Object has been saved.")
                
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
