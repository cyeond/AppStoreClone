//
//  ScreenshotCell.swift
//  AppStoreClone
//
//  Created by YD on 5/22/24.
//

import UIKit
import RxSwift

final class ScreenshotCell: UICollectionViewCell {
    static let identifier = "ScreenshotCell"
    static let width: CGFloat = 196.0
    static let height: CGFloat = 348.0
    
    private var disposeBag = DisposeBag()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.roundCorners()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
        imageView.image = nil
        
        super.prepareForReuse()
    }
    
    private func setupViews() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func update(uri: String) {
        ImageDownloader.downloadImage(uriString: uri)
            .subscribe(on: ImageDownloader.imageDownloaderScheduler)
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { weakSelf, image in
                weakSelf.imageView.image = image
            }
            .disposed(by: disposeBag)
    }
}
