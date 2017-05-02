//
//  DecadeCollectionViewCell.swift
//  Decade
//
//  Created by Nick Reichard on 5/1/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class DecadeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var decadeImageView: UIImageView!
    
    var decade: Decade? {
        didSet{
            updateViews()
        }
    }
    
    func updateViews() {
        
        let image = #imageLiteral(resourceName: "meal")
        self.decadeImageView.image = image
    }
    
}
