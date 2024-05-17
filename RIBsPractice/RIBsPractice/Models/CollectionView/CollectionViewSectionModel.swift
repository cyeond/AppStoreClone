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
    
    func layoutSection() -> NSCollectionLayoutSection {
        switch self.section.type {
        case .groupThree(title: _, subtitle: _):
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(AppPreviewBasicHeaderView.height))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(AppPreviewBasicView.height*3))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            section.interGroupSpacing = 10.0
            section.boundarySupplementaryItems = [header]
            return section
        }
    }
}
