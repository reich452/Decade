//
//  DecadeTableViewController.swift
//  Decade
//
//  Created by Nick Reichard on 5/1/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class DecadeTableViewController: UITableViewController, DecadesWereAddedToDelegate  {
    
    
    var searchTerms: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DecadeSearchController.shared.delegate = self
        
        self.view.backgroundColor = .customBackgroundColor
        CasheController.shared.cacheUrls()
        
        searchForDecades(searchTerms: searchTerms)
    }
    
    // MARK: - Protocol

    func decadesWereAddedTo() {
        let indexPath = IndexPath(row: DecadeSearchController.shared.decades.count - 1, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .fade)
    }
    
    func searchForDecades(searchTerms: [String]) {
        DecadeSearchController.shared.searchForImagesWithKeywords(keywords: searchTerms) { (decadeError) in
            if let error = decadeError {
                print(error.localizedDescription); return
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DecadeSearchController.shared.decades.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "decadeImageCell", for: indexPath) as? DecadeImageTableViewCell else { print("Can't return DecadeImageTableViewCell"); return UITableViewCell() }
        
        let decade = DecadeSearchController.shared.decades[indexPath.row]
        cell.decade = decade
        
        return cell
    }
}


