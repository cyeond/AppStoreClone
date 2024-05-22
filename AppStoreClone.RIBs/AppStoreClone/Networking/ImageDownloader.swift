//
//  ImageDownloadUtil.swift
//  AppStoreClone
//
//  Created by YD on 5/22/24.
//

import UIKit
import RxSwift

struct ImageDownloader {
    static func downloadImage(uriString: String, isbn: String) -> Single<UIImage> {
        guard let url = URL(string: uriString) else {
            return Observable.empty().asSingle()
        }
        
        return Single<UIImage>.create { observer -> Disposable in
            var task: URLSessionDataTask?
            
            if let memoryCachedImage = MemoryCacheManager.shared.getImageFromMemory(key: isbn) {
                observer(.success(memoryCachedImage))
            } else if let diskCachedImage = DiskCacheUtil.getImageFromDisk(key: isbn) {
                observer(.success(diskCachedImage))
                MemoryCacheManager.shared.setImageIntoMemory(key: isbn, image: diskCachedImage)
            } else {
                task = URLSession.shared.dataTask(with: url) { data, response, error in
                    if let error = error {
                        observer(.failure(APIError.responseError(error.localizedDescription)))
                        return
                    }
                    
                    if let data = data, let uiImage = UIImage(data: data) {
                        observer(.success(uiImage))
                        MemoryCacheManager.shared.setImageIntoMemory(key: isbn, image: uiImage)
                        DiskCacheUtil.setImageIntoDisk(key: isbn, image: uiImage)
                    } else {
                        observer(.failure(APIError.decodingError))
                    }
                }
                
                task?.resume()
            }
            
            return Disposables.create() {
                task?.cancel()
            }
        }
    }
}
