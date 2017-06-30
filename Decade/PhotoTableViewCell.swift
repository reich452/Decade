//
//  PhotoTableViewCell.swift
//  Decade
//
//  Created by Nick Reichard on 6/27/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentLable: UILabel!
    
    var photo: Photo? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let photo = self.photo, let dateYear = photo.timestamp.currentYear else { return }
        
        
        DispatchQueue.main.async {
            self.userPhotoImageView.image = photo.photoImage
            self.commentLable.text = photo.caption
            self.dateLabel.text = "\(dateYear)"
        }
    }
}
