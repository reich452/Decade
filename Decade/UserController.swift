//
//  UserController.swift
//  Decade
//
//  Created by Nick Reichard on 5/9/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation
import CloudKit

class UserController {
    
    static let shared = UserController()
    let publicDB = CKContainer.default().publicCloudDatabase
    var appleUserRecordID: CKRecordID?
    var currentUser: User?
    
    init() {
        CKContainer.default().fetchUserRecordID { (recordID, error) in
            guard let recordID = recordID else { return }
            self.appleUserRecordID = recordID
        }
        CloudKitManager.shared.fetchCurrentUser { (currentUser) in
            self.currentUser = currentUser
        }
    }
    
    // MARK: - CRUD
    
    // This will get called when the user taps the hart button
    func sendImagesToCloudKit(for likedImageRefs: CKReference, likedImageURL: [String] = [], likedImage: Bool, appleUserRef: CKReference, completion: @escaping (User?) -> Void) {
        guard let appleUserRecordID = appleUserRecordID else { completion(nil); return }
        
        let appleUserRef = CKReference(recordID: appleUserRecordID, action: .deleteSelf)
        let user = User(likedImageRefs: likedImageRefs, likedImageURL: likedImageURL, likedImage: likedImage, appleUserRef: appleUserRef)
        let userRecord = CKRecord(user: user)
        CKContainer.default().publicCloudDatabase.save(userRecord) { (record, error) in
            if let error = error { print (error.localizedDescription) }
            
            self.currentUser = user
            completion(user)
            
        }
    }
    
    func fetchImagesFromCloudKit(for likeImages: CKReference, likedImageURL: [String] = [], completion: @escaping (User?) -> Void) {
        // DON't need it... 
    }
}


