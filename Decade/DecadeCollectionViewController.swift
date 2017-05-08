//
//  DecadeCollectionViewController.swift
//  Decade
//
//  Created by Nick Reichard on 5/1/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class DecadeCollectionViewController: UICollectionViewController {
    
//    @IBOutlet weak var headerImageView: UIImageView!
//    @IBOutlet weak var headerPageController: UIPageControl!
    
    var decades: [Decade] = []
    var timer: Timer?
    var updateCount: Int = 0
    
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

// Mark: - Header Timer & Images

//extension DecadeCollectionViewController {
//    
//    func setupTimer() {
//        updateCount = 0
//        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(DecadeCollectionViewController.updateTimer), userInfo: nil, repeats: true)
//    }
//    
//    internal func updateTimer() { 
//        if(updateCount <= 2) {
//            headerPageController.currentPage = updateCount
//            headerImageView.image = UIImage(named: String(updateCount+1) + ".jpg")
//            updateCount = updateCount + 1
//        } else {
//            updateCount = 0
//        }
//    }
//}

