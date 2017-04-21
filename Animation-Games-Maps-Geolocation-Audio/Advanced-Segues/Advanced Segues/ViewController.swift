//
//  ViewController.swift
//  Advanced Segues
//
//  Created by Rob Percival on 21/06/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

let globalVariable = "Rob"

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var activeRow = 0
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
        
    }
   
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = "Row \(indexPath.row)"
        
        return cell
        
    }
    
    //initiated whenever a table row is tapped, part of the UITableViewDelegate code
    //performs the segueway
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        activeRow = indexPath.row
        
        //initiate the segueway
        performSegue(withIdentifier: "toSecondViewController", sender: nil)
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    //this method is for the changing in viewControllers
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // Changed to remove "override" at the beginning
        
        if segue.identifier == "toSecondViewController" {
            
            //this variable represents the SecondViewController
            let secondViewController = segue.destination as! SecondViewController // destinationViewController is now called destination
            
            secondViewController.activeRow = activeRow
            
        }
        
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

