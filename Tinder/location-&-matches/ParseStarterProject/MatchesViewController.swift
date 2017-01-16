//
//  MatchesViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Rob Percival on 08/07/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class MatchesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var images = [UIImage]()//contains photos of users that meet the query
    var userIds = [String]()//this is for the hiddel label
    var messages = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let query = PFUser.query()
        
        query?.whereKey("accepted", contains: PFUser.current()?.objectId)//we want to get the users that have accepted our logged in user
        
        query?.whereKey("objectId", containedIn: PFUser.current()?["accepted"] as! [String])//we want to get the users that have been accepted by our logged in user
        
        query?.findObjectsInBackground(block: { (objects, error) in
            
            if let users = objects {
                
                //if we do find users that have been accepted by the logged in user and vice versa
                
                for object in users {//we loop through the users
                    
                    if let user = object as? PFUser {
                        
                        //we need to get their picture in order to display it to the logged in user
                        
                        let imageFile = user["photo"] as! PFFile
                        
                        imageFile.getDataInBackground(block: { (data, error) in
                            
                            if let imageData = data {
                                
                                //now we want to obtain all the messages (if they exist) sent to our logged in user by the user that we are currently manipulating
                                
                                let messageQuery = PFQuery(className: "Message")
                                
                                messageQuery.whereKey("recipient", equalTo: (PFUser.current()?.objectId!)!)//the recipient is our logged in user
                                
                                messageQuery.whereKey("sender", equalTo: user.objectId!)
                                
                                messageQuery.findObjectsInBackground(block: { (objects, error) in
                                    
                                    var messageText = "No message from this user."//this is the default
                                    
                                    if let objects = objects {
                                        
                                        //if messages exist between users, then we want to create a message
                                        
                                        for message in objects {
                                                
                                                if let messageContent = message["content"] as? String {
                                                    
                                                    messageText = messageContent
                                                    
                                                }
                                        }
                                        
                                    }
                                    
                                    self.messages.append(messageText)
                                    
                                    self.images.append(UIImage(data: imageData)!)//we add the photo of the user meeting the query
                                    
                                    self.userIds.append(user.objectId!)
                                    
                                    self.tableView.reloadData()
                                    
                                    
                                })
                            }
                        })
                    }
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return images.count
        
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MatchesTableViewCell
        
        //we can use the outlet of userImageView (defined in MatchesTableViewCell.swift) because our cell is of the type of MatchesTableViewCell
        cell.userImageView.image = images[indexPath.row]

        cell.messagesLabel.text = "You haven't received a message yet"
        
        cell.userIdLabel.text = userIds[indexPath.row]
        
        cell.messagesLabel.text = messages[indexPath.row]
        
        return cell
        
        
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
