//
//  DateFormatter.swift
//  Decade
//
//  Created by Nick Reichard on 6/27/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation

extension Date {
    
    var formatter: DateFormatter? {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        return formatter
    }
    
    var currentYear: Int? {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let year = components.year
        
        return year
    }
}
