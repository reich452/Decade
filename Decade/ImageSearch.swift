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
    
    private let imageNameKey = "name"
    private let contentUrlKey = "contentUrl"
    
   // var resultImages: [UIImage]
    let imageName: String
    let contentUrlString: String
    
    
    var contentUrl: URL? {
        return URL(string: contentUrlString)
    }
    
    init?(jsonDictionary: [String : Any]) {
        guard let imageName = jsonDictionary[imageNameKey] as? String,
            let contentUrl = jsonDictionary[contentUrlKey] as? String
            else { return nil }
        
        self.imageName = imageName
        self.contentUrlString = contentUrl
    }
}
