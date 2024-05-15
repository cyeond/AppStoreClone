//
//  AppPreviewBasicInfoView.swift
//  RIBsPractice
//
//  Created by YD on 5/14/24.
//

import UIKit

final class AppPreviewBasicInfoView: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(color: .systemOrange))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.roundCorners(4)
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
        label.text = "RIBs Practice"
        label.font = .systemFont(ofSize: 18.0)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "RIBs 아키텍처 프레임워크를 연습하기 위한 테스트 프로젝트입니다."
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
        button.backgroundColor = .systemBlue
        button.setTitle("받기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14.0)
        button.addTarget(self, action: #selector(actionButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
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
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10.0),
            imageView.heightAnchor.constraint(equalToConstant: 60.0),
            imageView.widthAnchor.constraint(equalToConstant: 60.0),
            
            actionButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            actionButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0),
            actionButton.widthAnchor.constraint(equalToConstant: 70.0),
            actionButton.heightAnchor.constraint(equalToConstant: 30.0),

            titleStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10.0),
            titleStackView.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor, constant: -20.0),
            titleStackView.heightAnchor.constraint(lessThanOrEqualToConstant: 60.0),
        ])
    }
    
    @objc
    private func actionButtonDidTap() {
        
    }
}
