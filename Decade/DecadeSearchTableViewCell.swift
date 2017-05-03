//
//  DecadeSearchTableViewCell.swift
//  Decade
//
//  Created by Nick Reichard on 5/1/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class DecadeSearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var decadeImageView: UIImageView!
    @IBOutlet weak var decadeTitleLabel: UILabel!
    
    var decade: Decade? {
        didSet {
            self.updateViews()
        }
    }
    
    func updateViews() {
        guard let decade = decade else { return }
        
        DispatchQueue.main.async {
            self.decadeTitleLabel.text = decade.imageName
            self.decadeImageView.image = decade.decadeImage
        }
    }
}

