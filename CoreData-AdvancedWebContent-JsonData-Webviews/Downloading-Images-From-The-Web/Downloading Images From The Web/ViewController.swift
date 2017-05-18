//
//  ViewController.swift
//  Downloading Images From The Web
//
//  Created by Rob Percival on 21/06/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    //1: download image, find the documents path and save it
    //2: attempt to restore it
    
    
    @IBOutlet var bachImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /**************
         the next code is for retrieving our already saved image from local storage, not from the web
        **************/
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        if documentsPath.count > 0 {
            
            let documentsDirectory = documentsPath[0]
            
            let restorePath = documentsDirectory + "/bach.jpg"
            
            bachImageView.image = UIImage(contentsOfFile: restorePath) //we want to create an image from a file
            
        }

        
        
        
        
        /*  in this whole commented out code, we first download an image from the web and in the second part we save it and associate it with a path
        
        //we are downloading an image from the web here
        let url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/6/6a/Johann_Sebastian_Bach.jpg")!
        
        let request = NSMutableURLRequest(url: url)
        
        //task is an asynchronous process
        let task = URLSession.shared().dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                
                print(error)
                
            } else {
                
                if let data = data {
                
                    if let bachImage = UIImage(data: data) {//we are creating an image from data
                
                        self.bachImageView.image = bachImage
                        
                        //if the image is already downloaded, we want to show it, not from the web, but from the device
                        //domainMask = where we are looking for our files: we want to search relative to user's directory
                        //documentsPath is an array of results
                        //we search for local directories within the app
                        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                    
                        if documentsPath.count > 0 {
                            
                            let documentsDirectory = documentsPath[0]
                                
                                let savePath = documentsDirectory + "/bach.jpg" //here is exactly were we save the path of our image
                                
                                do {
                                //compression quality is a number between 0 - 1
                                try UIImageJPEGRepresentation(bachImage, 1)?.write(to: URL(fileURLWithPath: savePath)) //we attach our image to its path
                                    
                                } catch {
                                    
                                    // process error
                                    
                                }
                        }
                    }
                }
            }
        }
        
        task.resume()
 
    */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

