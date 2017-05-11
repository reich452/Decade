//
//  SavedDecadeTableViewCell.swift
//  Decade
//
//  Created by Nick Reichard on 5/10/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class SavedDecadeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var decadeImageView: UIImageView!
    @IBOutlet weak var decadeNameLabel: UILabel!
    
    var decade: Decade? {
        didSet {
            
        }
    }
    
    func updateViews() {
        guard let decade = decade, let savedImages = UserController.shared.currentUser?.imageIds else { return }
        DispatchQueue.main.async {
            self.decadeImageView.image = decade.decadeImage
            self.decadeNameLabel.text = decade.imageName
            
        }
    }
}
