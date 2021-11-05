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

        // Call the PhotoService to retrive the photos
        PhotoService.retrievePhotos { photos in
            
            // Set photos array
            self.photos = photos
            
            // Reload table view
            self.tableView.reloadData()
        }
        
    }

}
