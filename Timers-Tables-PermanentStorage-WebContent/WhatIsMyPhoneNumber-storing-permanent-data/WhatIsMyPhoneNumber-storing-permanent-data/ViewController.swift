//
//  ViewController.swift
//  WhatIsMyPhoneNumber-storing-permanent-data
//
//  Created by Hernán Iruegas Villarreal on 18/12/16.
//  Copyright © 2016 Hernán Iruegas Villarreal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    @IBAction func button(_ sender: Any) {
        
        UserDefaults.standard.set(textField.text, forKey: "number")
        
        resultLabel.text = "Your phone number has been saved!"
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let numberObject = UserDefaults.standard.object(forKey: "number")
        
        if let number = numberObject as? String {
            
            textField.text = number
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

