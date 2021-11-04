//
//  CameraViewController.swift
//  PhotoApp
//
//  Created by Michael Shustov on 30.10.2021.
//

import UIKit

class CameraViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func savePhoto(image: UIImage) {
        
        // Call the photo service to store the photo
        PhotoService.savePhoto(image: image)
    }
}
