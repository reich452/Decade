//
//  ImageSearch.swift
//  Decade
//
//  Created by Nick Reichard on 5/1/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation
import UIKit

class ImageSearch {
    
    let searchTerm: String
    var resultImages: [UIImage]
    let name: String
    let year: String?
    
    init(searchTerm: String, name: String, year: String?) {
        self.searchTerm = searchTerm
        self.resultImages = []
        self.name = name
        self.year = year
    }
}
