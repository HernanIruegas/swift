//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Rob Percival on 21/06/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // UIApplication.shared().delegate as! AppDelegate is now UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext //allows us to access the coreData DB
        
        //allows us to insert a new object to Users entity
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context) //this refers to a specific entity defined in the coreData file
        
        newUser.setValue("kirsten", forKey: "username")//we are using the attributes defined in the Users entity to create
        newUser.setValue("myPass", forKey: "password")//our new user
        newUser.setValue(35, forKey: "age")
        
        do {//this saves the context created for the created user
            
            try context.save()
            
            print("Saved")
            
        } catch {
            
            print("There was an error")
            
        }
        
        //request is an array
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")//returns an object of type NSFetchRequestResult
        
        request.returnsObjectsAsFaults = false //if it was set to "true", instead of the request returning the actual values inside the DB, it would return "Faults"
        
        do {
            //we are trying to retrieve the info. of the new user created and saved
            let results = try context.fetch(request)//this will however, return all the values stored in the entity
            
            if results.count > 0 {//if there are users stored in Users entity
                
                for result in results as! [NSManagedObject] {
                    
                    if let username = result.value(forKey: "username") as? String {
                        
                        print(username)
                        
                    }
                    
                }
                
                
            } else {
                
                print("No results")
                
            }
            
            
        } catch {
            
            print("Couldn't fetch results")
            
        }
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

