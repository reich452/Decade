//
//  imageController .swift
//  Decade
//
//  Created by Nick Reichard on 5/1/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation
import UIKit

class ImageController {
    
    static let baseUrlString = "https://api.cognitive.microsoft.com/bing/v5.0/images/search"
    private let apiValue = "Ocp-Apim-Subscription-Key"
    
    static func image(forURL url: String, completion: @escaping (UIImage?) -> Void) {
        
        guard let url = URL(string: url) else {
            fatalError("Image URL optional is nil")
        }
        
        NetworkController.performRequestWithoutParameters(for: url, httpMethod: .get) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data,
                let image = UIImage(data: data) else {
                    
                    DispatchQueue.main.async { completion(nil) }
                    return
            }
            DispatchQueue.main.async { completion(image) }
            
        }
    }
}
