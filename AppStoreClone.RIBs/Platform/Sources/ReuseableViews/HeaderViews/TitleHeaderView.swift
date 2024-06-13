//
//  TitleHeaderView.swift
//  AppStoreClone
//
//  Created by YD on 5/22/24.
//

import UIKit
import ResourcesLibrary

public final class TitleHeaderView: UICollectionReusableView {
    public static let identifier = "TitleHeaderView"
    public static let height: CGFloat = 30.0
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20.0, weight: .semibold)
        label.textColor = ColorProvider.text
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    public func update(title: String) {
        titleLabel.text = title
    }
}
