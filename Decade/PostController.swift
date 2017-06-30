//
//  PostController.swift
//  Decade
//
//  Created by Nick Reichard on 6/16/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class PostController {
    
    static let shared = PostController()
    
    let cloudKitManager = CloudKitManager()
    let publicDB = CKContainer.default().publicCloudDatabase
    var posts: [Post] = []
    weak var delegate: PostUpdatedToDelegate?
    
    func sendPostToCloudKit(post: String) {
        
        let post = Post(post: post)
        let postRecord = post.cloudKitRecord
        
        publicDB.save(postRecord) { (record, error) in
            if let error = error {
                print("\(error.localizedDescription)")
            }
            self.posts.insert(post, at: 0)
            self.delegate?.postsWereUpdatedTo()
        }
    }
    
    func fetchPosts(completion: @escaping ([Post]) -> Void) {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Post", predicate: predicate)
        
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error { print("Can't fetch posts: \(error.localizedDescription)")}
            guard let records = records else { return }
            
            let posts = records.flatMap({Post(cloudKitRecord: $0) })
            // So you don't have to call the array in the ViewController
            self.posts = posts
            completion(posts)
        }
    }
    
    func removePostFromArray(post: Post) {
        guard let index = posts.index(of: post) else { return }
        posts.remove(at: index)
    }
    
    func deletePostWIth(recordID: CKRecordID, completion: @escaping (Error?) -> Void) {
        
        cloudKitManager.deleteRecordWithID(recordID) { (recordID, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            completion(error)
        }
    }
}

protocol PostUpdatedToDelegate: class {
    func postsWereUpdatedTo()
}

