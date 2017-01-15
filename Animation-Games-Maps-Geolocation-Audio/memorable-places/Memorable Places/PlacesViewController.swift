//
//  PlacesViewController.swift
//  Memorable places
//
//  Created by Hernán Iruegas Villarreal on 23/12/16.
//  Copyright © 2016 Hernán Iruegas Villarreal. All rights reserved.
//

import UIKit

var places = [Dictionary<String, String>()]//is an array of dictionaries that have two strings and is initially empty
var activePlace = -1

class PlacesViewController: UITableViewController {
    
    
    @IBOutlet var table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //we are retrieving the places that have already been saved
        if let tempPlaces = UserDefaults.standard.object(forKey: "places") as? [Dictionary<String, String>] { // UserDefaults.standard() is now UserDefaults.standard
            
            places = tempPlaces //places array gets updated
            
        }
        
        if places.count == 1 && places[0].count == 0 { //if the places array is empty; just contains an empty dictionary
            
            places.remove(at: 0)//we remove the empty dictionary
            
            places.append(["name":"Taj Mahal","lat":"27.175277","lon":"78.042128"])//add the default place
            
            UserDefaults.standard.set(places, forKey: "places") // UserDefaults.standard() is now UserDefaults.standard
            
        }
        
        activePlace = -1
        
        table.reloadData()
        
        
    }
    
    //this function is for the user to be able to edit the rows of the table
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //this function is for the user to be able to edit the rows of the table
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            places.remove(at: indexPath.row)//remove location from the places array
            
            UserDefaults.standard.set(places, forKey: "places") // UserDefaults.standard() is now UserDefaults.standard
            
            table.reloadData()
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return places.count//returns 1 row at least, showing default place
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        if places[indexPath.row]["name"] != nil {
            
            cell.textLabel?.text = places[indexPath.row]["name"]
            
        }
        
        return cell
    }
    
    //this function is for the segueway to occur
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        activePlace = indexPath.row
        
        performSegue(withIdentifier: "toMap", sender: nil)
        
    }
}
