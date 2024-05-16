//
//  AppsHomeCollectionViewCell.swift
//  RIBsPractice
//
//  Created by YD on 5/16/24.
//

import UIKit

final class AppsHomeCollectionViewCell: UICollectionViewCell {
    static let identifier = "AppsHomeCollectionViewCell"
    
    private let view: AppPreviewBasicCollectionView = {
        let collectionView = AppPreviewBasicCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    private func setupViews() {
        addSubview(view)
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
