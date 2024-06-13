//
//  CollectionViewItem.swift
//  RIBsPractice
//
//  Created by YD on 5/17/24.
//

import Foundation
import Entities

public enum CollectionViewItemType: Hashable {
    case appPreviewBasic(AppPreviewInfo)
    case ratingInfo(RatingInfoType)
    case screenshot(String)
}

public struct CollectionViewItem: Hashable {
    public let id: String
    public let type: CollectionViewItemType
    
    public init(type: CollectionViewItemType) {
        self.type = type
        self.id = UUID().uuidString
    }
}
