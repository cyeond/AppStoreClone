//
//  TopInfoDashboardViewController.swift
//  RIBsPractice
//
//  Created by YD on 5/18/24.
//

import RIBs
import RxSwift
import UIKit

protocol TopInfoDashboardPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class TopInfoDashboardViewController: UIViewController, TopInfoDashboardPresentable, TopInfoDashboardViewControllable {
    static let height: CGFloat = 120.0
    
    weak var listener: TopInfoDashboardPresentableListener?
    
    private var actionButtonTapHandler: (() -> Void)?
    private var shareButtonTapHandler: (() -> Void)?
    
    private let imageView: UIImageView = {
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        let color = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        let imageView = UIImageView(image: UIImage(color: color))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.roundCorners()
        return imageView
    }()
    
    private let centerStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
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
        label.font = .systemFont(ofSize: 20.0)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 2
        label.text = "토스"
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15.0)
        label.textColor = .systemGray
        label.textAlignment = .left
        label.numberOfLines = 2
        label.text = "금융이 쉬워진다"
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
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(shareButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(imageView)
        view.addSubview(centerStackView)
        view.addSubview(shareButton)
        
        centerStackView.addSubview(titleStackView)
        centerStackView.addSubview(actionButton)
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10.0),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10.0),
            imageView.heightAnchor.constraint(equalToConstant: TopInfoDashboardViewController.height-20.0),
            imageView.widthAnchor.constraint(equalToConstant: TopInfoDashboardViewController.height-20.0),
            
            shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            shareButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10.0),
            shareButton.heightAnchor.constraint(equalToConstant: 30.0),
            shareButton.widthAnchor.constraint(equalToConstant: 25.0),
            
            centerStackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15.0),
            centerStackView.trailingAnchor.constraint(equalTo: shareButton.trailingAnchor),
            centerStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10.0),
            centerStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10.0),
            
            titleStackView.leadingAnchor.constraint(equalTo: centerStackView.leadingAnchor),
            titleStackView.trailingAnchor.constraint(equalTo: centerStackView.trailingAnchor),
            titleStackView.topAnchor.constraint(equalTo: centerStackView.topAnchor),
            titleStackView.heightAnchor.constraint(lessThanOrEqualToConstant: TopInfoDashboardViewController.height-50.0),
            
            actionButton.leadingAnchor.constraint(equalTo: centerStackView.leadingAnchor),
            actionButton.bottomAnchor.constraint(equalTo: centerStackView.bottomAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 70.0),
            actionButton.heightAnchor.constraint(equalToConstant: 30.0),
        ])
    }
    
    @objc
    private func actionButtonDidTap() {
        actionButtonTapHandler?()
    }
    
    @objc
    private func shareButtonDidTap() {
        shareButtonTapHandler?()
    }
    
    func update(with info: AppPreviewInfo) {
        titleLabel.text = info.title
        subtitleLabel.text = info.subtitle
    }
}
