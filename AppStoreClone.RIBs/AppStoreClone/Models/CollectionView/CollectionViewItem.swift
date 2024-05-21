//
//  CollectionViewItem.swift
//  RIBsPractice
//
//  Created by YD on 5/17/24.
//

import Foundation

enum CollectionViewItemType: Hashable {
    case appPreviewBasic(AppPreviewInfo)
    case ratingInfo(RatingInfoType)
}

struct CollectionViewItem: Hashable {
    let id: String
    let type: CollectionViewItemType
    
    init(type: CollectionViewItemType) {
        self.type = type
        self.id = UUID().uuidString
    }
}
