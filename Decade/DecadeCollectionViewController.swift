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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate


    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }

}
