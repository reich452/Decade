//
//  DecadeCollectionViewController.swift
//  Decade
//
//  Created by Nick Reichard on 5/1/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

private let reuseIdentifier = "decadeCell"

class DecadeCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
    }
 
    // MARK: UICollectionViewDataSource
    let mockData = [#imageLiteral(resourceName: "meal"), #imageLiteral(resourceName: "meal"), #imageLiteral(resourceName: "meal"), #imageLiteral(resourceName: "meal"), #imageLiteral(resourceName: "meal"), #imageLiteral(resourceName: "meal")]
 
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return mockData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? DecadeCollectionViewCell else { return UICollectionViewCell() }
    
        let image = mockData[indexPath.row]
        // Configure the cell
        cell.decadeImageView.image = image
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }

}
