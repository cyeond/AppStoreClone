//
//  File.swift
//  
//
//  Created by YD on 6/13/24.
//

import Foundation

public enum RatingInfoType: Hashable {
    case userRating(rating: Double, ratingCount: Int)
    case contentRating(String)
    case developerName(String)
    case languages([String])
}
