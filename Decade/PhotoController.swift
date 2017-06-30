//
//  PhotoController.swift
//  Decade
//
//  Created by Nick Reichard on 6/27/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class PhotoController {
    
    static let shared = PhotoController()
    
    // MARK: Proprties
    
    let publicDB = CKContainer.default().publicCloudDatabase
   
    var cloudKitManager = CloudKitManager()
    var applePhotoRecordID: CKRecordID?
    var currentPhoto: Photo?
    var photos = [Photo]()
    weak var delegate: PhotoUpdateToDelegate?

    func fetchPhotoRecords(completion: @escaping ([Photo]) -> Void) {
        
        cloudKitManager.fetchRecordsWithType("Photo", recordFetchedBlock: nil) { (records, error) in
            if let error = error {
                print("Cannot fetch records with type \(error.localizedDescription)")
            }
            guard let records = records else { return }
            let photos = records.flatMap {Photo(cloudKitRecord: $0)}
            self.photos = photos
            completion(photos)
        }
    }
    
    func createPhoto(photoImage: Data, caption: String, owner: User?, completion: @escaping (Photo?) -> Void) {
        
        CKContainer.default().fetchUserRecordID { (recordID, error) in
            guard let recordID = recordID, error == nil else {
                print("Error carating recordID \(String(describing: error?.localizedDescription))")
                return }
            self.applePhotoRecordID = recordID
            let photoReference = CKReference(recordID: recordID, action: .deleteSelf)
            
            let photo = Photo(photoImageData: photoImage, caption: caption, timestamp: Date(), owner: owner, photoReference: photoReference)
            
            let photoRecord = CKRecord(photo: photo)
            
            self.cloudKitManager.saveRecord(photoRecord, completion: { (record, error) in
                if let error = error {
                    print( "Cannot save record \(error.localizedDescription)")
                }
                completion(photo)
                print("Created a photo")
                self.photos.insert(photo, at: 0)
                self.delegate?.photosWereUpdatedTo()
            })
            
        }
    }
}

protocol PhotoUpdateToDelegate: class {
    func photosWereUpdatedTo() 
}
