//
//  DecadeHomeTableViewController.swift
//  Decade
//
//  Created by Nick Reichard on 5/17/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class DecadeHomeTableViewController: UITableViewController {
    
    @IBOutlet weak var headerScrollView: UIScrollView!
    @IBOutlet weak var headerPageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var decades: [Decade] = []
    var searchTerms: [String] = []
    var timer: Timer!
    var updateCount: Int = 0
    var headerImages = [UIImage]()
    var headerImageArray = LocalImageHelper.headerImageArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHorizontalScrollView()
        collectionView.delegate = self
        collectionView.dataSource = self
        UserController.shared.fetchLoggedInUser {
            print("Sucessfully fetched LoggedIn User")
            self.updateLikedDeades()
        }
    }
    
    internal func updateLikedDeades() {
        DecadeController.shared.fetchUserLikedDecades {
            print("Feched User Liked Deades")
        }
    }
    
}

// MARK: - Horizonal Scroll View

extension DecadeHomeTableViewController {
    
    func loadHorizontalScrollView() {
        headerScrollView.delegate = self
        let headerScroll: [HeaderImage] = createSlides()
        setUpSlideScrollView(headerImages: headerScroll)
        headerPageControl.numberOfPages = headerImages.count
        headerPageControl.currentPage = 0
        view.bringSubview(toFront: headerPageControl)
    }
    
    func createSlides() -> [HeaderImage] {
        
        let firstHeader: HeaderImage = Bundle.main.loadNibNamed("HeaderImage", owner: self, options: nil)?.first as! HeaderImage
        firstHeader.headerImageView.image = #imageLiteral(resourceName: "1.jpg")
        let secondHeader: HeaderImage = Bundle.main.loadNibNamed("HeaderImage", owner: self, options: nil)?.first as! HeaderImage
        secondHeader.headerImageView.image = #imageLiteral(resourceName: "2.jpg")
        let thirdHeader: HeaderImage = Bundle.main.loadNibNamed("HeaderImage", owner: self, options: nil)?.first as! HeaderImage
        thirdHeader.headerImageView.image = #imageLiteral(resourceName: "fashion2017")
        let fourthHeader: HeaderImage = Bundle.main.loadNibNamed("HeaderImage", owner: self, options: nil)?.first as! HeaderImage
        fourthHeader.headerImageView.image = #imageLiteral(resourceName: "3.jpg")
        
        return [firstHeader, secondHeader, thirdHeader, fourthHeader]
    }
    
    func setUpSlideScrollView(headerImages: [HeaderImage]) {
        headerScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        headerScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(headerImages.count), height: view.frame.height)
        
        headerScrollView.isPagingEnabled = true
        
        for i in 0 ..< headerImages.count {
            headerImages[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            headerScrollView.addSubview(headerImages[i])
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        headerPageControl.currentPage = Int(pageIndex)
    }
    
}

extension DecadeHomeTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
