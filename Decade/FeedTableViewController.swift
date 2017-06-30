//
//  FeedTableViewController.swift
//  Decade
//
//  Created by Nick Reichard on 6/27/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController, PhotoUpdateToDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PhotoController.shared.delegate = self
        
        
    }
    
    
    // MARK: Custom Protocol
    
    func photosWereUpdatedTo() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return PhotoController.shared.photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as? PhotoTableViewCell else { return UITableViewCell() }
        
        let photo = PhotoController.shared.photos[indexPath.row]
        cell.photo = photo
        
        return cell
    }
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
}
