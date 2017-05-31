//
//  ImageSearchController.swift
//  Decade
//
//  Created by Nick Reichard on 5/1/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class DecadeSearchController {
    
    static let shared = DecadeSearchController()

    weak var delegate: DecadesWereAddedToDelegate?
    
    private let searchTermKey = "q"
    private let countKey = "count"
    private let valueKey = "value"
    private let contentURLKey = "contentUrl"
    private let apiParameter = "Ocp-Apim-Subscription-Key"
    private let baseURL = URL(string: "https://api.cognitive.microsoft.com/bing/v5.0/images/search")
    private let baseURL2 = URL(string: "https://api.cognitive.microsoft.com/bing/v7.0/images/search")
    private let apiKey = "0231de06566d4717873444afb447e586"
    private let apiKey2 = "c3f846e0028943f5afd96e9cdd6eae73"
    
    // MARK: - Properties 
    
    var decades = [Decade]()
    
    func searchForImagesWith(searchTerm: String, recordFetchedBlock: @escaping (Decade?) -> Void, completion: @escaping (DecadeError?) -> Void) {
        guard let baseURL = baseURL,
        let currentUserRecordId = UserController.shared.currentUser?.cloudKitRecordID
            else { completion(.baseUrlFailed); print("Base url failed"); return }
        
        let urlParameters = ["q": searchTerm]
        NetworkController.performRequest(for: baseURL, apiKey: apiKey, httpMethod: .get, urlParameters: urlParameters, body: nil) { (data, error) in
            if let error = error { print("Error: searching for image \(error.localizedDescription)")
                completion(.imageSearchFailure); return }
            
            guard let data = data,
                let jsonDictionaries = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any],
                let imageArray = jsonDictionaries["value"] as? [[String: Any]] else { completion(.jsonConversionFailure); print("Json Conversion failure"); return }
            
            let decades = imageArray.flatMap( {Decade(jsonDictionary: $0)})
            let group = DispatchGroup()
    
            for decade in decades {
                group.enter()
                ImageController.image(forURL: decade.contentUrlString, completion: { (newImage) in
                    decade.decadeImage = newImage
                    decade.ownerReference = CKReference(recordID: currentUserRecordId, action: .none)
                    recordFetchedBlock(decade)
                    group.leave()
                })
            }
            
            group.notify(queue: DispatchQueue.main, execute: {
                
                completion(nil)
            })
        }
    }

    func getRandomSearchTermFrom(searchTerms: [String]) -> String {
        let randomIndex = Int(arc4random_uniform(UInt32(searchTerms.count - 1)))
        
        return searchTerms[randomIndex]
    }
    
    func searchTermsFor(decade: Decades) -> [String] {
        switch decade {
        case .currentYear:
            return ["hipsters 2017", "hipster fashion", "hipster trends", "hipster girls", "2017 fashion"]
        case .twothousands:
            return ["early 2000s", "early 2000s mtv"]
        case .ninties:
            return ["90s", "1990s style", "1990s style funny"]
        case .eightys:
            return ["80s fashion"]
        case .seventies:
            return ["70s style", "1970s hippie fashion"]
        case .sixties:
            return ["1960s people black and white photos"]
        case .fifties:
            return ["1950s photos", "1950s famous people black and white photos"]
        case .fourteys:
            return ["1940s photos black and white", "1940s big events"]
        case .none:
            return []
        }
    }
    
    func searchForImagesWithKeywords(keywords: [String], completion: @escaping (DecadeError?) -> Void) {
        guard let baseURL = baseURL,
            let currentUserRecordId = UserController.shared.currentUser?.cloudKitRecordID
            else { completion(.baseUrlFailed); print("base url failed"); return }

        let urlParameters: [String: String] = ["q": getRandomSearchTermFrom(searchTerms: keywords)]
        NetworkController.performRequest(for: baseURL, apiKey: apiKey, httpMethod: .get, urlParameters: urlParameters, body: nil) { (data, error) in
            if let error = error { print("Error: searching for image \(error.localizedDescription)")
                completion(.imageSearchFailure); print("imageSearch failure"); return }
            
            guard let data = data,
                let jsonDictionaries = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any],
                let imageArray = jsonDictionaries["value"] as? [[String: Any]] else { completion(.jsonConversionFailure); print("jsonConversionFailure"); return }
            
            let decades = imageArray.flatMap( {Decade(jsonDictionary: $0)})
            
            let group = DispatchGroup()
            
            for decade in decades {
                group.enter()
                decade.ownerReference = CKReference(recordID: currentUserRecordId, action: .none)
                ImageController.image(forURL: decade.contentUrlString, completion: { (newImage) in
                    decade.decadeImage = newImage
                    self.decades.append(decade)
                    self.delegate?.decadesWereAddedTo()
                    group.leave()
                })
            }
            
            group.notify(queue: DispatchQueue.main, execute: {
                
                completion(nil)
            })
        }
    }
}

protocol DecadesWereAddedToDelegate: class {
    func decadesWereAddedTo()
}

enum Decades {
    case currentYear
    case twothousands
    case ninties
    case eightys
    case seventies
    case sixties
    case fifties
    case fourteys
    case none
}
