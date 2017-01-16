//
//  UserDetailsViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Andrew Dunn on 25/10/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class UserDetailsViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var userImage: UIImageView!
    
    //here we display the user's photo library so that he can select an image of his choice
    @IBAction func updateProfileImage(_ sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    //here we process the image the user has selected
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        // (Change from the video):
        // Video shows "if let image = info[UIImagePickerControllerOriginalImage] as? UIImage", which does not work in current version of Xcode
        if let image = info[UIImagePickerControllerOriginalImage] as! UIImage? {
            userImage.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }

    
    @IBOutlet var genderSwitch: UISwitch!
    
    @IBOutlet var interestedInSwitch: UISwitch!
    
    @IBOutlet var errorLabel: UILabel!
    
    
    @IBAction func update(_ sender: AnyObject) {
        
        //isOn is a bool that returns the state of the switch(UIElement in storyboard)
        PFUser.current()?["isFemale"] = genderSwitch.isOn//we get if user is female or not
        PFUser.current()?["isInterestedInWomen"] = interestedInSwitch.isOn//we get if user likes females or not
        
        //now we want to save the user profile picture
        let imageData = UIImagePNGRepresentation(userImage.image!)//we convert it to data

        PFUser.current()?["photo"] = PFFile(name: "profile.png", data: imageData!) // !! This line causes a runtime error
        
        PFUser.current()?.saveInBackground(block: { (success, error) in
            
            //we update the user by saving the new info.
            
            if error != nil {
                
                var errorMessage = "Update failed - please try again"
                
                let error = error as NSError?
                
                if let parseError = error?.userInfo["error"] as? String {
                    
                    errorMessage = parseError
                    
                }
                
                self.errorLabel.text = errorMessage
                
            } else {
                
                print("Updated")
                
            }
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //we retrieve from parse the details of our user (if they exist; meaning they have already been saved)
        
        if let isFemale = PFUser.current()?["isFemale"] as? Bool {
            
            genderSwitch.setOn(isFemale, animated: false)
            
        }
        
        if let interestedIn = PFUser.current()?["isInterestedInWomen"] as? Bool {
            
            interestedInSwitch.setOn(interestedIn, animated: false)
            
        }
        
        if let photo = PFUser.current()?["photo"] as? PFFile {
            
            photo.getDataInBackground(block: { (data, error) in //this will download our image from parse
            
                if let imageData = data {
                
                    if let downloadedImage = UIImage(data: imageData) {//we convert the data to an image
                    
                        self.userImage.image = downloadedImage
                    
                    }
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
