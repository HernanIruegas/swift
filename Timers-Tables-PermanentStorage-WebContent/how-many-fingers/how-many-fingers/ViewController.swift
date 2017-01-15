//
//  ViewController.swift
//  how-many-fingers
//
//  Created by Hernán Iruegas Villarreal on 16/12/16.
//  Copyright © 2016 Hernán Iruegas Villarreal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func guessButton(_ sender: Any) {
        
        let random = String(arc4random_uniform(6))
        
        if(textField.text == random){
            resultLabel.text = "You are right"
        }
        else{
            resultLabel.text = "Wrong, it was \(random)"
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

