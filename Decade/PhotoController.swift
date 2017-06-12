//
//  PhotoController.swift
//  Decade
//
//  Created by Nick Reichard on 6/10/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit
import CloudKit

// TODO: - add PhotoController to let users post photos on their own feed 

//class PhotoController {
//    
//    static let shared = PhotoController()
//    
//    // MARK: Proprties 
//    
//    let publicDB = CKContainer.default().publicCloudDatabase
//    var cloudKitManager = CloudKitManager()
//    var photos: [Photo] = []
//    var applePhotoRecordID: CKRecordID?
//    var currentPhoto: Photo?
//    
//    func createPhotoWith(photoImage: UIImage, caption: String, owner: User?, photoReference: CKReference? = nil) {
//        
//        let photo = Photo(photoImage: photoImage, caption: caption, timestamp: Date(), owner: owner, photoReference: photoReference)
//        
//        let photoRecord = CKRecord(photo: photo)
//        
//        publicDB.save(photoRecord) { (reocord, error) in
//            if let error = error {
//                print("Error saving photo record \(error.localizedDescription)")
//            }
//        }
//    }
//    
//    func createPhoto(with photoImage: UIImage?, caption: String, owner: User?, completion: @escaping (Photo?) -> Void) {
//        
//        CKContainer.default().fetchUserRecordID { (recordID, error) in
//            guard let recordID = recordID, error == nil else {
//                print("Error carating recordID \(String(describing: error?.localizedDescription))")
//                return }
//            self.applePhotoRecordID = recordID
//            let photoReference = CKReference(recordID: recordID, action: .deleteSelf)
//            
//            let photo = Photo(photoImage: photoImage, caption: caption, timestamp: Date(), owner: owner, photoReference: photoReference)
//            
//            let photoRecord = CKRecord(photo: photo)
//            
//            self.publicDB.save(photoRecord, completionHandler: { (record, error) in
//                if let reocord = record, error == nil {
//                    let currentPhoto = Photo(cloudKitRecord: reocord)
//                    self.currentPhoto = currentPhoto
//                    completion(photo)
//                    
//                    print("Success creating photo")
//                } else {
//                    guard let error = error else { print("Can't Unwrap error"); return }
//                    print("Error saving photo record:\(error.localizedDescription)")
//                }
//                
//            })
//            
//        }
//    }
//    
//    func savePhotoToCloudKit(photo: Photo, completion: @escaping (CKRecordID?) -> Void) {
//        guard let cloudKitRecordID = UserController.shared.currentUser?.cloudKitRecordID else { print("Cannot find current user"); completion(nil); return }
//        
//        let reference = CKReference(recordID: cloudKitRecordID, action: .deleteSelf)
//        photo.photoReference = reference
//        let record = CKRecord(photo: photo)
//        
//        cloudKitManager.saveRecord(record) { (record, error) in
//            if let error = error {
//                print("Error saving to cloudKit: \(error.localizedDescription)")
//                completion(nil)
//                return
//            }
//        }
//    }
//}
