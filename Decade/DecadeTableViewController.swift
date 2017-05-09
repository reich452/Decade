//
//  DecadeTableViewController.swift
//  Decade
//
//  Created by Nick Reichard on 5/1/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class DecadeTableViewController: UITableViewController, isLikedButtonTappedTableViewCellDelegate {
  
    var decades: [Decade] = []
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .customBackgroundColor

    }
    
    // MARK: - Protocol 
    
    func isHeartButtonTapped(sender: DecadeImageTableViewCell) {
//        guard let user = sender.user, let indexPath = tableView.indexPath(for: sender) else { return }
        // TODO: Finish the Liked Image button
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.decades.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "decadeImageCell", for: indexPath) as? DecadeImageTableViewCell else { return UITableViewCell() }
        
        let decade = decades[indexPath.row]
        cell.decade = decade 
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}


