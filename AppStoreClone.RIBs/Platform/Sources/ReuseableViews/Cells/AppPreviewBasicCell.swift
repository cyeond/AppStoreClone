//
//  AppPreviewBasicCollectionViewCell.swift
//  RIBsPractice
//
//  Created by YD on 5/16/24.
//

import UIKit
import RxSwift
import Entities
import Network

public struct AppPreviewBasicViewModel {
    public let previewInfo: AppPreviewInfo
    public let tapHandler: (() -> Void)
    
    public init(previewInfo: AppPreviewInfo, tapHandler: @escaping () -> Void) {
        self.previewInfo = previewInfo
        self.tapHandler = tapHandler
    }
}

public final class AppPreviewBasicCell: UICollectionViewCell {
    public static let identifier = "AppPreviewBasicCell"
    
    private var disposeBag = DisposeBag()
    
    private let previewView: AppPreviewBasicView = {
        let view = AppPreviewBasicView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        previewView.updateImage(image: nil)
        
        super.prepareForReuse()
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
    
    public func update(with viewModel: AppPreviewBasicViewModel) {
        previewView.updateInfo(title: viewModel.previewInfo.title, subtitle: viewModel.previewInfo.developerName, tapHandler: viewModel.tapHandler)
        
        ImageDownloader.downloadImage(uriString: viewModel.previewInfo.iconUri)
            .subscribe(on: ImageDownloader.imageDownloaderScheduler)
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { weakSelf, image in
                weakSelf.previewView.updateImage(image: image)
            }
            .disposed(by: disposeBag)
    }
}
