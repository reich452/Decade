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
    weak var delegateDestination: isLikedButtonTappedTVCellDelegateDestination?
    
    @IBOutlet weak var decadeNameLabel: UILabel!
    @IBOutlet weak var decadeImageView: UIImageView!
    @IBOutlet weak var isLikedButton: UIButton!
    
    var decade: Decade? {
        didSet {
            updateViews()
        }
    }
    
    var user: User? 
    
    // MARK: - Actions
    @IBAction func isLikedButtonTapped(_ sender: UIButton) {
        delegate?.isHeartButtonTapped(sender: self)
        updateLikeButton()
    }
    
    // MARK: - Methods
    func updateLikeButton() {
        guard let decade = decade,
            let currentUser = UserController.shared.currentUser
            else { return }
        
        if decade.ownerReference == currentUser.cloudKitRecordID {
            DecadeController.shared.saveLikedDecadeToCloudKit(decade: decade) {
                DispatchQueue.main.async {
                    self.isLikedButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
                }
            }
        } else {
            decade.owner = currentUser
            DecadeController.shared.saveLikedDecadeToCloudKit(decade: decade) {
                DispatchQueue.main.async {
                    self.isLikedButton.setImage(#imageLiteral(resourceName: "redHear"), for: .normal)
                }
            }
        }
    }
    
    private func updateViews() {
        guard let decade = decade, let user = UserController.shared.currentUser else { return }
        
        self.decadeNameLabel.text = decade.imageName
        self.decadeImageView.image = decade.decadeImage
        
        if decade.ownerReference == user.cloudKitRecordID {
            isLikedButton.setImage(#imageLiteral(resourceName: "redHear"), for: .normal)
            
        } else {
            isLikedButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
        }
    }
}

// MARK: - Protocol
protocol isLikedButtonTappedTableViewCellDelegate: class {
    func isHeartButtonTapped(sender: DecadeImageTableViewCell)
}

protocol isLikedButtonTappedTVCellDelegateDestination: class {
      func sendLikedImagesToSavedTVController(sender: DecadeImageTableViewCell)
}


