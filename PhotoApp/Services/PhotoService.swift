//
//  PhotoService.swift
//  PhotoApp
//
//  Created by Michael Shustov on 04.11.2021.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseEmailAuthUI

class PhotoService {
    
    static func savePhoto(image: UIImage) {
        
        // Check that there is user logged in
        if Auth.auth().currentUser == nil {
            return
        }
        
        // Get the data representation of the UIImage
        let photoData = image.jpegData(compressionQuality: 0.1)
        
        guard photoData != nil else {
            return
        }
        
        // Create a file name
        let filename = UUID().uuidString
        
        // Get the user id of the current user
        let userId = Auth.auth().currentUser!.uid
        
        // Create a firebase storage path/reference
        let ref = Storage.storage().reference().child("images/\(userId)/\(filename).jpg")
        
        // Upload the data
        ref.putData(photoData!, metadata: nil) { metadata, error in
            
            // Check if upload was successful
            if error == nil {
                
                // Upon successfull upload, create the data base entry
                self.createDatabaseEntry(ref: ref)
            }
        }
    }
    
    private static func createDatabaseEntry(ref: StorageReference) {
        
        // Download url
        ref.downloadURL { url, error in
            
            if error == nil {
                
                // Photo id
                let photoId = ref.fullPath
                
                // Get the current user
                let photoUser = LocalStorageService.loadUser()
                
                // User id
                let userId = photoUser?.userId
                
                // Username
                let username = photoUser?.username
                
                // Date
                let df = DateFormatter()
                df.dateStyle = .full
                
                let dateString = df.string(from: Date())
                
                // Create a dictionary of the photo metadata
                let metadata = ["photoId":photoId, "byId":userId!, "byUsername":username!, "date":dateString, "url":url!.absoluteString]
                
                // Save the metadata to the Firestore database
                let db = Firestore.firestore()
                
                db.collection("photos").addDocument(data: metadata) { error in
                    
                    
                }
            }
        }
    }
}
