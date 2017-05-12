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
        searchBarUI()
        imageSearchBar.delegate = self
    }
    
    // MARK: - SearchBar
    
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
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        // TODO: - Not showing Up????
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
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

// Mark Search Bar UI

extension DecadeSearchTableViewController {
    func searchBarUI() {
       
        let textFieldInsideSearchBar = imageSearchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.black
        imageSearchBar.backgroundColor = UIColor.black
        imageSearchBar.placeholder = "Decade Search"
        
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = UIColor.lightGray
        
        let clearButton = textFieldInsideSearchBar?.value(forKey: "clearButton") as! UIButton
        clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        clearButton.tintColor = UIColor.red
        
        let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
        
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        glassIconView?.tintColor = UIColor.black
    }
   
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if imageSearchBar.isFirstResponder == true {
            imageSearchBar.placeholder = ""
        }
    }
}

