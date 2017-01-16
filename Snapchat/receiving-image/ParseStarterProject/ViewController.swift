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

   
    @IBOutlet var usernameTextField: UITextField!
    
    
    @IBAction func signupOrLogin(_ sender: AnyObject) {
        
        if usernameTextField.text == "" {
            
            errorLabel.text = "A username is required"
            
        } else {
            
            PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: "password", block: { (user, error) in
                
                if error != nil {
                    
                    let user = PFUser()
                    
                    user.username = self.usernameTextField.text
                    user.password = "password"
                    
                    user.signUpInBackground(block: { (success, error) in
                        
                        if let error = error as? NSError {
                            
                            var errorMessage = "Signup failed - please try again later"
                            
                            if let errorString = error.userInfo["error"] as? String {
                                
                                errorMessage = errorString
                                
                            }
                            
                            self.errorLabel.text = errorMessage
                            
                        } else {
                            
                            self.performSegue(withIdentifier: "showUserTable", sender: self)
                            
                        }
                        
                        
                    })
                    
                    
                    
                } else {
                    
                    print ("Logged In")
                    
                    self.performSegue(withIdentifier: "showUserTable", sender: self)
                    
                }
                
                
            })
            
        }
        
    }
    
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        
        if PFUser.current() != nil {
            
            performSegue(withIdentifier: "showUserTable", sender: self)
            
            
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
