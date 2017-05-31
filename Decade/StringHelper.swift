//
//  StringHelper.swift
//  Decade
//
//  Created by Nick Reichard on 5/31/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

extension String {
    
    var decadeYear: String? {
        let stringArray = self.components(separatedBy: CharacterSet.decimalDigits.inverted)
        return stringArray.filter({$0.characters.count == 4}).first
    }
}
