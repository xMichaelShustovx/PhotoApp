//
//  FeedViewController.swift
//  PhotoApp
//
//  Created by Michael Shustov on 30.10.2021.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set view controller as the table view data source and delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        // Add pull to refresh
        addRefreshControl()

        // Call the PhotoService to retrive the photos
        PhotoService.retrievePhotos { photos in
            
            // Set photos array
            self.photos = photos
            
            // Reload table view
            self.tableView.reloadData()
        }
        
    }
    
    func addRefreshControl() {
     
        // Add refresh control
        let refresh = UIRefreshControl()
        
        // Set target
        refresh.addTarget(self, action: #selector(refreshFeed(refreshControl:)), for: .valueChanged)
        
        // Add to table view
        self.tableView.addSubview(refresh)
    }
    
    @objc func refreshFeed(refreshControl: UIRefreshControl) {
        
        // Call the photo service
        PhotoService.retrievePhotos { newPhotos in
            
            // Assign new photos to our property
            self.photos = newPhotos
            
            DispatchQueue.main.async {
                
                // Refesh table view
                self.tableView.reloadData()
                
                // Stop the spinner
                refreshControl.endRefreshing()
            }
        }
    }
}

// MARK: - Table View Delegate Methods
extension FeedViewController: UITableViewDataSource & UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a Photo Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.photoCellId, for: indexPath) as? PhotoCell
        
        // Get the photo this cell is displaying
        let currentPhoto = photos[indexPath.row]
        
        // Call display photo method of the cell
        cell?.displayPhoto(photo: currentPhoto)
        
        // Return the cell
        return cell!
    }
}
