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
    static let likedImageUrlsKey = "likedImageURLs"
    static let likedImageKey = "likedImage"
    static let imageIdKey = "imageId"
    static let commentsKey = "comment"
    static let appleUserRefKey = "appleUserRef"
    
    var likedImageURLs: [String] = []
    var imageIds: [String] = []
    var cloudKitRecordID: CKRecordID?
    
    // This is the reference to the default Apple User records ID
    let appleUserRef: CKReference
    
    // To create an instance of a user liking an image
    init(likedImageURLs: [String] = [], imageIds: [String] = [], appleUserRef: CKReference) {
        
        self.likedImageURLs = likedImageURLs
        self.imageIds = imageIds
        self.appleUserRef = appleUserRef
    }
    
    // FetchLogedInUserRecord
    init?(cloudKitRecord: CKRecord) {
        guard let appleUserRef = cloudKitRecord[User.appleUserRefKey] as? CKReference else { return nil }
        
        self.likedImageURLs = cloudKitRecord[User.likedImageUrlsKey] as? [String] ?? []
        self.imageIds = cloudKitRecord[User.imageIdKey] as? [String] ?? []
        self.appleUserRef = appleUserRef
        self.cloudKitRecordID = cloudKitRecord.recordID
    }
}

extension CKRecord {
    
    convenience init(user: User) {
        let recordID = user.cloudKitRecordID ?? CKRecordID(recordName: UUID().uuidString)
        
        self.init(recordType: User.recordTypeKey, recordID: recordID)
        self.setValue(user.likedImageURLs, forKey: User.likedImageUrlsKey)
        self.setValue(user.imageIds, forKey: User.imageIdKey)
        self.setValue(user.appleUserRef, forKey: User.appleUserRefKey)
    }
}
