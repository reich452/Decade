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
    func fetchUserLikedDecades(completion: @escaping () -> Void) {
        // save to cloudKit: Have a predicate
        guard let currentUser = UserController.shared.currentUser, let appleUserRef = currentUser.cloudKitRecordID else { print("There is no current User"); return }
        
        let appleUserReference = CKReference(recordID: appleUserRef, action: .none)
        let predicate = NSPredicate(format: "ownerReference == %@", appleUserReference)
        let query = CKQuery(recordType: "Decade", predicate: predicate)
        
        CloudKitManager.shared.publicDatabase.perform(query, inZoneWith: nil, completionHandler: { (records, error) in
            guard let records = records else { completion(); print("Can't complete records"); return }
            let decades = records.flatMap { Decade(cloudKitRecord: $0) }
            self.likedDecades = decades
            completion()
            
        })
        
    }

    
    /// Saves liked decade to CloudKit.
    func saveLikedDecadeToCloudKit(decade: Decade, completion: @escaping (CKRecordID?) -> Void) {
        guard let cloudKitRecordID = UserController.shared.currentUser?.cloudKitRecordID else { print("Cant find current user"); completion(nil); return }
        
        let reference = CKReference(recordID: cloudKitRecordID, action: .deleteSelf)
        decade.ownerReference = reference
        let record = CKRecord(decade)
        
        cloudKitManager.saveRecord(record) { (record, error) in
            if let error = error {
                print("Error saving new decade to CloudKit: \(error.localizedDescription)")
                completion(nil)
                return
            }
            if let record = record {
                let recordID = record.recordID
                completion(recordID)
            }
            
        }
    }
    
    func deleteLikedDecadeFromCloudKit(decade: Decade, completion: @escaping () -> Void) {
        let record = CKRecord(decade)
        
        cloudKitManager.deleteRecordWithID(record.recordID) { (deletedRecord, error) in
            
            if let error = error {
                print("Cannot deleteRecordWithID \(error.localizedDescription)")
                completion(); return
            }
            completion()
        }
    }
    
}



