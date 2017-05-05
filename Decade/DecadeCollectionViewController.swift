//
//  DecadeCollectionViewController.swift
//  Decade
//
//  Created by Nick Reichard on 5/1/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class DecadeCollectionViewController: UICollectionViewController {
    
    var decades: [Decade] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDecadeDetail" {
            if let decadeDetailTVC = segue.destination as? DecadeTableViewController {
                decadeDetailTVC.decades = self.decades
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return LocalImageHelper.localImageArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "decadeCell", for: indexPath) as? DecadeCollectionViewCell else { return DecadeCollectionViewCell() }
        
        let image = LocalImageHelper.localImageArray[indexPath.row]
        cell.decadeImageView.image = image
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        //        let searchTerm = LocalImageHelper.localImageNames[indexPath.item]
        var selectedDecade: Decades = .none
        
        switch indexPath.item {
        case 0:
            selectedDecade = .currentYear
        case 1:
            selectedDecade = .twothousands
        case 2:
            selectedDecade = .ninties
        case 3:
            selectedDecade = .eightys
        case 4:
            selectedDecade = .seventies
        case 5:
            selectedDecade = .sixties
        case 6:
            selectedDecade = .fifties
        default:
            print("Can't preset decade \(DecadeError.noPreslectedDecades)")
            break
        }
        let searchTerms = DecadeSearchController.shared.searchTermsFor(decade: selectedDecade)
        
        DecadeSearchController.shared.searchForImagesWithKeywords(keywords: searchTerms) { (newDecades, decadeError) in
            guard let decades = newDecades else  { return }
            DispatchQueue.main.async {
                self.decades = decades
                self.performSegue(withIdentifier: "toDecadeDetail", sender: self)
            }
        }
    }
}

extension UICollectionViewController {
    enum UICollectionViewSegue: String {
        case toDecadeTVC
        case toDecadeCVC
        case unnamed = ""
    }
}
// Conforming types will have to provide a nested type of the same name enumerating all of the segues the view controller expects to handle
protocol SegueHandler {
    associatedtype UICollectionViewControllerSegue: RawRepresentable
    func segueIdentifierCase(for segue: UIStoryboardSegue) -> UICollectionViewControllerSegue?
}

extension SegueHandler where Self: UICollectionViewController, UICollectionViewControllerSegue.RawValue == String {
    func segueIdentifierCase(for segue: UIStoryboardSegue) -> UICollectionViewSegue {
        guard let identifier = segue.identifier,
            let identifierCase = UICollectionViewSegue(rawValue: identifier) else {
                fatalError("Could not map segue identifier -- \(String(describing: segue.identifier)) -- to segue case")
        }
        return identifierCase
    }
}
