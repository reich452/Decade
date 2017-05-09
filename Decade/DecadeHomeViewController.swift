//
//  DecadeViewController.swift
//  Decade
//
//  Created by Nick Reichard on 5/8/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class DecadeHomeViewController: UIViewController {

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerPageController: UIPageControl!
    
    var decades: [Decade] = []
    var timer: Timer!
    var updateCount: Int = 0
    
    override func viewDidLoad() {
        updateCount = 0
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector (DecadeHomeViewController.updateTimer), userInfo: nil, repeats: true)
        
    }
    
    internal func updateTimer() {
        if(updateCount <= 3) {
            headerPageController.currentPage = updateCount
            headerImageView.image = UIImage(named: String(updateCount+1) + ".jpg")
            updateCount = updateCount + 1
        } else {
            updateCount = 0
        }
    }
}

extension DecadeHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LocalImageHelper.localImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "decadeCell", for: indexPath) as? DecadeHomeCollectionViewCell else { return DecadeHomeCollectionViewCell() }
        let image = LocalImageHelper.localImageArray[indexPath.row]
        cell.decadeImageView.image = image
        
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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



