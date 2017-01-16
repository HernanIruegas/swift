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
    
    
    @IBOutlet var userSignupSwitch: UISwitch!
    
    var signUpMode = true
    
    func displayAlert(title: String, message: String) {
        
        let alertcontroller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertcontroller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alertcontroller, animated: true, completion: nil)
        
    }

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var signupOrLoginButton: UIButton!//initial button under "Sign Up"
    
    @IBAction func signupOrLogin(_ sender: AnyObject) {//initial button under "Sign Up"
        
        //we check that the user provides some credentials
        if usernameTextField.text == "" || passwordTextField.text == "" {
            
            displayAlert(title: "Error in form", message: "Username and password are required")
            
        } else {
            
            if signUpMode {
                
                //we create a new user (determining if it's a driver or a rider), then we save it in parse
                
                let user = PFUser()
                
                user.username = usernameTextField.text
                user.password = passwordTextField.text
                
                
                user["isDriver"] = userSignupSwitch.isOn
                
                user.signUpInBackground(block: { (success, error) in
                    
                    if let error = error {
                        
                        var displayedErrorMessage = "Please try again later"
                        
                        let error = error as NSError
                        
                        if let parseError = error.userInfo["error"] as? String {
                            
                            displayedErrorMessage = parseError
                            
                            
                        }
                        
                        self.displayAlert(title: "Sign Up Failed", message: displayedErrorMessage)
                        
                    } else {
                        
                        print("Sign Up Successful")
                        
                    }
                })
                
            } else {
                
                //we just look for the user credentials in parse so we can log him in
                
                PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!, block: { (user, error) in
                    
                    if let error = error {
                        
                        var displayedErrorMessage = "Please try again later"
                        
                        let error = error as NSError
                        
                        if let parseError = error.userInfo["error"] as? String {
                            
                            displayedErrorMessage = parseError
                        }
                        
                        self.displayAlert(title: "Sign Up Failed", message: displayedErrorMessage)
                        
                    } else {
                        
                        print("Log In Successful")
                        
                    }
                })
            }
        }
    }
    
    @IBOutlet var signupSwitchButton: UIButton!//initial button under "Change to Log in"
    
    //this switches from "sign up mode" to "log in mode" and vice versa
    @IBAction func switchSignupMode(_ sender: AnyObject) {//initial button under "Change to Log in"
        
        if signUpMode {
            
            //switch to log in mode
            
            signupOrLoginButton.setTitle("Log In", for: [])
            
            signupSwitchButton.setTitle("Switch To Sign Up", for: [])
            
            signUpMode = false
            
            
        } else {
            
            //switch to sign up mode
            
            signupOrLoginButton.setTitle("Sign Up", for: [])
            
            signupSwitchButton.setTitle("Switch To Log In", for: [])
            
            signUpMode = true
            
        }
        
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