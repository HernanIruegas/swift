//
//  ViewController.swift
//  Sound Shaker
//
//  Created by Rob Percival on 21/06/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        
        if event?.subtype == UIEventSubtype.motionShake {
            
            let soundArray = ["boing", "explosion", "hit", "knife", "shoot", "swish", "wah", "warble"]
            
            let randomNumber = Int(arc4random_uniform(UInt32(soundArray.count))) //arc4random only takes as argument a UInt32 number, which consists of 4 bytes; we cast this number as an integer
            
            let fileLocation = Bundle.main.path(forResource: soundArray[randomNumber], ofType: "mp3") // Bundle.main().pathForResource(soundArray[randomNumber], ofType: "mp3") is now Bundle.main.path(forResource: soundArray[randomNumber], ofType: "mp3")
            
            do {
                
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileLocation!))
                
                player.play()
                
            } catch {
                
                // process error
                
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

