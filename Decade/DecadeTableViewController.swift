//
//  DecadeTableViewController.swift
//  Decade
//
//  Created by Nick Reichard on 5/1/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class DecadeTableViewController: UITableViewController, isLikedButtonTappedTableViewCellDelegate {

    // MARK: - TODO: add Firebase display 
 
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func isCompleteButtonTapped(sender: DecadeImageTableViewCell) {
        guard let user = sender.user, let indexPath = tableView.indexPath(for: sender) else { return }
        // TODO: Finish the Liked Image button 
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}


