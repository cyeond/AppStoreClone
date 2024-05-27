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
    func downloadButtonDidTap()
    func shareButtonDidTap()
}

final class TopInfoDashboardViewController: UIViewController, TopInfoDashboardPresentable, TopInfoDashboardViewControllable {
    static let height: CGFloat = 120.0
    
    weak var listener: TopInfoDashboardPresentableListener?
   
    private let disposeBag = DisposeBag()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(color: .text))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.roundCorners()
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
        label.font = .systemFont(ofSize: 20.0)
        label.textColor = .text
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15.0)
        label.textColor = .systemGray
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        return stackView
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
        view.addSubview(titleStackView)
        view.addSubview(buttonsStackView)
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(subtitleLabel)
        
        buttonsStackView.addArrangedSubview(actionButton)
        buttonsStackView.addArrangedSubview(shareButton)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10.0),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10.0),
            imageView.heightAnchor.constraint(equalToConstant: TopInfoDashboardViewController.height-20.0),
            imageView.widthAnchor.constraint(equalToConstant: TopInfoDashboardViewController.height-20.0),
            
            titleStackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15.0),
            titleStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            titleStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10.0),
            titleStackView.heightAnchor.constraint(lessThanOrEqualToConstant: TopInfoDashboardViewController.height-50.0),
            
            buttonsStackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15.0),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10.0),
            
            actionButton.leadingAnchor.constraint(equalTo: buttonsStackView.leadingAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 70.0),
            actionButton.heightAnchor.constraint(equalToConstant: 30.0),
            
            shareButton.trailingAnchor.constraint(equalTo: buttonsStackView.trailingAnchor),
            shareButton.heightAnchor.constraint(equalToConstant: 30.0),
            shareButton.widthAnchor.constraint(equalToConstant: 25.0),
        ])
    }
    
    @objc
    private func actionButtonDidTap() {
        listener?.downloadButtonDidTap()
    }
    
    @objc
    private func shareButtonDidTap() {
        listener?.shareButtonDidTap()
    }
    
    func update(with info: AppPreviewInfo) {
        titleLabel.text = info.title
        subtitleLabel.text = info.developerName
        
        ImageDownloader.downloadImage(uriString: info.iconUri)
            .subscribe(on: ImageDownloader.imageDownloaderScheduler)
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { weakSelf, image in
                weakSelf.imageView.image = image
            }
            .disposed(by: disposeBag)
    }
}
