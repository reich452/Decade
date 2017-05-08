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
    
    var timer: Timer!
    var updateCount: Int = 0
    
    override func viewDidLoad() {
        updateCount = 0
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector (DecadeHomeViewController.updateTimer), userInfo: nil, repeats: true)
    }
    
    internal func updateTimer() {
        if(updateCount <= 2) {
            headerPageController.currentPage = updateCount
            headerImageView.image = UIImage(named: String(updateCount+1) + ".jpg")
            updateCount = updateCount + 1
        } else {
            updateCount = 0
        }
    }
}



