//
//  ViewController.swift
//  weatherApp
//
//  Created by Hernán Iruegas Villarreal on 19/12/16.
//  Copyright © 2016 Hernán Iruegas Villarreal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func submitButton(_ sender: Any) {
        
        if let url = URL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest"){
            
        let request = NSMutableURLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            var message = ""
            
            if error != nil {
                print(error)
            }
            else{
                if let unwrappedData = data {//all the html code is assigned to unwrappedData
                    
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                    
                    var stringSeparator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                    
                    if let contentArray = dataString?.components(separatedBy: stringSeparator) {
                        
                        if contentArray.count > 1 {//if stringSeparator is not found inside the html code, then contentArray will contain one item, and that is the complete html code; that is why it needs to have more than 1 item,so that it confirms that it has found stringSeparator in the html
                            
                            stringSeparator = "</span>"
                            
                            let newContentArray = contentArray[1].components(separatedBy: stringSeparator)//contentArray[1] begins with the part that we are interested in 
                                //we want to remove separate everything that comes after it
                            
                            if newContentArray.count > 1 {
                                
                                message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                
                                print(message)
                                
                            }
                        }
                    }
                }
            }
            
            if message == "" {
                
                message = "The weather there couldn't be found. Please try again."
                
            }
            
            DispatchQueue.main.sync(execute: {
                
                self.resultLabel.text = message
                
            })
            
        }
        
        task.resume()
        }else {
            resultLabel.text = "The weather there couldn't be found. Please try again."
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

