//
//  LocalStorageService.swift
//  PhotoApp
//
//  Created by Michael Shustov on 04.11.2021.
//

import Foundation


class LocalStorageService {
    
    static func saveUser(userId: String?, username: String?) {
        
        // Get a reference to user defaults
        let defaults = UserDefaults.standard
        
        // Save the user id and username to defaults
        defaults.setValue(userId, forKey: Constants.LocalStorage.userIdKey)
        defaults.setValue(username, forKey: Constants.LocalStorage.usernameKey)
    }
    
    static func loadUser() -> PhotoUser? {
        
        // Get a reference to user defaults
        let defaults = UserDefaults.standard
        
        // Get the username and id
        let userId = defaults.value(forKey: Constants.LocalStorage.userIdKey) as? String
        
        let username = defaults.string(forKey: Constants.LocalStorage.usernameKey)
        
        // Return the result
        if userId != nil && username != nil {
            
            return PhotoUser(userId: userId, username: username)
            
        }
        else {
            return nil
        }
    }
    
    static func clearUser() {
        
        // Get reference to user defaults
        let defaults = UserDefaults.standard
        
        // Clear the keys
        defaults.setValue(nil, forKey: Constants.LocalStorage.userIdKey)
        defaults.setValue(nil, forKey: Constants.LocalStorage.usernameKey)
    }
}
