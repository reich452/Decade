//
//  localImageController.swift
//  Decade
//
//  Created by Nick Reichard on 5/3/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation

class LocalImageController {
    
    static let shared = LocalImageController()
    
    var localImages: [LocalImage] = []
    
    init() {
        self.localImages = createAllLocalImages()
    }
    
    func createAllLocalImages() -> [LocalImage] {
        var placeHolderImages: [LocalImage] = []
        for localImageName in LocalImageHelper.localImageNames {
            guard let index = LocalImageHelper.localImageNames.index(of: localImageName) else { print("local images are not available "); return [] }
            let image = LocalImageHelper.localImageArray[index]
            let imageId = LocalImageHelper.ImageId[index]
            let localImages = LocalImage(name: localImageName, localImage: image, imageID: imageId)
            placeHolderImages.append(localImages)
        }
        return placeHolderImages
    }
}




