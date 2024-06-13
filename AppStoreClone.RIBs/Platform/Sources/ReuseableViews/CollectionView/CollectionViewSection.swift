//
//  CollectionViewSection.swift
//  RIBsPractice
//
//  Created by YD on 5/17/24.
//

import Foundation

public enum CollectionViewSectionType: Hashable {
    case groupedThree(title: String, subtitle: String)
    case verticalOne
    case horizontalOne
}

public struct CollectionViewSection: Hashable {
    public let id: String
    public let type: CollectionViewSectionType
    
    public init(type: CollectionViewSectionType) {
        self.type = type
        self.id = UUID().uuidString
    }
}
