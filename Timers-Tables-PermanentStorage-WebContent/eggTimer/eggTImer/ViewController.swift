//
//  ViewController.swift
//  eggTImer
//
//  Created by Hernán Iruegas Villarreal on 17/12/16.
//  Copyright © 2016 Hernán Iruegas Villarreal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = Timer()
    var counter = 210

    
    @IBOutlet weak var timerLabel: UILabel!
    
    func decreaseTimer(){
        
        if(counter > 0){
            counter -= 1
            timerLabel.text = String(counter)
        }
        else {
            timer.invalidate()
        }
    }
    

    @IBAction func playTimer(_ sender: Any) {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.decreaseTimer), userInfo: nil, repeats: true)
        
    }
    
    
    
    @IBAction func pauseTimer(_ sender: Any) {
        
        timer.invalidate()
    
    }
    
    
    
    @IBAction func minusTen(_ sender: Any) {
    
        if(counter > 10){
            counter -= 10
            timerLabel.text = String(counter)
        }
    
    }
    
    @IBAction func plusTen(_ sender: Any) {
    
        counter += 10
        timerLabel.text = String(counter)
    
    }
    
    @IBAction func resetTimer(_ sender: Any) {
    
        counter = 210
        timerLabel.text = String(counter)
    
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

