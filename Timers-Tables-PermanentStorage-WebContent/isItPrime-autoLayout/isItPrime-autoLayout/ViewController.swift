//
//  ViewController.swift
//  isItPrime-autoLayout
//
//  Created by Hernán Iruegas Villarreal on 17/12/16.
//  Copyright © 2016 Hernán Iruegas Villarreal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func primeButton(_ sender: Any) {
        
        if let userEnteredString = textField.text {
            
            //let userEnteredInteger = Int(userEnteredString)
            
            if let number = Int(userEnteredString) {
                
                var isPrime = true
                
                if number == 1 {
                    
                    isPrime = false
                    
                }
                
                var i = 2
                
                while i < number {
                    
                    if number % i == 0 {
                        
                        isPrime = false
                        
                    }
                    
                    i += 1
                    
                }
                
                if isPrime {
                    
                    resultLabel.text = "\(number) is prime!"
                    
                }
                else {
                    
                    resultLabel.text = "\(number) is not prime"
                    
                }
            }
            else {
                
                resultLabel.text = "Please enter a positive whole number"
                
            }
        }
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

