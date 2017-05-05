//
//  DecadeError.swift
//  Decade
//
//  Created by Nick Reichard on 5/1/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation

enum DecadeError: Error {
    case baseUrlFailed
    case imageSearchFailure
    case invalidData
    case invalidResponseData
    case responseUnsucessful
    case jsonConversionFailure
    case imageUrlFailed
    case imageSearchUnsucessful
    case noImageData
    case imageInitilizationFailure
    case noPreslectedDecades
}

