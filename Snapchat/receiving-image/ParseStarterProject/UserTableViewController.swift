//
//  UserTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Rob Percival on 13/07/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class UserTableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var usernames = [String]()
    
    var recipientUsername = ""
    
    func checkForMessages() {
        
        /***********************/
        
        //we try to obtain all images that were sent to the logged in user
        
        let query = PFQuery(className: "Image")
        
        query.whereKey("recipientUsername", equalTo: (PFUser.current()?.username)!)
        
        do {
            
            let images = try query.findObjects()
            
            if images.count > 0 {
                
                //images[0] = so our code does not attempt to display more than one image at once
                
                    var senderUsername = "Unknown User"
                    
                    if let username = images[0]["senderUsername"] as? String {
                        
                        senderUsername = username
                        
                    }
                
                //images is an PFObject, so we extract the image data, in order to convert it to an actual photo
                    
                    if let pfFile = images[0]["photo"] as? PFFile {
                        
                        pfFile.getDataInBackground(block: { (data, error) in
                            
                            if let imageData = data {
                                
                                images[0].deleteInBackground()//so the same message with the same photo don't appear again
                                
                                self.timer.invalidate()//so that we don't get the same image more than once, so there aren't repeated messages
                                
                                
                                if let imageToDisplay = UIImage(data: imageData) {
                                    
                                    //we display an alert containng the image
                                    
                                    let alertController = UIAlertController(title: "You have a message", message: "Message from " + senderUsername, preferredStyle: .alert)
                                    
                                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                                        
                                        //we cretae our own view, which sits at the back of displayedImageView, but at the front of the table
                                        //serves for the blurred effect
                                        
                                        let backgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
                                        
                                        backgroundImageView.backgroundColor = UIColor.black // UIColor.black() is now UIColor.black
                                        
                                        backgroundImageView.alpha = 0.8
                                        
                                        backgroundImageView.tag = 10
                                        
                                        self.view.addSubview(backgroundImageView)
                                        
                                        //we create an image programatically
                                        
                                        let displayedImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
                                        
                                        displayedImageView.image = imageToDisplay
                                        
                                        displayedImageView.tag = 10//identifies the subview
                                        
                                        displayedImageView.contentMode = UIViewContentMode.scaleAspectFit
                                        
                                        self.view.addSubview(displayedImageView)
                                        
                                        //after 5 seconds of displaying the image, we restart the timer, and then remove the image from the view
                                        
                                        _ = Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: { (timer) in
                                            
                                            self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(UserTableViewController.checkForMessages), userInfo: nil, repeats: true)
                                            
                                            for subview in self.view.subviews {
                                                
                                                if subview.tag == 10 {
                                                    
                                                    subview.removeFromSuperview()//remove from the screen itself
                                                    
                                                }
                                                
                                            }
                                            
                                        })
                                    }))
                                    
                                    self.present(alertController, animated: true, completion: nil)
                                    
                                }
                            }
                        })
                }
            }
            
        } catch {
            
            print("Could not get images")
            
        }
    }
    
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = false
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(UserTableViewController.checkForMessages), userInfo: nil, repeats: true)
     
        
        let query = PFUser.query()
        
        query?.whereKey("username", notEqualTo: (PFUser.current()?.username)!)
        
        do {
            
        let users = try query?.findObjects()
            
            if let users = users as? [PFUser] {
                
                for user in users {
                    
                    self.usernames.append(user.username!)
                    
                }
                
                tableView.reloadData()
                
            }
            
            
        } catch {
            
            print ("Could not get users")
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usernames.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "logout" {
            
            PFUser.logOut()
            
            timer.invalidate()
            
            self.navigationController?.navigationBar.isHidden = true
            
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = usernames[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        recipientUsername = usernames[indexPath.row]
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = false
        
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            print("Image returned")
            
            let imageToSend = PFObject(className: "Image")
            
            imageToSend["photo"] = PFFile(name: "photo.png", data: UIImagePNGRepresentation(image)!)
            
            imageToSend["senderUsername"] = PFUser.current()?.username
            
            imageToSend["recipientUsername"] = recipientUsername
            
            imageToSend.saveInBackground(block: { (success, error) in
                
                var title = "Sending Failed"
                var description = "Please try again later"
                
                if success {
                    
                    title = "Message Sent!"
                    description = "Your message has been sent."
                    
                }
                
                let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    
                    alertController.dismiss(animated: true, completion: nil)
                    
                }))
                
                self.present(alertController, animated: true, completion: nil)
                
            })
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
