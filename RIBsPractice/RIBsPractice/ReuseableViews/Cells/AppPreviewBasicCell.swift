//
//  AppPreviewBasicCollectionViewCell.swift
//  RIBsPractice
//
//  Created by YD on 5/16/24.
//

import UIKit

final class AppPreviewBasicCell: UICollectionViewCell {
    static let identifier = "AppPreviewBasicCell"
    
    private let previewView: AppPreviewBasicView = {
        let view = AppPreviewBasicView()
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
    
    func update(with viewModel: AppPreviewBasicViewModel) {
        previewView.update(with: viewModel)
    }
}
