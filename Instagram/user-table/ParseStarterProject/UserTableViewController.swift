//
//  UserTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Rob Percival on 07/07/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class UserTableViewController: UITableViewController {
    
    var usernames = [""] //this will contain all of the usernames
    var userIDs = [""] //this helps to identify users uniquely
    var isFollowing = ["" : false] //dictionary with a string and a boolean; contains the userID and wether or not it is being followed by the logged in user
    

    @IBAction func logout(_ sender: AnyObject) {
        
        PFUser.logOut()
        
        performSegue(withIdentifier: "logoutSegue", sender: self) //we change from "Users" view controller to initial view controller
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = false //to get the nav. bar back
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1: we get the users to display on the table
        //2: we get to show a checkmark for the users being followed by the logged in user
        
        let query = PFUser.query()
        
        /***********we get the user we want to display on the table, and save his info.***********/
        //objects is an array of objects
        query?.findObjectsInBackground(block: { (objects, error) in
            
            if error != nil {
                
                print(error)
                
            } else if let users = objects {//we get all of the users in parse
                
                self.usernames.removeAll()//we remove the blank space in the usernames array and every other info.
                self.userIDs.removeAll()
                self.isFollowing.removeAll()
                
                for object in users {//loop through the users array
                    
                    if let user = object as? PFUser {//we cast the object to a PFUser individually
                        
                        if user.objectId != PFUser.current()?.objectId {//verifies that the user we want to display is not the one that is already logged in, since that would be unuseful
                        
                        let usernameArray = user.username!.components(separatedBy: "@")//we get rid of the second part of the user's email address (which in this case is also their username)...instead of having rob@hotmail.com we only get rob at position 0 and hotmail.com at position 1
                        
                        self.usernames.append(usernameArray[0])//we add the username (rob) to to usernames array
                        self.userIDs.append(user.objectId!)//we add the unique userID
        /***********we get the user we want to display on the table, and save his info.***********/
                            
        /***********show a checkmark for the users being followed by the logged in user***********/
                        //Followers is a class in parse that has all the info. about the following and follower relationship
                        let query = PFQuery(className: "Followers")
                        
                        //a whereKey allows us to find specific data
                        query.whereKey("follower", equalTo: (PFUser.current()?.objectId)!)//where the follower is equal to our user (logged in)
                        query.whereKey("following", equalTo: user.objectId!)
                        
                        query.findObjectsInBackground(block: { (objects, error) in
                            
                            if let objects = objects {//objects contains one user tops
                                
                                if objects.count > 0 {
                                    
                                    self.isFollowing[user.objectId!] = true//we save the userID in dictionary and confirm that it is being followed by the logged in user
                                    
                                } else {
                                    
                                    self.isFollowing[user.objectId!] = false//we save the userID in dictionary and confirm that it is not being followed by the logged in user
                                    
                                }
                              
                                if self.isFollowing.count == self.usernames.count {//if we have all the data for isFollowing
                                    
                                    self.tableView.reloadData()
                                    
                                }
        /***********show a checkmark for the users being followed by the logged in user***********/
                            }
                        })
                    }
                    }
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usernames.count //the amount of usernames
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = usernames[indexPath.row] //shows the username
        
        if isFollowing[userIDs[indexPath.row]]! {//if the person is already being followed, show a tick
            
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
            
        }

        return cell
    }
   
    
    //this func. means that the user has tapped on one of the rows
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //this code helps to follow and unfollow users
        //2: we create or eliminate the relationship between the user and the person it has followed or unfollowed, inside the followers class in parse
        
        let cell = tableView.cellForRow(at: indexPath)
        
        if isFollowing[userIDs[indexPath.row]]! {
            //if the logged in user taps on a user that is being currently followed by him, it means that it wants to unfollow him, so we need to remove the association in parse
            
            isFollowing[userIDs[indexPath.row]] = false//unfollow
            
            cell?.accessoryType = UITableViewCellAccessoryType.none//remove checkmark
            
            let query = PFQuery(className: "Followers")
            
            //we find the relationship in parse of the user following another user, so we remove it
            query.whereKey("follower", equalTo: (PFUser.current()?.objectId!)!)
            query.whereKey("following", equalTo: userIDs[indexPath.row])
            
            query.findObjectsInBackground(block: { (objects, error) in
                
                if let objects = objects {
                    
                    for object in objects {
                        
                        object.deleteInBackground()
                        
                    }
                    
                }
                
            })
            
        } else {
            
            isFollowing[userIDs[indexPath.row]] = true
        
            cell?.accessoryType = UITableViewCellAccessoryType.checkmark //the checkmark appears in the row
        
            let following = PFObject(className: "Followers")
        
            following["follower"] = PFUser.current()?.objectId //this is our current (logged in) user
            following["following"] = userIDs[indexPath.row] //this is the user that was clicked on
        
            following.saveInBackground()
            
        }
        
        
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
