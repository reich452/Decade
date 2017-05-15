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
        
        if currentUser.imageIds.contains(decade.imageId) {
            // Unliking a decade
            // You have to get the index of the decade.ImageID first. What decade do we want to remove??
            guard let index = currentUser.imageIds.index(of: decade.imageId) else { print("Cant find index of decade.imageID");return }
            currentUser.imageIds.remove(at: index)
            guard let indexAt = DecadeController.shared.likedDecades.index(where: {  $0.imageId == decade.imageId })
                else { print("Not equal inexAt"); return } // Similar to euatable
            let decadeToDelete = DecadeController.shared.likedDecades[indexAt]
            DecadeController.shared.deleteLikedDecadeFromCloudKit(decade: decadeToDelete, completion: {
                DecadeController.shared.likedDecades.remove(at: indexAt)
                UserController.shared.updateUserInCloudKit {
                    DispatchQueue.main.async {
                        self.isLikedButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
                    }
                }
            })
        } else {
            // Liking a decade
            currentUser.imageIds.append(decade.imageId)
            decade.owner = currentUser
            
            DecadeController.shared.saveLikedDecadeToCloudKit(decade: decade) { (recordID) in
                decade.cloudKitRecordID = recordID
                DecadeController.shared.likedDecades.append(decade)
                // Saving must complete before it can update. May take time if bad network
                UserController.shared.updateUserInCloudKit {
                    DispatchQueue.main.async {
                        self.isLikedButton.setImage(#imageLiteral(resourceName: "filledHeart"), for: .normal)
                    }
                }
            }
        }
    }
    
    private func updateViews() {
        guard let decade = decade, let user = UserController.shared.currentUser else { return }
        
        self.decadeNameLabel.text = decade.imageName
        self.decadeImageView.image = decade.decadeImage
        
        if user.imageIds.contains(decade.imageId) {
            isLikedButton.setImage(#imageLiteral(resourceName: "filledHeart"), for: .normal)
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


