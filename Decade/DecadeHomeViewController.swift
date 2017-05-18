//
//  DecadeViewController.swift
//  Decade
//
//  Created by Nick Reichard on 5/8/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class DecadeHomeViewController: UIViewController {
    
    @IBOutlet weak var headerScrollView: UIScrollView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerPageController: UIPageControl!
    
    var decades: [Decade] = []
    var searchTerms: [String] = []
    var timer: Timer!
    var updateCount: Int = 0
    var headerImages = [UIImage]()
    var headerImageArray = LocalImageHelper.headerImageArray
    
    override func viewDidLoad() {
        
        updateCount = 0
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector (DecadeHomeViewController.updateTimer), userInfo: nil, repeats: true)
        UserController.shared.fetchLoggedInUser {
            self.updateLikedDeades()
        }
        
    }
    
    internal func updateTimer() {
        if(updateCount <= 3) {
            headerPageController.currentPage = updateCount
            headerImageView.image = UIImage(named: String(updateCount + 1) + ".jpg")
            updateCount = updateCount + 1
        } else {
            updateCount = 0
        }
    }
    
    internal func horizontalScroll() {
        
        for i in 0..<headerImageArray.count {
            let imageView = UIImageView()
            imageView.image = headerImageArray[i]
            imageView.contentMode = .scaleAspectFit
            let xPosition = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.headerScrollView.frame.width, height: self.headerScrollView.frame.height)
            
            headerScrollView.contentSize.width = headerScrollView.frame.width * CGFloat(i + 1)
            headerScrollView.addSubview(imageView)
            
        }
    }
    
    internal func updateLikedDeades() {
        DecadeController.shared.fetchUserLikedDecades {
            
        }
    }
}

extension DecadeHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDecadeDetail" {
            if let decadeDetailTVC = segue.destination as? DecadeTableViewController {
                decadeDetailTVC.searchTerms = self.searchTerms
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
        
        DecadeSearchController.shared.decades = []
        
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
        
        self.searchTerms = searchTerms
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "toDecadeDetail", sender: self)
        }
    }
}



