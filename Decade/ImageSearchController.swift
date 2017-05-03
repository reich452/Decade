//
//  ImageSearchController.swift
//  Decade
//
//  Created by Nick Reichard on 5/3/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation
import UIKit

class ImageSearchController {
    
    static let shared = ImageSearchController()
    
    private let searchTermKey = "q"
    private let countKey = "count"
    private let valueKey = "value"
    private let contentURLKey = "contentUrl"
    private let apiKey = "Ocp-Apim-Subscription-Key"
    
    func searchForImagesWith(searchTerm: String, completion: @escaping (ImageSearch?) -> Void) {
        
        guard let baseURL = URL(string: "https://api.cognitive.microsoft.com/bing/v5.0/images/search") else { completion(nil); return }
        
        let searchTermItem = URLQueryItem(name: searchTermKey, value: searchTerm)
        let countItem = URLQueryItem(name: countKey, value: "25")
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        components?.queryItems = [searchTermItem, countItem]
        
        // The real formatted URL
        guard let searchURL = components?.url else { return }
        
        var request = URLRequest(url: searchURL)
        request.addValue("0231de06566d4717873444afb447e586", forHTTPHeaderField: apiKey)
        
        
        // For getting we just use the url
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error searching for image \(error.localizedDescription)")
                completion(nil)
            }
            
            guard let data = data else { print("Error: No data returned from data task"); completion(nil); return }
            
            // utf8 is the way the data is formated
            guard let response = String(data: data, encoding: .utf8) else {
                print("Error: No data returned from data task");
                completion(nil); return }
            
            if response.contains("error") {
                print(response)
                completion(nil)
                return
            }
            print(response)
            
            // Turn our bag of bits into something that it can display
            // AllowFragments = if there are signular toplevel values use them
            guard let searchDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String : Any],
                let valueArray = searchDictionary[self.valueKey] as? [[String: Any]] else { completion(nil); return }
            
            var imageURLs: [String] = []
            
            for imageDictionary in valueArray {
                
                guard let contentURL = imageDictionary[self.contentURLKey] as? String else { return }
                imageURLs.append(contentURL)
            }
            
            
            // The tunnel (keeps track of how many processes are running inside of it)
            let group = DispatchGroup()
            
            
            var images: [UIImage] = []
            
            for imageURL in imageURLs {
                // The count of things inside the group is incremented by one each time you call group.enter()
                group.enter()
                self.imageFor(urlString: imageURL, completion: { (image) in
                    guard let image = image else { return }
                    
                    // The count of things inside the group is incremented by one each time you call group.leave()
                    images.append(image)
                    group.leave()
                    
                })
            }
            
            group.notify(queue: DispatchQueue.main, execute: {
                // The code in this clousre will only be run once the group's count goes back town to zero
                var imageSearch = ImageSearch(searchTerm: searchTerm)
                imageSearch.resultImages = images
                
                // We only call the completion when we know that we have all the images.
                completion(imageSearch)
            })
            
            }.resume()
    }
    
    
    func imageFor(urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = URL(string: urlString) else { completion(nil); return }
        
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            if let error = error {
                NSLog("Error searching for image \(error.localizedDescription)")
                completion(nil)
            }
            
            guard let data = data else { print("Error: No data returned from data task"); completion(nil); return }
            
            // utf8 is the way the data is formated
            
            // Display the image instead of searlize it
            
            guard let image = UIImage(data: data) else { print("Unable to initialize a UUImage from data"); completion(nil); return }
            
            completion(image)
            
            } .resume()
    }
    
}

