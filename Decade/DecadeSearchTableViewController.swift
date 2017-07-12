//
//  DecadeSearchTableViewController.swift
//  Decade
//
//  Created by Nick Reichard on 5/1/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit
import SafariServices

class DecadeSearchTableViewController: UITableViewController, UISearchBarDelegate, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var imageSearchBar: UISearchBar!
    
    // MARK: - Properties
    
   fileprivate let decadeSearchCell = "decadeSearchCell"
    
    
    var decades: [Decade] = []
    var safariVC: SFSafariViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarUI()
        imageSearchBar.delegate = self
        self.title = "Search"
    }
    
    // MARK: - SearchBar
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        guard let searchTerm = searchBar.text else { return }
        
        DecadeSearchController.shared.searchForImagesWith(searchTerm: searchTerm, recordFetchedBlock: { (decade) in
            guard let decade = decade else { return }
            
            DispatchQueue.main.async {
                self.decades.append(decade)
                let indexPath = IndexPath(row: self.decades.count - 1, section: 0)
                let indexPaths = [indexPath]
                self.tableView.insertRows(at: indexPaths, with: .fade)
                
            }
            
        }) { (decadeError) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let decadeError = decadeError {
                print("Error fetching searchTerm \(decadeError.localizedDescription)")
                self.connectionFailedAlert()
                return
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decades.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: decadeSearchCell, for: indexPath) as? DecadeSearchTableViewCell else { print("Can't return DecadeSearchTableViewCell"); return UITableViewCell() }
        
        let decade = decades[indexPath.row]
        cell.decade = decade
        return cell
    }
    
    // MARK: - Navigation Safari
    
    func showSafariView(urlString: String) {
        guard let url = NSURL(string: urlString) else { return }
        
        let webVC = SFSafariViewController(url: url as URL, entersReaderIfAvailable: true)
        webVC.delegate = self
        present(webVC, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let decade = decades[indexPath.row]
        
        guard let url = decade.hostPageUrl else { print("Can't get the decade host page url"); return }
        self.showSafariView(urlString: url)
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true, completion: nil)
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
    
    // MARK: - Delegate Methods 
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        imageSearchBar.showsCancelButton = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == true {
            decades.removeAll()
            tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        imageSearchBar.showsCancelButton = false
        searchBar.text = nil
        searchBar.resignFirstResponder()
        
    }
}

extension DecadeSearchTableViewController {
    func connectionFailedAlert() {
        let alertController = UIAlertController(title: "Connection Failed", message: "Please wait unitl you have service", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

