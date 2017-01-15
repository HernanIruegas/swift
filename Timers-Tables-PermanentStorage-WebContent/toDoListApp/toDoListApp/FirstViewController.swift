//
//  FirstViewController.swift
//  toDoListApp
//
//  Created by Hernán Iruegas Villarreal on 19/12/16.
//  Copyright © 2016 Hernán Iruegas Villarreal. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    
     var items: [String] = []
    
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return items.count
        
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
        let itemObject = UserDefaults.standard.object(forKey: "items") //this lets the user see his already saved toDoList with already saved tasks,(if they exist),when the view appears
        //itemObject is also an array; the same size as items
        
        if let Tempitems = itemObject as? [String]{
            
            items = Tempitems
            
        }
        
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete{
            
            items.remove(at: indexPath.row)
        }
        
        table.reloadData()
        
        UserDefaults.standard.set(items, forKey: "items") //saves the existing items array, without containing the deleted items

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

