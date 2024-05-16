//
//  AppPreviewBasicCollectionView.swift
//  RIBsPractice
//
//  Created by YD on 5/16/24.
//

import UIKit

struct AppPreviewBasicCollectionViewModel {
    
}

final class AppPreviewBasicCollectionView: UICollectionView {
    var basicDataSource: UICollectionViewDiffableDataSource<String, String>?
    
    init() {
        super.init(frame: .zero, collectionViewLayout: .init())
        
        setupCollectionView()
        setupDataSource()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupCollectionView()
        setupDataSource()
    }
    
    private func setupCollectionView() {
        backgroundColor = .white
        showsHorizontalScrollIndicator = false
        register(AppPreviewCollectionViewCell.self, forCellWithReuseIdentifier: AppPreviewCollectionViewCell.identifier)
        register(AppPreviewBasicHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AppPreviewBasicHeaderView.identifier)
        setCollectionViewLayout(createCollectionViewLayout(), animated: true)
    }
}

//MARK: - CollectionView Layout
extension AppPreviewBasicCollectionView {
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, environment in
            return self?.createLayoutSection()
        }, configuration: config)
    }
    
    private func createLayoutSection() -> NSCollectionLayoutSection {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(240.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.boundarySupplementaryItems = [header]
        return section
    }
}

//MARK: - CollectionView DataSource
extension AppPreviewBasicCollectionView {
    private func setupDataSource() {
        basicDataSource = UICollectionViewDiffableDataSource(collectionView: self, cellProvider: { collectionView, indexPath, book in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppPreviewCollectionViewCell.identifier, for: indexPath) as? AppPreviewCollectionViewCell else { return UICollectionViewCell() }
            return cell
        })
        
        basicDataSource?.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AppPreviewBasicHeaderView.identifier, for: indexPath) as? AppPreviewBasicHeaderView
            return header
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<String, String>()
        snapshot.appendSections(["1"])
        snapshot.appendItems(["1", "2", "3", "4", "5", "6", "7", "8"], toSection: "1")
        basicDataSource?.apply(snapshot)
    }
}
