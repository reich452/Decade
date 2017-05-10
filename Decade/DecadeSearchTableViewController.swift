//
//  DecadeSearchTableViewController.swift
//  Decade
//
//  Created by Nick Reichard on 5/1/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class DecadeSearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var imageSearchBar: UISearchBar!
    
    
    // MARK: - Properties 
    var decades: [Decade] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imageSearchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text else { return }
        
        DecadeSearchController.shared.searchForImagesWith(searchTerm: searchTerm) { (newDecades, decadeError) in
            guard let decades = newDecades else { return }
            DispatchQueue.main.async {
                self.decades = decades
            }
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decades.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "decadeSearchCell", for: indexPath) as? DecadeSearchTableViewCell else { print("Can't return DecadeSearchTableViewCell"); return UITableViewCell() }
        
        let decade = decades[indexPath.row]
        cell.decade = decade
        return cell
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
