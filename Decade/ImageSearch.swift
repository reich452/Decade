//
//  ImageSearch.swift
//  Decade
//
//  Created by Nick Reichard on 5/3/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation
import UIKit

struct ImageSearch {
    
    let searchTerm: String
    var resultImages: [UIImage]
    
    init(searchTerm: String) {
        self.searchTerm = searchTerm
        self.resultImages = []
    }
}
