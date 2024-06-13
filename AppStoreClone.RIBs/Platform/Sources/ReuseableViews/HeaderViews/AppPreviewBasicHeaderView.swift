//
//  AppPreviewBasicHeaderView.swift
//  RIBsPractice
//
//  Created by YD on 5/16/24.
//

import UIKit
import ResourcesLibrary

public struct AppPreviewBasicHeaderViewModel {
    public let title: String
    public let subtitle: String
    public let tapHandler: (() -> Void)
    
    public init(title: String, subtitle: String, tapHandler: @escaping () -> Void) {
        self.title = title
        self.subtitle = subtitle
        self.tapHandler = tapHandler
    }
}

public final class AppPreviewBasicHeaderView: UICollectionReusableView {
    public static let identifier = "AppPreviewBasicHeaderView"
    public static let height: CGFloat = 50.0
    
    private var tapHandler: (() -> Void)?
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = ColorProvider.text
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 15.0, weight: .regular)
        return label
    }()
    
    private lazy var seeAllButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("모두 보기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17.0)
        button.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        return button
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
        addSubview(titleStackView)
        addSubview(seeAllButton)
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            titleStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleStackView.trailingAnchor.constraint(equalTo: seeAllButton.leadingAnchor, constant: -5.0),
            
            seeAllButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            seeAllButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            seeAllButton.widthAnchor.constraint(equalToConstant: 70.0),
            seeAllButton.heightAnchor.constraint(equalToConstant: AppPreviewBasicHeaderView.height)
        ])
    }
    
    @objc
    private func seeAllButtonTapped() {
        tapHandler?()
    }
    
    public func update(with viewModel: AppPreviewBasicHeaderViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        tapHandler = viewModel.tapHandler
    }
}
