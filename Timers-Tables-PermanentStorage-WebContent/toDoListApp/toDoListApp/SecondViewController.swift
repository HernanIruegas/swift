//
//  SecondViewController.swift
//  toDoListApp
//
//  Created by Hernán Iruegas Villarreal on 19/12/16.
//  Copyright © 2016 Hernán Iruegas Villarreal. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var addItemTextField: UITextField!

    
    @IBAction func addButton(_ sender: Any) {
        
        let itemObject = UserDefaults.standard.object(forKey: "items")//we are trying to retrieve a possibly existing array
        
        var items:  [String]
        
        //we are either adding a new item to the existing array or creating a new array
        if let Tempitems = itemObject as?  [String]{
            
            items = Tempitems
            
            items.append(addItemTextField.text!)
            
        }
        else {//if there is no saved array, then create one with the item given by the user
            
             items = [addItemTextField.text!]
        }
        
        
        UserDefaults.standard.set(items, forKey: "items")//save the array
        
        addItemTextField.text = ""
        
    }
    
    //keyboard functionality
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //keyboard functionality
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
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

