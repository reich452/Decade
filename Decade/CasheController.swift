//
//  CasheController.swift
//  Decade
//
//  Created by Nick Reichard on 5/16/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

struct CasheController {
    
    static let shared = CasheController()
    
    func cacheUrls() {
        
        let memoryCapacity = 500 * 1024 * 1024
        let diskCapacity = 500 * 1024 * 1024
        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "myDiskPath")
        
        URLCache.shared = urlCache
    }
}
