//
//  ViewController.swift
//  CatYears-Swift
//
//  Created by Hernán Iruegas Villarreal on 10/12/16.
//  Copyright © 2016 Hernán Iruegas Villarreal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var labelCatYEars: UILabel!
    
    @IBAction func Button(_ sender: Any) {
        
        let ageCatYears = Int(TextField.text!)!*7;
        
        labelCatYEars.text = String(ageCatYears);
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

