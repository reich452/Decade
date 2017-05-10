//
//  SavedDecadeTableViewController.swift
//  Decade
//
//  Created by Nick Reichard on 5/2/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit
import NotificationCenter

class SavedDecadeTableViewController: UITableViewController {
    
    var decades: [Decade] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func notificationUpdate() {
//        let notificationCenter = NotificationCenter.default
//        notificationCenter.addObserver(self, selector: #selector(refreshSavedItems), name: <#T##NSNotification.Name?#>, object: <#T##Any?#>)
    }
    
    func refreshSavedItems() {
        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return decades.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "decadeSavedCell", for: indexPath) as? SavedDecadeTableViewCell else { return UITableViewCell() }
        
        let decade = decades[indexPath.row]
        cell.decade = decade
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}


