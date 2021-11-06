//
//  CameraViewController.swift
//  PhotoApp
//
//  Created by Michael Shustov on 30.10.2021.
//

import UIKit

class CameraViewController: UIViewController {
    
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        doneButton.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Hide and reset all elements
        progressBar.alpha = 0
        progressBar.progress = 0
        
        progressLabel.alpha = 0
        
        doneButton.alpha = 0
        
    }
    
    func savePhoto(image: UIImage) {
        
        // Call the photo service to store the photo
        PhotoService.savePhoto(image: image) { pct in
            
            DispatchQueue.main.async {
                
                // Update progress bar
                self.progressBar.alpha = 1
                self.progressBar.progress = Float(pct)
                
                // Update label
                let roundedPct = Int(pct*100)
                self.progressLabel.text = "\(roundedPct)%"
                self.progressLabel.alpha = 1
                
                // Check if its done
                if pct == 1 {
                    self.progressLabel.text = "Upload Completed!"
                    self.doneButton.alpha = 1
                }
            }
        }
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        
        // Get a reference to the tab bar conrtroller
        let tabBarVC = self.tabBarController as? MainTabBarController
        
        if let tabBarVC = tabBarVC {
            
            // Call go to feed
            tabBarVC.goToFeed()
        }
    }
}
