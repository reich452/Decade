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
            
        }
    }

}
