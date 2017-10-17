//
//  DecadeCollectionViewCell.swift
//  Decade
//
//  Created by Nick Reichard on 5/1/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class DecadeHomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var decadeImageView: UIImageView!

    var decade: Decade? {
        didSet{
            updateViews()
        }
    }
    
    func updateViews() {
        guard let decade = decade else { return }
        decadeImageView.image = UIImage(named: (decade.imageName))
    }
    
}

