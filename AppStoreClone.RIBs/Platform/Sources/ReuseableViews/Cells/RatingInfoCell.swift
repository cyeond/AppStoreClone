//
//  RatingInfoCell.swift
//  AppStoreClone
//
//  Created by YD on 5/20/24.
//

import UIKit
import Entities

public final class RatingInfoCell: UICollectionViewCell {
    public static let identifier = "RatingInfoCell"
    public static let width: CGFloat = 120.0
    public static let height: CGFloat = 100.0
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 12.0)
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        return label
    }()
    
    private let subContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 15.0)
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.crop.rectangle.fill"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .systemGray
        return imageView
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
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    public func update(type: RatingInfoType) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        switch type {
        case .userRating(let rating, let ratingCount):
            titleLabel.text = ratingCount.toUnitConvertedString() + "개의 평가"
            contentLabel.text = String(format: "%.2f", rating)
            subContentLabel.text = "★★★★★"
        case .contentRating(let rating):
            titleLabel.text = "연령"
            contentLabel.text = rating
            subContentLabel.text = "세"
        case .developerName(let name):
            titleLabel.text = "개발자"
            subContentLabel.text = name
        case .languages(let languages):
            titleLabel.text = "언어"
            contentLabel.text = languages[safe: 0]
            subContentLabel.text = " "
            if languages.count > 1 {
                subContentLabel.text = "+ \(languages.count-1)개 언어"
            }
        }
        
        switch type {
        case .developerName:
            stackView.addArrangedSubview(titleLabel)
            stackView.addArrangedSubview(imageView)
            stackView.addArrangedSubview(subContentLabel)
        default:
            stackView.addArrangedSubview(titleLabel)
            stackView.addArrangedSubview(contentLabel)
            stackView.addArrangedSubview(subContentLabel)
        }
    }
}

