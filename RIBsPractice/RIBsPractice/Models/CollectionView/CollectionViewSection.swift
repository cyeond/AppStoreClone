//
//  CollectionViewSection.swift
//  RIBsPractice
//
//  Created by YD on 5/17/24.
//

import Foundation

enum CollectionViewSectionType: Hashable {
    case groupThree(title: String, subtitle: String)
}

struct CollectionViewSection: Hashable {
    let id: String
    let type: CollectionViewSectionType
    
    init(type: CollectionViewSectionType) {
        self.type = type
        self.id = UUID().uuidString
    }
}
