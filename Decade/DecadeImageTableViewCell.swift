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
    @IBOutlet weak var isLikedButton: UIButton!
    
    var decade: Decade? {
        didSet {
            updateViews()
        }
    }
    
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
        
        if currentUser.imageIds.contains(decade.imageIds) {
            isLikedButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
            guard let index = currentUser.imageIds.index(of: decade.imageIds) else {
                print("Could not find index for decade.contentUrlString"); return }
            currentUser.imageIds.remove(at: index)
            UserController.shared.updateUserInCloudKit()
        } else {
            isLikedButton.setImage(#imageLiteral(resourceName: "redHear"), for: .normal)
            currentUser.imageIds.append(decade.imageIds)
            UserController.shared.updateUserInCloudKit()
        }
    }
    
    private func updateViews() {
        guard let decade = decade, let user = UserController.shared.currentUser else { return }
        
        self.decadeNameLabel.text = decade.imageName
        self.decadeImageView.image = decade.decadeImage
        
        if user.imageIds.contains(decade.contentUrlString) {
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
