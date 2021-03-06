//
//  CloudKitManager.swift
//  Decade
//
//  Created by Nick Reichard on 5/9/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitManager {
    
    static let shared = CloudKitManager()
    private let recordTypeKey = "User"
    
    let publicDatabase = CKContainer.default().publicCloudDatabase
    
    func saveRecord(_ record: CKRecord, completion: ((_ record: CKRecord?, _ error: Error?) -> Void)?) {
        
        publicDatabase.save(record, completionHandler: { (record, error) in
            
            completion?(record, error)
        })
    }
    
    func modifyRecords(_ records: [CKRecord], perRecordCompletion: ((_ record: CKRecord?, _ error: Error?) -> Void)?, completion: ((_ records: [CKRecord]?, _ error: Error?) -> Void)?) {
        
        let operation = CKModifyRecordsOperation(recordsToSave: records, recordIDsToDelete: nil)
        operation.savePolicy = .changedKeys
        operation.queuePriority = .high
        operation.qualityOfService = .userInteractive
        
        operation.perRecordCompletionBlock = perRecordCompletion
        
        operation.modifyRecordsCompletionBlock = { (records, recordIDs, error) -> Void in
            if let error = error { print(error.localizedDescription) }
            (completion?(records, error))!
        }
        
        publicDatabase.add(operation)
    }
    
    func fetchCurrentUser(completion: @escaping (User?, CKReference?) -> Void) {
        // Fetch default Apple 'Users' recordID
        
        CKContainer.default().fetchUserRecordID { (appleUserRecordID, error) in
            
            if let error = error { print(error.localizedDescription) }
            
            guard let appleUserRecordID = appleUserRecordID else { return }
            
            // Initialize a CKReference with that recordID so that we can fetch OUR real User record
            let appleUserReference = CKReference(recordID: appleUserRecordID, action: .deleteSelf)
            
            // Create a predicate with that reference that will go through all of the Users and FILTER through them and return us the one that has the matching reference.
            let predicate = NSPredicate(format: "appleUserRef == %@", appleUserReference)
            
            // Fetch the real User record
            self.fetchRecordsWithType(self.recordTypeKey, predicate: predicate, recordFetchedBlock: nil, completion: { (records, error) in
                if let error = error {
                    print("Error fetchingRecordsWithType \(#file) \(#function) \(error.localizedDescription)")
                }
                guard let currentUserRecord = records?.first else {  completion(nil, appleUserReference); return }
                
                let currentUser = User(cloudKitRecord: currentUserRecord)
                
                completion(currentUser, nil)
            })
        }
    }
    
    func fetchRecord(withID recordID: CKRecordID, completion: ((_ record: CKRecord?, _ error: Error?) -> Void)?) {
        
        publicDatabase.fetch(withRecordID: recordID) { (record, error) in
            
            completion?(record, error)
        }
    }
    
    func fetchRecordsWithType(_ type: String,
                              predicate: NSPredicate = NSPredicate(value: true),
                              recordFetchedBlock: ((_ record: CKRecord) -> Void)?, completion: ((_ records: [CKRecord]?, _ error: Error?) -> Void)?) {
        
        var fetchedRecords: [CKRecord] = []
        
        // create a query inorder to search what you want
        let query = CKQuery(recordType: type, predicate: predicate) // Yes give me it all
        let queryOperation = CKQueryOperation(query: query) // Go and exequte the search critera
        
        let perRecordBlock = { (fetchRecord: CKRecord) -> Void in
            fetchedRecords.append(fetchRecord) // appending the record that we are getting back
            recordFetchedBlock?(fetchRecord)
        }
        queryOperation.recordFetchedBlock = perRecordBlock
        
        var queryCompletionBlock: ((CKQueryCursor?, Error?) -> Void)?
        
        queryCompletionBlock = { [weak self] (queryCursor: CKQueryCursor?, error: Error?) -> Void in
            
            if let queryCursor = queryCursor {
                // if There are more results, go and fetch them
                
                let continuedQueryOperation = CKQueryOperation(cursor: queryCursor)
                continuedQueryOperation.recordFetchedBlock = perRecordBlock
                continuedQueryOperation.queryCompletionBlock = queryCompletionBlock
                
                self?.publicDatabase.add(continuedQueryOperation)
            } else {
                completion?(fetchedRecords, error)
            }
        }
        
        queryOperation.queryCompletionBlock = queryCompletionBlock
        
        self.publicDatabase.add(queryOperation)
        
    }
    // MARK: - Delete
    
    func deleteRecordWithID(_ recordID: CKRecordID, completion: ((_ recordID: CKRecordID?, _ error: Error?) -> Void)?) {
        
        publicDatabase.delete(withRecordID: recordID) { (recordID, error) in
            completion?(recordID, error)
        }
    } // The record with the specified will be DESTROYED
}
