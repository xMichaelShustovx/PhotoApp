//
//  CreateProfileViewController.swift
//  PhotoApp
//
//  Created by Michael Shustov on 30.10.2021.
//

import UIKit
import FirebaseAuth

class CreateProfileViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func confirmTapped(_ sender: Any) {
        
        // Check that there is user logged in
        guard Auth.auth().currentUser != nil else {
            
            // No user logged in
            return
        }
        
        // Get the user name
        // Check it against white spaces, new lines, illegal characters, etc
        let username = usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Check that the username isn't nil
        if username == nil || username == "" {
            // Show an error message
            return
        }
        
        // Call the user service to create the profile
        UserService.createProfile(userId: Auth.auth().currentUser!.uid, userName: username!) { user in
            
            // Check if it was created successfully
            if user != nil {
                
                // If so, go to the tab bar controller
                
                // Save the user to the local storage
                LocalStorageService.saveUser(userId: user!.userId, username: user!.username)
                
                let tabBarVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabBarController)
                
                self.view.window?.rootViewController = tabBarVC
                self.view.window?.makeKeyAndVisible()
            }
            else {
                
                // If not, display error
            }
        }
    }
}
