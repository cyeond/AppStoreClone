//
//  ScreenshotCell.swift
//  AppStoreClone
//
//  Created by YD on 5/22/24.
//

import UIKit
import RxSwift
import Network

public final class ScreenshotCell: UICollectionViewCell {
    public static let identifier = "ScreenshotCell"
    public static let width: CGFloat = 196.0
    public static let height: CGFloat = 348.0
    
    private var disposeBag = DisposeBag()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.roundCorners()
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
    
    public override func prepareForReuse() {
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
    
    public func update(uri: String) {
        ImageDownloader.downloadImage(uriString: uri)
            .subscribe(on: ImageDownloader.imageDownloaderScheduler)
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { weakSelf, image in
                weakSelf.imageView.image = image
            }
            .disposed(by: disposeBag)
    }
}
