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
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate        
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
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        /***********************
        
        request.predicate = Predicate(format: "username = %@", "ralphie")//this lets us look for specific data
        //%@ means any object
        //it means look for username equals something, where that something is ralphie
         
        ***********************/
 
 
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(request)
            
            if results.count > 0 {
                
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

