//
//  CustomTabBarController.swift
//  Decade
//
//  Created by Nick Reichard on 5/2/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customTabBar()
        
    }
    
    func customTabBar() {
        let storyboard1 = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard1.instantiateViewController(withIdentifier: "decadeHomeController")
        navigationController.title = "Home"
        navigationController.tabBarItem.image = #imageLiteral(resourceName: "homeIcon")
        
        let storyboard2 = UIStoryboard(name: "Main", bundle: nil)
        let decadeSearchTVC = storyboard2.instantiateViewController(withIdentifier: "decadeSearchTVC")
        let secondNavigationController = UINavigationController(rootViewController: decadeSearchTVC)
        secondNavigationController.title = "Search"
        secondNavigationController.tabBarItem.image = #imageLiteral(resourceName: "searchIcon")
        
        let storyboard3 = UIStoryboard(name: "Main", bundle: nil)
        let saveSearchTVC = storyboard3.instantiateViewController(withIdentifier: "savedImages")
        let thridNavigationController = UINavigationController(rootViewController: saveSearchTVC)
        thridNavigationController.title = "Saved"
        thridNavigationController.tabBarItem.image = #imageLiteral(resourceName: "heartIcon")
        
        viewControllers = [navigationController, secondNavigationController, thridNavigationController]
        
        tabBar.isTranslucent = true
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        topBorder.backgroundColor = UIColor.rgb(229, green: 231, blue: 235).cgColor
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true 
        
    }
}

