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
    @IBOutlet weak var yearLable: UILabel!

    var users: User?
    weak var delegate: SavedDecadeTableViewCellDelegate?
    
    var decade: Decade? {
        didSet {
            self.updateViews()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        delegate?.shareButtonTapped(self)
    }
    
    @IBAction func postButtonTapped(_ sender: Any) {
    
    }
    
    
    private func updateViews() {
        guard let decade = decade else { return }
        DispatchQueue.main.async {
            self.decadeImageView.image = decade.decadeImage
            self.decadeNameLabel.text = decade.imageName
            self.yearLable.text = decade.imageName.decadeYear
        }
    }
    
}

protocol SavedDecadeTableViewCellDelegate: class {
    func shareButtonTapped(_ sender: SavedDecadeTableViewCell)
}


