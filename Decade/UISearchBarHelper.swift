//
//  UISearchBarHelper.swift
//  Decade
//
//  Created by Nick Reichard on 5/10/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation

import UIKit

extension UISearchBar {
    
    // MARK: - TODO: - use custom searchbar
   static func searchBarUI() -> UISearchBar {
        let imageSearchBar = UISearchBar()
        let mySearchBar = imageSearchBar
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
        return mySearchBar
    }
}
