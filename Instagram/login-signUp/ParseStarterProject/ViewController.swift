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
    
    var signupMode = true //keeps track if user is signing up or logging in

    var activityIndicator = UIActivityIndicatorView()//rhis is for the spinner
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    //generic create alert function
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    
    }
    
    @IBAction func signupOrLogin(_ sender: AnyObject) {//initial button under "Sign up"
        
        if emailTextField.text == "" || passwordTextField.text == "" {//if parse detects an error
            
            createAlert(title: "Error in form", message: "Please enter an email and password")//calling createAlert function
            
        } else {
                //creating our spinner for when the user is being processed by parse
                activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                activityIndicator.center = self.view.center
                activityIndicator.hidesWhenStopped = true
                activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
                view.addSubview(activityIndicator)
                activityIndicator.startAnimating()
                UIApplication.shared.beginIgnoringInteractionEvents()
            
            if signupMode {
                
                // Sign Up
                
                let user = PFUser() //a PFUser has by default a username built in; a PFUser is an object, which can have attrs.
                
                user.username = emailTextField.text
                user.email = emailTextField.text
                user.password = passwordTextField.text
                
                //success is a boolean
                user.signUpInBackground(block: { (success, error) in //we add the user to parse
                    
                    self.activityIndicator.stopAnimating() //terminates the spinner
                    UIApplication.shared.endIgnoringInteractionEvents() //enables user interaction again
                    
                    if error != nil {//if username is already taken , etc...
                        
                        //we want to grab the error variable inside the UserInfo array inside the error object given by parse
                        
                        var displayErrorMessage = "Please try again later."
                        
                        let error = error as NSError?//error has more info. than we need to display, that is why we need only to select what is important to us
                        
                        if let errorMessage = error?.userInfo["error"] as? String {
                            
                            displayErrorMessage = errorMessage
                            
                        }
                        
                        self.createAlert(title: "Signup Error", message: displayErrorMessage)
                        
                    } else {
                        
                        print("user signed up")
                    
                    }
                    
                    
                })
                
                
            } else {
                
                // Login mode
                
                //we should get returned a PFUser or an error object
                //now we are not creating a user, we are checking the info. already stored in parse
                PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!, block: { (user, error) in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if error != nil {
                        
                        var displayErrorMessage = "Please try again later."
                        
                        let error = error as NSError?
                        
                        if let errorMessage = error?.userInfo["error"] as? String {
                            
                            displayErrorMessage = errorMessage
                            
                        }
                        
                        self.createAlert(title: "Login Error", message: displayErrorMessage)
                        
                        
                    } else {
                        
                        print("Logged in")
                        
                    }
                })
            }
        }
    }
    
    @IBOutlet var signupOrLogin: UIButton! //initial button under "Sign up"
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var changeSignupModeButton: UIButton! //initial button under "Log in"
    
    //this function changes between sign up mode and log in mode and vice versa
    @IBAction func changeSignupMode(_ sender: AnyObject) {//initial button under "Log in"
        
        if signupMode {
            
            // Change to login mode
            //we simply interchange text inside buttons, update label and get out of signup mode
            
            signupOrLogin.setTitle("Log In", for: [])
            
            changeSignupModeButton.setTitle("Sign Up", for: [])
            
            messageLabel.text = "Don't have an account?"
            
            signupMode = false
            
        } else {
            
            // Change to signup mode
            
            signupOrLogin.setTitle("Sign Up", for: [])
            
            changeSignupModeButton.setTitle("Log In", for: [])
            
            messageLabel.text = "Already have an account?"
            
            signupMode = true
            
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
