//
//  User.swift
//  Decade
//
//  Created by Nick Reichard on 5/1/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation
import CloudKit

class User {
    
    static let recordTypeKey = "User"
    static let likedImageRefKey = "likedImageRef"
    static let likedImageUrlKey = "likedImageURL"
    static let likedImageKey = "likedImage"
    static let appleUserRefKey = "appleUserRef"
    
    var likedImageRefs: CKReference
    var likedImageURL: [String] = []
    var likedImage: Bool
    var cloudKitRecordID: CKRecordID?
    
    // This is the reference to the default Apple User records ID
    let appleUserRef: CKReference
    
    // To create an instance of a user likeing an image
    init(likedImageRefs: CKReference, likedImageURL: [String] = [], likedImage: Bool, appleUserRef: CKReference) {
        
        self.likedImageRefs = likedImageRefs
        self.likedImageURL = likedImageURL
        self.likedImage = likedImage
        self.appleUserRef = appleUserRef
    }
    
    // FetchLogedInUserRecord 
    init?(cloudKitRecord: CKRecord) {
        guard let likedImageRefs = cloudKitRecord[User.likedImageRefKey] as? CKReference,
            let likedImage = cloudKitRecord[User.likedImageKey] as? Bool,
            let appleUserRef = cloudKitRecord[User.appleUserRefKey] as? CKReference else { return nil }
        
        self.likedImageRefs = likedImageRefs
        self.likedImageURL = cloudKitRecord[User.likedImageUrlKey] as? [String] ?? []
        self.likedImage = likedImage
        self.appleUserRef = appleUserRef
        self.cloudKitRecordID = cloudKitRecord.recordID
    }
}

extension CKRecord {
    
    convenience init(user: User) {
        let recordID = user.cloudKitRecordID ?? CKRecordID(recordName: UUID().uuidString)
        
        self.init(recordType: User.recordTypeKey, recordID: recordID)
        self.setValue(user.likedImageURL, forKey: User.likedImageUrlKey)
        self.setValue(user.likedImageRefs, forKey: User.likedImageRefKey)
        self.setValue(user.appleUserRef, forKey: User.appleUserRefKey)
    }
}
