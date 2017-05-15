//
//  DecadeController.swift
//  Decade
//
//  Created by Nick Reichard on 5/11/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation
import CloudKit

class DecadeController {
    
    static let shared = DecadeController()
    var cloudKitManager = CloudKitManager()
    var likedDecades: [Decade] = []
    
    // Closures are by default non-escaping in Swift 3, escaping closures need to be marked as such
    // when you want to input a closure as the parameter and the closure escapes out of the function block.
    //If a closure is passed as an argument to a function and it is invoked after the function returns, the closure is escaping.The closure argument escapes the function body.
    func fetchUserLikedDecades(completion: @escaping ([Decade]) -> Void) {
        // save to cloudKit: Have a predicate
        CKContainer.default().fetchUserRecordID { (appleUserRecordID, error) in
            if let error = error { print("error fetching appleUserRecordID \(error.localizedDescription)")}
            guard let appleUserRecordID = appleUserRecordID else { completion([]); print("appleUserRecordID completion failure"); return }
            
            let appleUserReference = CKReference(recordID: appleUserRecordID, action: .none)
            let predicate = NSPredicate(format: "creatorUserRecordID == %@", appleUserReference)
            let query = CKQuery(recordType: "Decade", predicate: predicate)
            
            CloudKitManager.shared.publicDatabase.perform(query, inZoneWith: nil, completionHandler: { (records, error) in
                guard let records = records else { completion([]); print("Can't complete records"); return }
                let decades = records.flatMap { Decade(cloudKitRecord: $0) }
                self.likedDecades = decades
                completion(decades)
                
            })
        }
    }
    
    /// Saves liked decade to CloudKit.
    func saveLikedDecadeToCloudKit(decade: Decade, completion: @escaping () -> Void) {
        let record = CKRecord(decade)
        
        cloudKitManager.saveRecord(record) { (record, error) in
            if let error = error {
                print("Error saving new decade to CloudKit: \(error.localizedDescription)")
            }
            completion()
        }
    }
    
    // TODO: - test this
    func fetchUserLikedDecades2(completion: @escaping ([Decade]) -> Void) {
        let predicate = NSPredicate(format: "contentUrl == %@", argumentArray: likedDecades)
        let query = CKQuery(recordType: "Decade", predicate: predicate)
        
        CloudKitManager.shared.publicDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let records = records else { print("NO record2"); return }
                let decades = records.flatMap { Decade(cloudKitRecord: $0)}
                self.likedDecades = decades
                completion(decades)
            }
        }
    }
    
}



