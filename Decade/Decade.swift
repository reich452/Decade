//
//  ImageSearch.swift
//  Decade
//
//  Created by Nick Reichard on 5/1/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class Decade {
    
    static let imageNameKey = "name"
    static let contentUrlKey = "contentUrl"
    static let imageIdKey = "imageId"
    static let imageDataKey = "imageData"
    static let ownerReferenceKey = "ownerReference"
    static let typeKey = "Decade"
    static let hostPageUrlKey = "hostPageUrl"
    
    let imageName: String
    let contentUrlString: String
    var hostPageUrl: String?
    var decadeImage: UIImage?
    var imageId: String
    var owner: User?
    var ownerReference: CKReference?
    var cloudKitRecordID: CKRecordID?
    
    var recordType: String {
        return Decade.typeKey
    }
    
    var cloudKitReference: CKReference? {
        guard let cloudKitRecordID = self.cloudKitRecordID else { return nil }
        return CKReference(recordID: cloudKitRecordID, action: .none)
    }
   
    // MARK: - BING API
    
    init?(jsonDictionary: [String : Any]) {
        guard let imageName = jsonDictionary[Decade.imageNameKey] as? String,
            let contentUrl = jsonDictionary[Decade.contentUrlKey] as? String,
            let hostPageUrl = jsonDictionary[Decade.hostPageUrlKey] as? String,
            let imageId = jsonDictionary[Decade.imageIdKey] as? String
            else { return nil }
        
        self.imageName = imageName
        self.contentUrlString = contentUrl
        self.hostPageUrl = hostPageUrl
        self.imageId = imageId
    }
    
    init(imageName: String, contentUrlString: String, hostPageUrl: String?, decadeImage: UIImage?, imageId: String, owner: User, ownerReference: CKReference) {
        self.imageName = imageName
        self.contentUrlString = contentUrlString
        self.hostPageUrl = hostPageUrl
        self.decadeImage = decadeImage
        self.imageId = imageId
        self.owner = owner
        self.ownerReference = ownerReference
    }
    
    // MARK: - CloudKit
    
    init?(cloudKitRecord: CKRecord) {
        guard let imageName = cloudKitRecord[Decade.imageNameKey] as? String,
            let contentUrlString = cloudKitRecord[Decade.contentUrlKey] as? String,
            let hostPageUrl = cloudKitRecord[Decade.hostPageUrlKey] as? String,
            let imageId = cloudKitRecord[Decade.imageIdKey] as? String,
            let ownerReference = cloudKitRecord[Decade.ownerReferenceKey] as? CKReference else { return nil }
        
        self.imageName = imageName
        self.contentUrlString = contentUrlString
        self.hostPageUrl = hostPageUrl
        self.imageId = imageId
        self.ownerReference = ownerReference
        self.cloudKitRecordID = cloudKitRecord.recordID
        
    }
}

extension CKRecord {
    convenience init(_ decade: Decade) {
        let recordID = decade.cloudKitRecordID ?? CKRecordID(recordName: UUID().uuidString)
        self.init(recordType: decade.recordType, recordID: recordID)
        setValue(decade.imageName, forKey: Decade.imageNameKey)
        setValue(decade.contentUrlString, forKey: Decade.contentUrlKey)
        setValue(decade.hostPageUrl, forKey: Decade.hostPageUrlKey)
        setValue(decade.imageId, forKey: Decade.imageIdKey)
        guard let owner = decade.owner,
            let ownerRecordID = owner.cloudKitRecordID else { return }
        self[Decade.ownerReferenceKey] = CKReference(recordID: ownerRecordID, action: .deleteSelf)
    }
}
