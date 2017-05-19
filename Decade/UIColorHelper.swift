//
//  UIColorHelper.swift
//  Decade
//
//  Created by Nick Reichard on 5/8/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let customBackgroundColor = #colorLiteral(red: 0.07450980392, green: 0.07843137255, blue: 0.07843137255, alpha: 1)
}

extension UIColor {
    
    static let customTabBarColor = #colorLiteral(red: 0.1215686275, green: 0.1254901961, blue: 0.1333333333, alpha: 1)
}

extension CGColor {
    static let customBackgroundColor = #colorLiteral(red: 0.07450980392, green: 0.07843137255, blue: 0.07843137255, alpha: 1)
}

extension UIColor {
    
    static func rgb(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
}
