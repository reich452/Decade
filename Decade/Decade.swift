//
//  ImageSearch.swift
//  Decade
//
//  Created by Nick Reichard on 5/1/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation
import UIKit

class Decade {
    
    private let imageNameKey = "name"
    private let contentUrlKey = "contentUrl"
    private let hostPageDislayUrlKey = "hostPageDisplayUrl"  // TODO: Open in a web view. 
    private let imageIdKey = "imageId"
    
   // var resultImages: [UIImage]
    let imageName: String
    let contentUrlString: String
    var decadeImage: UIImage?
    var imageIds: String
    
    init?(jsonDictionary: [String : Any]) {
        guard let imageName = jsonDictionary[imageNameKey] as? String,
            let contentUrl = jsonDictionary[contentUrlKey] as? String,
            let imageIds = jsonDictionary[imageIdKey] as? String
            else { return nil }
        
        self.imageName = imageName
        self.contentUrlString = contentUrl
        self.imageIds = imageIds
    }
}
