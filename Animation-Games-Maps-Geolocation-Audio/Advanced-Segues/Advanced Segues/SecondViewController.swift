//
//  SecondViewController.swift
//  Advanced Segues
//
//  Created by Rob Percival on 21/06/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var username = "rob"
    var activeRow = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(globalVariable)
        print(activeRow)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
