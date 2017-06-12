//
//  Photo.swift
//  Decade
//
//  Created by Nick Reichard on 6/9/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

// TODO: - Add a photo record in cloudKit. Test 

//class Photo {
//    
//    static let recordTypeKey = "Photo"
//    static let photoImageKey = "photoImage"
//    static let captionKey = "caption"
//    static let timestampKey = "timestamp"
//    static let photoReferenceKey = "photoReference"
//    
//    // MARK: Properties
//    
//    var photoImage: UIImage?
//    let caption: String
//    let timestamp: Date
//    var owner: User?
//    var photoReference: CKReference?
//    var cloudKitRecordID: CKRecordID?
//    
//    var recordType: String {
//        return Photo.recordTypeKey
//    }
//    
//    var imageData: Data? {
//        guard let image = photoImage, let imageData = UIImageJPEGRepresentation(image, 1.0) else { return nil }
//        
//        return imageData
//    }
//    
//    /// Must write to temorary directory to be able to pass image file path url to CKAsset
//    fileprivate var temporaryPhotoURL: URL {
//        
//        let temporaryDirectory = NSTemporaryDirectory()
//        let temporaryDirectoryURL = URL(fileURLWithPath: temporaryDirectory)
//        let fileURL = temporaryDirectoryURL.appendingPathComponent(UUID().uuidString).appendingPathComponent("jpg")
//        
//        try? imageData?.write(to: fileURL, options: [.atomic])
//        
//        return fileURL
//    }
//    
//    init(photoImage: UIImage?, caption: String, timestamp: Date, owner: User?, photoReference: CKReference?) {
//        self.photoImage = photoImage
//        self.caption = caption
//        self.timestamp = timestamp
//        self.owner = owner
//        self.photoReference = photoReference
//    }
//    
//    init?(cloudKitRecord: CKRecord) {
//        guard let caption = cloudKitRecord[Photo.captionKey] as? String,
//            let timestamp = cloudKitRecord[Photo.timestampKey] as? Date,
//            let photoReference = cloudKitRecord[Photo.photoReferenceKey] as? CKReference
//            else { return nil }
//        
//        self.caption = caption
//        self.timestamp = timestamp
//        self.photoReference = photoReference
//        self.cloudKitRecordID = cloudKitRecord.recordID
//        
//    }
//    
//}
//
//extension CKRecord {
//    
//    convenience init(photo: Photo) {
//        
//        // check the record id
//        let recordID = photo.cloudKitRecordID ?? CKRecordID(recordName: UUID().uuidString)
//        self.init(recordType: Photo.recordTypeKey, recordID: recordID)
//        
//        // UIImage -> Data -> Store the data at a URL -> Asset with the URL
//        
//        self.setValue(photo.caption, forKey: Photo.captionKey)
//        self.setValue(photo.timestamp, forKey: Photo.photoImageKey)
//        self.setValue(photo.photoReference, forKey: Photo.recordTypeKey)
//        //guard photo.photoImage != nil else { return }
//        let imageAsset = CKAsset(fileURL: photo.temporaryPhotoURL)
//        self.setValue(imageAsset, forKey: Photo.photoImageKey)
//    }
//}


