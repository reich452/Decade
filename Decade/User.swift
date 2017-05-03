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
    
    static let likedImageKey = "likedImage"
    static let recordTypeKey = "User"
    static let likedImageRefKey = "likedImageRef"
    static let appleUserRefKey = "appleUserRef"
    
    let appleUserRef: CKReference
    var likedImage: Bool
    var likedImageRefs: [CKReference]? = []
    var cloudKitRecordID: CKRecordID?
    
    // To create an instance of a user likeing an image
    init(likedImage: Bool, likedImageRefs: [CKReference]? = [], appleUserRef: CKReference) {
        self.likedImage = likedImage
        self.likedImageRefs = likedImageRefs
        self.appleUserRef = appleUserRef
    }
    
    // FetchLogedInUserRecord 
    init?(cloudKitRecord: CKRecord) {
        guard let likedImage = cloudKitRecord[User.likedImageKey] as? Bool,
        let appleUserRef = cloudKitRecord[User.appleUserRefKey] as? CKReference
            else { return nil}
        
        self.likedImageRefs = cloudKitRecord[User.likedImageKey] as? [CKReference] ?? []
        self.likedImage = likedImage
        self.appleUserRef = appleUserRef
        self.cloudKitRecordID = cloudKitRecord.recordID
    }
}

extension CKRecord {
    
    convenience init(user: User) {
        let recordID = user.cloudKitRecordID ?? CKRecordID(recordName: UUID().uuidString)
        
        self.init(recordType: User.recordTypeKey, recordID: recordID)
        self.setValue(user.appleUserRef, forKey: User.appleUserRefKey)
        self.setValue(user.likedImage, forKey: User.likedImageRefKey)
    }
}
