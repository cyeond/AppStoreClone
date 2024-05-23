//
//  AppPreviewBasicCollectionViewCell.swift
//  RIBsPractice
//
//  Created by YD on 5/16/24.
//

import UIKit
import RxSwift

struct AppPreviewBasicViewModel {
    let previewInfo: AppPreviewInfo
    let tapHandler: (() -> Void)
}

final class AppPreviewBasicCell: UICollectionViewCell {
    static let identifier = "AppPreviewBasicCell"
    
    private var disposeBag = DisposeBag()
    
    private let previewView: AppPreviewBasicView = {
        let view = AppPreviewBasicView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    func update(with viewModel: AppPreviewBasicViewModel) {
        previewView.updateInfo(title: viewModel.previewInfo.title, subtitle: viewModel.previewInfo.subtitle, tapHandler: viewModel.tapHandler)
        
        ImageDownloader.downloadImage(uriString: viewModel.previewInfo.iconUri)
            .subscribe(on: ImageDownloader.imageDownloaderScheduler)
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { weakSelf, image in
                weakSelf.previewView.updateImage(image: image)
            }
            .disposed(by: disposeBag)
    }
}
