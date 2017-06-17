//
//  CommentTableViewController.swift
//  Decade
//
//  Created by Nick Reichard on 6/14/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class CommentTableViewController: UITableViewController, UITextFieldDelegate, PostUpdatedToDelegate {
    
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var postButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
        PostController.shared.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PostController.shared.fetchPosts { (posts) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
        }
    }
    
    // MARK: PostUpdatedToDelegate
    
    func postsWereUpdatedTo() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: Actions
    
    @IBAction func postButtonTapped(_ sender: Any) {
        
        guard let comment = commentTextField.text, !comment.isEmpty else { commentRequiredAlert(); return }
        PostController.shared.sendPostToCloudKit(post: comment)
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return PostController.shared.posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath)
        let post = PostController.shared.posts[indexPath.row]
        
        // TODO: - match the index's of the image and post
        
        //        let decadeImage = DecadeController.shared.likedDecades[indexPath.row]
        //        let cellImage = decadeImage.decadeImage
        //
        //        cell.imageView?.layer.cornerRadius = 20.0
        //        cell.imageView?.layer.masksToBounds = true
        //        cell.imageView?.image = cellImage
        cell.textLabel?.text = post.post
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let post = PostController.shared.posts[indexPath.row]
            guard let index = PostController.shared.posts.index(of: post) else { return }
            PostController.shared.posts.remove(at: index)
            
            guard let recordID = post.cloudKitRecordID else { return }
            PostController.shared.deletePostWIth(recordID: recordID, completion: { (error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                tableView.reloadData()
            })
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension CommentTableViewController {
    
    // MARK: Keyboard
    
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(CommentTableViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: Alert
    
    func commentRequiredAlert() {
        let alertController = UIAlertController(title: "Ops, didn't enter a comment", message: "Post a comment or go back to saved images", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
