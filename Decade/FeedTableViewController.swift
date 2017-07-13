//
//  FeedTableViewController.swift
//  Decade
//
//  Created by Nick Reichard on 6/27/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController, PhotoUpdateToDelegate, UserPhotoShareButtonTappedDelegate {
    
    fileprivate let feedCell = "feedCell"
    
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
    
    func userShareButtonTapped(_ sender: PhotoTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        
        let photo = PhotoController.shared.photos[indexPath.row]
        let userPhoto = photo.photoImage
        let timestamp = photo.timestamp
        let caption = photo.caption
        
        let activityVC = UIActivityViewController.init(activityItems: [userPhoto, timestamp, caption], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return PhotoController.shared.photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: feedCell, for: indexPath) as? PhotoTableViewCell else { return UITableViewCell() }
        
        let photo = PhotoController.shared.photos[indexPath.row]
        cell.photo = photo
        cell.delegate = self
        cell.shareButtonTapped(self)
        
        return cell
    }
}
