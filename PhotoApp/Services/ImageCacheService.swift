//
//  ImageCacheService.swift
//  PhotoApp
//
//  Created by Michael Shustov on 05.11.2021.
//

import Foundation
import UIKit

class ImageCacheService {
    
    private static var imageCache = [String : UIImage]()
    
    static func saveImage(url: String?, image: UIImage?) {
        
        // Check against nil
        if url == nil || image == nil {
            return
        }
        
        // Save the image
        imageCache[url!] = image!
    }
    
    static func getImage(url: String?) -> UIImage? {
        
        // Check the url isn't nil
        if url == nil {
            return nil
        }
        
        // Check the dictionary for the image
        return imageCache[url!]
    }
}
