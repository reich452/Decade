//
//  SavedDecadeTableViewController.swift
//  Decade
//
//  Created by Nick Reichard on 5/2/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit


class SavedDecadeTableViewController: UITableViewController {
    
    var decades: [Decade] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =  "Saved Images"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DecadeController.shared.fetchUserLikedDecades {
            DecadeController.shared.fetchUserLikedImages {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    

    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DecadeController.shared.likedDecades.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "savedImagesCell", for: indexPath) as? SavedDecadeTableViewCell else { return SavedDecadeTableViewCell() }
        
        let decade = DecadeController.shared.likedDecades[indexPath.row]
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


