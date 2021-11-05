//
//  Constants.swift
//  PhotoApp
//
//  Created by Michael Shustov on 01.11.2021.
//

import Foundation

struct Constants {
    
    struct Storyboard {
        
        static let photoCellId = "PhotoCell"
        static let loginNavController = "loginNavController"
        static let tabBarController = "mainTabBarController"
        static let profileSegue = "goToCreateProfile"
        
    }
    
    struct LocalStorage {
        
        static let userIdKey = "storedId"
        static let usernameKey = "storedName"
        
    }
}
