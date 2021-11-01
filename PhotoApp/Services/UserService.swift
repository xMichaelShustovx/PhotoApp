//
//  UserService.swift
//  PhotoApp
//
//  Created by Michael Shustov on 01.11.2021.
//

import Foundation
import FirebaseFirestore

class UserService {
    
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
                u.userName = profile["userName"] as? String
                
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
