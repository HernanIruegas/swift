//
//  FeedTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Rob Percival on 08/07/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class FeedTableViewController: UITableViewController {
    
    var users = [String: String]()//dictionary; shows each username for each userID
    var messages = [String]()//array
    var usernames = [String]()//array
    var imageFiles = [PFFile]()//array; where we store our images

    override func viewDidLoad() {
        super.viewDidLoad()

        let query = PFUser.query()
        
        query?.findObjectsInBackground(block: { (objects, error) in//find all the users in parse
            
            if let users = objects {
                
                self.users.removeAll()
                
                for object in users {//loop thorugh the users
                    
                    if let user = object as? PFUser {//for each object we attempt to make a user
                        
                        self.users[user.objectId!] = user.username!//we store in the dictionary the userID and its username; the objectId is created by parse automatically to each user, and it is unique
                     
                        //now we have a dictionary containing all of our users in parse
                    }
                    
                    
                }
                
            }
            
            //now that we have all of our users, we want to know which ones are being followed by the logged in user
            
            //Followers has all the info. about the following and follower relationship
            let getFollowedUsersQuery = PFQuery(className: "Followers")
            
            getFollowedUsersQuery.whereKey("follower", equalTo: (PFUser.current()?.objectId!)!)//here we find which users are being followed by the logged in user
            
            getFollowedUsersQuery.findObjectsInBackground(block: { (objects, error) in
                
                if let followers = objects {
                    
                    for object in followers {
                        
                        if let follower = object as? PFObject {
                            
                            let followedUser = follower["following"] as! String//here we get who are they following
                            
                            let query = PFQuery(className: "Posts")
                            
                            query.whereKey("userid", equalTo: followedUser)//we get all the posts made by the followedUser
                            
                            query.findObjectsInBackground(block: { (objects, error) in
                                
                                if let posts = objects {
                                    
                                    for object in posts {
                                        
                                        if let post = object as? PFObject {
                                            
                                            //we extract the details from our object
                            
                                            self.messages.append(post["message"] as! String)
                                            
                                            self.imageFiles.append(post["imageFile"] as! PFFile)//this PFFile is just a pointer to our image, we haven't downloaded it
                                            
                                            self.usernames.append(self.users[post["userid"] as! String]!)
                                            
                                            self.tableView.reloadData()
                                            
                                        }
                                    }
                                }
                            })
                        }
                    }
                }
            })
        })
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
        return messages.count
    }

   
    //here we display the images, usernames and messages of the users being followed by the logged in user
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell

        //we need to download our image, remember that until now we only have a pointer to our image
        imageFiles[indexPath.row].getDataInBackground { (data, error) in
            
            if let imageData = data {
            
                if let downloadedImage = UIImage(data: imageData) {
                
                    cell.postedImage.image = downloadedImage
                
                }
                
            }
            
        }
        
        cell.postedImage.image = UIImage(named: "msn-people-person-profile-user-icon--icon-search-engine-11.png")
        
        cell.usernameLabel.text = usernames[indexPath.row]
        
        cell.messageLabel.text = messages[indexPath.row]
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
