//
//  ImageSearchTableViewController.swift
//  Decade
//
//  Created by Nick Reichard on 5/1/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class DecadeSearchTableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var imageSearchBar: UISearchBar!
    
    var deckades: [Decade] = [] {
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
        
        DecadeSearchController.shared.searchForImagesWith(searchTerm: searchTerm) { (newDecade, nil) in
            DispatchQueue.main.async {
                
                self.deckades = newDecade!
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return deckades.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "decadeCell", for: indexPath) as? 
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
