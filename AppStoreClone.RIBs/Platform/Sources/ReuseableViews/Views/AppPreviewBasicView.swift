//
//  AppPreviewBasicInfoView.swift
//  RIBsPractice
//
//  Created by YD on 5/14/24.
//

import UIKit
import ResourcesLibrary

public final class AppPreviewBasicView: UIView {
    public static let height: CGFloat = 80.0
    
    private var tapHandler: (() -> Void)?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(color: ColorProvider.text))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.roundCorners(12.0)
        imageView.setBorder()
        return imageView
    }()
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18.0)
        label.textColor = ColorProvider.text
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13.0)
        label.textColor = .systemGray
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.roundCorners(15.0)
        button.backgroundColor = .systemGray5
        button.setTitle("받기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14.0)
        button.addTarget(self, action: #selector(actionButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    public init() {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    private func setupViews() {
        addSubview(imageView)
        addSubview(titleStackView)
        addSubview(actionButton)
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10.0),
            imageView.heightAnchor.constraint(equalToConstant: AppPreviewBasicView.height-20.0),
            imageView.widthAnchor.constraint(equalToConstant: AppPreviewBasicView.height-20.0),
            
            actionButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            actionButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 70.0),
            actionButton.heightAnchor.constraint(equalToConstant: 30.0),

            titleStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10.0),
            titleStackView.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor),
            titleStackView.heightAnchor.constraint(lessThanOrEqualToConstant: AppPreviewBasicView.height-20.0),
        ])
    }
    
    @objc
    private func actionButtonDidTap() {
        tapHandler?()
    }
    
    public func updateInfo(title: String, subtitle: String, tapHandler: @escaping (() -> Void)) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        self.tapHandler = tapHandler
    }
    
    public func updateImage(image: UIImage?) {
        imageView.image = image
    }
}
