//
//  Comment2.swift
//  Decade
//
//  Created by Nick Reichard on 6/15/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation
import CloudKit

class Post: Equatable {
    
    private let postKey = "post"
    
    // MARK: Properties
    let post: String
    var cloudKitRecordID: CKRecordID?
    
    init(post: String) {
        self.post = post
    }
    
    // Turn post into our model object
    init?(cloudKitRecord: CKRecord) {
        guard let post = cloudKitRecord[postKey] as? String else { return nil }
        self.post = post
    }
    
    // Computed properties. good for simple thing
    /// like a dictoaryRepresentaion. CloudKit verson. Turn this into something that cloudKit can store
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: "Post")
        record.setValue(post, forKey: postKey)
        return record
    }
}

func ==(lsh: Post, rhs: Post) -> Bool {
    return lsh === rhs 
}


