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
        
        //this variable refers to the AppDelegate.swift file, which has methods to handle CoreData
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //context helps us access CoreData or retrieve info.
        let context = appDelegate.persistentContainer.viewContext
        
        /***********************
         this is the part of creating users, which we no longer need
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        
        newUser.setValue("ralphie", forKey: "username")
        newUser.setValue("myPass", forKey: "password")
        newUser.setValue(2, forKey: "age")
         
        do {
            
            try context.save()
            
            print("Saved")
            
        } catch {
            
            print("There was an error")
            
        }
 
        ***********************/
        
        //request serve to access coreData
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        /***********************
        
        request.predicate = Predicate(format: "username = %@", "ralphie")//this lets us look for specific data
        //%@ means any object
        //it means look for username equals something, where that something is ralphie
         
        ***********************/
 
        //by default, when the request is run, the device instead of returning the actual values, it returns Faults,
        //which we do not want, that is why we set it to equal to false
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(request)
            
            if results.count > 0 {
                
                //we cast NSFetchRequestResult to an array of NSManagedObjects
                for result in results as! [NSManagedObject] {
                    
                    if let username = result.value(forKey: "username") as? String {
                        
                        /***********************
                         
                        context.delete(result)
                        
                        do {
                            
                            try context.save()
                            
                        } catch {
                            
                            print("Delete failed")
                            
                        }
                        
                         ***********************/
                        
                        /***********************
                         this part is for updating the value of username; changing it from whatever to Dooley
 
                        result.setValue("Dooley", forKey: "username")
                        
                         do {
                         
                         try context.save()
                         
                         } catch {
                         
                         print("Rename failed")
                         
                         }
                        
                        ***********************/
                        
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

