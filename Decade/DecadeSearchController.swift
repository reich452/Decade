//
//  ImageSearchController.swift
//  Decade
//
//  Created by Nick Reichard on 5/1/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation
import UIKit

class DecadeSearchController {
    
    static let shared = DecadeSearchController()
    
    private let searchTermKey = "q"
    private let countKey = "count"
    private let valueKey = "value"
    private let contentURLKey = "contentUrl"
    private let apiParameter = "Ocp-Apim-Subscription-Key"
    private let baseURL = URL(string: "https://api.cognitive.microsoft.com/bing/v5.0/images/search")
    private let apiKey = "0231de06566d4717873444afb447e586"
    
    func searchForImagesWith(searchTerm: String, completion: @escaping ([Decade]?, DecadeError?) -> Void) {
        guard let baseURL = baseURL else { completion([], .baseUrlFailed); return }
        let urlParameters = ["q": searchTerm]
        
        NetworkController.performRequest(for: baseURL, apiKey: apiKey, httpMethod: .get, urlParameters: urlParameters, body: nil) { (data, error) in
            if let error = error { print("Error: searching for image \(error.localizedDescription)")
                completion([], .imageSearchFailure); return }
            
            guard let data = data,
                let jsonDictionaries = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any],
                let imageArray = jsonDictionaries["value"] as? [[String: Any]] else { completion([], .jsonConversionFailure); return }
            
            let decades = imageArray.flatMap( {Decade(jsonDictionary: $0)})
            
            let group = DispatchGroup()
            
            for decade in decades {
                group.enter()
                ImageController.image(forURL: decade.contentUrlString, completion: { (newImage) in
                    decade.decadeImage = newImage
                    group.leave()
                })
            }
            
            group.notify(queue: DispatchQueue.main, execute: { 
                
                completion(decades, nil)
            })
        }
    }
}
