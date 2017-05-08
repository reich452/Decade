//
//  DecadeImageTableViewCell.swift
//  Decade
//
//  Created by Nick Reichard on 5/1/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class DecadeImageTableViewCell: UITableViewCell {
    
    weak var delegate: isLikedButtonTappedTableViewCellDelegate?
    
    @IBOutlet weak var decadeNameLabel: UILabel!
    @IBOutlet weak var decadeImageView: UIImageView!
//    @IBOutlet weak var isLikedButton: UIButton!
    
    var decade: Decade? {
        didSet {
            updateViews()
        }
    }
    
//    var user: User? {
//        didSet {
//            updateViews()
//        }
//    }
    
    private func updateViews() {
        guard let decade = decade else { return }
        
            self.decadeNameLabel.text = decade.imageName
            self.decadeImageView.image = decade.decadeImage
        
//        let heartImage = user.likedImage ? #imageLiteral(resourceName: "redHear") : #imageLiteral(resourceName: "heart")
//        isLikedButton.setImage(heartImage, for: .normal)
    }
}

protocol isLikedButtonTappedTableViewCellDelegate: class {
    func isCompleteButtonTapped(sender: DecadeImageTableViewCell)
}
