//
//  PhotoCell.swift
//  PhotoApp
//
//  Created by Michael Shustov on 05.11.2021.
//

import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var photo: Photo?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func displayPhoto(photo: Photo) {
        
        // Reset the image
        self.photoImageView.image = nil
        
        // Set photo property
        self.photo = photo
        
        // Set the username
        usernameLabel.text = photo.byUsername
        
        // Set the date
        dateLabel.text = photo.date
        
        // Check that there is a valid download url
        if photo.url == nil {
            return
        }
        
        // Check if the image is in our image cache
        if let image = ImageCacheService.getImage(url: photo.url!) {
            
            // Use the cached image
            DispatchQueue.main.async {
                
                self.photoImageView.image = image
            }
            
            // Skip the rest of the code as we don't need to download image
            return
        }
        
        // Download the image
        let url = URL(string: photo.url!)
        
        // Check url isn't nil
        if url == nil {
            return
        }
        
        // Use URL session to download image asynchronously
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            if error == nil && data != nil {
                
                // Check that the image data we downloaded matches the photo this cell is currently supposed to display
                if url!.absoluteString != self.photo?.url {
                    
                    // The url we downloaded doesn't match the url this cell is currently displaying
                    return
                }
                
                // Get the image view
                let image = UIImage(data: data!)
                
                // Store the image data in cache
                ImageCacheService.saveImage(url: url!.absoluteString, image: image)
                
                // Set the image view
                DispatchQueue.main.async {
                    self.photoImageView.image = image
                    
                }
            }
        }
        // Start the data task
        dataTask.resume()
    }
}
