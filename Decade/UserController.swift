//
//  UserController.swift
//  Decade
//
//  Created by Nick Reichard on 5/9/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit
import CloudKit
import NotificationCenter

class UserController {
    
    static let shared = UserController()
    let publicDB = CKContainer.default().publicCloudDatabase
    let cloudKitManager = CloudKitManager()
    // Notifications are like a radio tower signal. You are tuned into a chanel and you hear the anouncement
    // let DidRefreshNotification = Notification.Name("DidRefreshNotification")
    var appleUserRecordID: CKRecordID?
    var currentUser: User?
 
    private(set) var users = [User]() {
        didSet {
            //            DispatchQueue.main.async { TODO: add if delegate does not work 
            //                let notificationCenter = NotificationCenter.default
            //                notificationCenter.post(name: self.DidRefreshNotification, object: self)
            //            }
        }
    }
    

    
    func fetchLoggedInUser(completion: @escaping () -> Void) {
        
        CloudKitManager.shared.fetchCurrentUser { (currentUser, appleUserRef) in
            
            if currentUser != nil {
                self.currentUser = currentUser
                completion()
            } else {
                guard let appleUserRef = appleUserRef else { completion(); return }
                let user = User(appleUserRef: appleUserRef)
                let record = CKRecord(user: user)
                CloudKitManager.shared.saveRecord(record, completion: { (record, error) in
                    if let error = error {
                        print("Can't create user record \(error.localizedDescription)")
                        completion()
                        return
                    }
                    user.cloudKitRecordID = record?.recordID
                    self.currentUser = user
                    completion()
                })
            }
        }
    }
    
    // MARK: - CRUD
    
    // This will get called when the user taps the hart button
    func sendImagesToCloudKit(for likedImageURLs: [String] = [], imageIds: [String] = [], appleUserRef: CKReference, completion: @escaping (User?) -> Void) {
        guard let appleUserRecordID = appleUserRecordID else { completion(nil); return }
        
        let appleUserRef = CKReference(recordID: appleUserRecordID, action: .deleteSelf)
        let user = User(likedImageURLs: likedImageURLs, imageIds: imageIds, appleUserRef: appleUserRef)
        let userRecord = CKRecord(user: user)
        CKContainer.default().publicCloudDatabase.save(userRecord) { (record, error) in
            if let error = error { print (error.localizedDescription) }
            
            self.currentUser = user
            completion(user)
        }
    }
    
    func updateUserInCloudKit(completion: @escaping () -> Void) {
        guard let currentUser = currentUser else { completion(); print("Cannot update currten user to CK");return }
        
        let record = CKRecord(user: currentUser)
        var records: [CKRecord] = []
        records.append(record)
        
        CloudKitManager.shared.modifyRecords(records, perRecordCompletion: nil) { (records, error) in
            if let error = error {
                print("Cannot modify user record \(error.localizedDescription)")
                completion(); return
            }
            completion()
        }
    }
    
    func fetchLikedImages(completion: @escaping ([UIImage]) -> Void) {
        guard let imageUrls = self.currentUser?.likedImageURLs else { return }
        
        let group = DispatchGroup()
        for likedImageUrl in imageUrls {
            group.enter()
            ImageController.image(forURL: likedImageUrl) { (likedImage) in
                
            }
        }
    }
}


