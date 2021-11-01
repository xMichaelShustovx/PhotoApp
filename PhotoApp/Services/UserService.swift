//
//  UserService.swift
//  PhotoApp
//
//  Created by Michael Shustov on 01.11.2021.
//

import Foundation
import FirebaseFirestore

class UserService {
    
    static func createProfile(userId: String, userName: String, completion: @escaping (PhotoUser?) -> Void) {
        
        // Create a dictionary for the profile data
        let profileData = ["username":userName]
        
        // Get a firestore reference
        let db = Firestore.firestore()
        
        // Create the document for the user id
        db.collection("users").document(userId).setData(profileData) { error in
            
            if error == nil {
                
                // Profile was created successfully
                // Create and return a photo user
                var u = PhotoUser()
                u.userId = userId
                u.username = userName
                
                completion(u)
            }
            else {
                // Smth went wrong
                // Return nil
                completion(nil)
            }
        }
    }
    
    static func retrieveProfile(userId: String, completion: @escaping (PhotoUser?) -> Void) {
        
        // Get a Firestore reference
        let db = Firestore.firestore()
        
        // Check for a profile, given the user id
        db.collection("users").document(userId).getDocument { docSnapshot, error in
            
            if error != nil && docSnapshot == nil {
                
                // Smth wrong
                return
            }
            
            if let profile = docSnapshot!.data() {
                
                // Profile was found, create new photo user
                var u = PhotoUser()
                u.userId  = userId
                u.username = profile["username"] as? String
                
                completion(u)
            }
            else {
                
                // Couldn't get profile
                // Return nil
                completion(nil)
            }
        }
    }
    
}
