//
//  ViewController.swift
//  Downloading Web Content
//
//  Created by Rob Percival on 20/06/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var webview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*
         
         let url = URL(string: "https://www.stackoverflow.com")!
         
         webview.loadRequest(URLRequest(url: url))
         
         webview.loadHTMLString("<h1>Hello there!</h1>", baseURL: nil)
         
         */
        
        if let url = URL(string: "https://www.stackoverflow.com") {
            
            let request = NSMutableURLRequest(url: url)
            
            //since we are working with queues, the code below the task function will occur at the same time
            //the print("Hi there!") will happen before the print(error) inside the task
            //we are working with multithreading
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                if error != nil {
                    
                    print(error)
                    
                } else {
                    
                    if let unwrappedData = data {
                        
                        let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                        
                        print(dataString)
                        
                        DispatchQueue.main.sync(execute: {
                            
                            //DispatchQueue.main is saying: we are now ready to rejoin the main queue and do something on it
                            //having this funciton improves speed
                            // Update UI
                            
                        })
                        
                        
                    }
                    
                    
                }
                
                
            }
            
            task.resume()
            
        }
        
        print("Hi there!")
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

