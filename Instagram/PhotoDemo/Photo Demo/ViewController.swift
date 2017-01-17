//
//  ViewController.swift
//  Photo Demo
//
//  Created by Tak Tran on 20/10/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    //this function is to process the image selected by the user
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {//info is a var. that contains the image
            
            imageView.image = image //we are displaying the image selected in the simulator screen
            
        } else {
            
            print ("There was a problem with the image")
        }
        
        self.dismiss(animated: true, completion: nil)//this will close the imagePickerController after the image is selected
    }
    
    //this code is for accessing the photo library in the user's device when the button is clicked
    @IBAction func importImage(_ sender: AnyObject) {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self//the viewController has control over the imagePickerController
        
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary //enables accesss to photo library
        //you can also obtain access to the actual camera with UIImagePickerControllerSourceType.camera
        
        imagePickerController.allowsEditing = false
        
        //completion is nil since we do not have to do anything when the imagePickerController is presented
        //imagePickerController represents the UIViewController, this is possible since we delegated the imagePickerController to our ViewController
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

