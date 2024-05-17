//
//  CollectionViewSectionModel.swift
//  RIBsPractice
//
//  Created by YD on 5/17/24.
//

import UIKit

struct CollectionViewSectionModel {
    let section: CollectionViewSection
    let items: [CollectionViewItem]
    
    var itemHeight: CGFloat {
        var height: CGFloat = 0
        if let itemType = self.items[safe: 0]?.type {
            switch itemType {
            case .appPreviewBasic(_):
                height = AppPreviewBasicView.height
            }
        }
        return height
    }
    
    func layoutSection() -> NSCollectionLayoutSection {
        switch self.section.type {
        case .groupThree(title: _, subtitle: _):
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(self.itemHeight))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(self.itemHeight*3))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            section.interGroupSpacing = 10.0
            section.boundarySupplementaryItems = [header]
            return section
        case .verticalOne:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(self.itemHeight))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
}
