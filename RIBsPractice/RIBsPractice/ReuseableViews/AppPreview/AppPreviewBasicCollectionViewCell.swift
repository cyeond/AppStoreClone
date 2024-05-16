//
//  AppPreviewBasicCollectionViewCell.swift
//  RIBsPractice
//
//  Created by YD on 5/16/24.
//

import UIKit

final class AppPreviewBasicCollectionViewCell: UICollectionViewCell {
    static let identifier = "AppPreviewCollectionViewCell"
    
    private let previewView: AppPreviewBasicInfoView = {
        let view = AppPreviewBasicInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        addSubview(previewView)
        
        NSLayoutConstraint.activate([
            previewView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            previewView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            previewView.topAnchor.constraint(equalTo: self.topAnchor),
            previewView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
