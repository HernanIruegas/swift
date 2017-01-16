//
//  ViewController.swift
//  Log In Demo
//
//  Created by Rob Percival on 04/07/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    
    @IBOutlet var label: UILabel!
    
    @IBOutlet var logInButton: UIButton!
    
    
    @IBAction func logIn(_ sender: AnyObject) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newValue = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        
        newValue.setValue(textField.text, forKey: "name")//we are creating a new user
        
        do {//we are saving the new user info.
            
            try context.save()
            
            textField.alpha = 0
            
            logInButton.alpha = 0
            
            label.alpha = 1
            
            label.text = "Hi there " + textField.text! + "!"
            
        } catch {
            
            print("Failed to save")
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //we first look in coreData to see if there is a username saved
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(request)
            
            for result in results as! [NSManagedObject] {//looping thorugh results
                
                if let username = result.value(forKey: "name") as? String {//if we already have users saved
                    
                    textField.alpha = 0
                    
                    logInButton.alpha = 0
                    
                    label.alpha = 1
                    
                    label.text = "Hi there " + username + "!"
                    
                }
                
            }
            
            
        } catch {
            
            print("Request failed")
            
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

