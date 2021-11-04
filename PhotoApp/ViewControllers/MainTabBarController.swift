//
//  MainTabBarController.swift
//  PhotoApp
//
//  Created by Michael Shustov on 04.11.2021.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        // Detect wich tab was tapped on
        if item.tag == 2 {
            
            // Create the action sheet
            let actionSheet = UIAlertController(title: "Add a Photo", message: "Select a source:", preferredStyle: .actionSheet)
            
            // Check if there is a camera on the device
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                // Create and add a Camera button
                let cameraButton = UIAlertAction(title: "Camera", style: .default) { action in
                    
                    // Display the IUImagePickerController set to camera mode
                    self.showImagePickerController(mode: .camera)
                }
                actionSheet.addAction(cameraButton)
            }
            
            // Check if library is available on the device
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                
                // Create and add a Photo Library button
                let libraryButton = UIAlertAction(title: "Photo Library", style: .default) { action in
                    
                    // Display the IUImagePickerController set to library mode
                    self.showImagePickerController(mode: .photoLibrary)
                }
                actionSheet.addAction(libraryButton)
            }

            // Create and add a Cancel button
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            actionSheet.addAction(cancelButton)
            
            // Display the action sheet
            present(actionSheet, animated: true, completion: nil)
        }
    }
    
    func showImagePickerController(mode: UIImagePickerController.SourceType) {
        
        // Create the picker and set the mode
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = mode
        
        // Set the tab bar controller as the delegate
        imagePicker.delegate = self
        
        // Present the image picker
        present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: - Image Picker Delegate Methods
extension MainTabBarController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        // Dismiss the image picker
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Get a reference to the selected photo
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        let selectedImageMetaData = info[UIImagePickerController.InfoKey.mediaMetadata] as? NSDictionary
        
        // Check if there is an image selected
        if let selectedImage = selectedImage {
            
            // Get a reference to the camera view controller
            let cameraVC = self.selectedViewController as? CameraViewController
            
            if let cameraVC = cameraVC {
                
                // Upload it
                cameraVC.savePhoto(image: selectedImage)
            }
        }
        
        // Dismiss the image picker
        dismiss(animated: true, completion: nil)
    }
}
