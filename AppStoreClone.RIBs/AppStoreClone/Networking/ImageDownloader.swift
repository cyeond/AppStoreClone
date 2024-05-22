//
//  ImageDownloadUtil.swift
//  AppStoreClone
//
//  Created by YD on 5/22/24.
//

import UIKit
import RxSwift

struct ImageDownloader {
    static let imageDownloaderQueue = DispatchQueue.global(qos: .background)
    static let imageDownloaderScheduler = ConcurrentDispatchQueueScheduler(queue: imageDownloaderQueue)
    
    static func downloadImage(uriString: String) -> Single<UIImage> {
        guard let url = URL(string: uriString) else {
            return Observable.empty().asSingle()
        }
        
        let components = uriString.components(separatedBy: "/")
        let id = components[components.count-2]
        
        return Single<UIImage>.create { observer -> Disposable in
            var task: URLSessionDataTask?
            
            if let memoryCachedImage = MemoryCacheManager.shared.getImageFromMemory(key: id) {
                observer(.success(memoryCachedImage))
            } else if let diskCachedImage = DiskCacheUtil.getImageFromDisk(key: id) {
                observer(.success(diskCachedImage))
                MemoryCacheManager.shared.setImageIntoMemory(key: id, image: diskCachedImage)
            } else {
                task = URLSession.shared.dataTask(with: url) { data, response, error in
                    if let error = error {
                        observer(.failure(APIError.responseError(error.localizedDescription)))
                        return
                    }
                    
                    if let data = data, let uiImage = UIImage(data: data) {
                        observer(.success(uiImage))
                        MemoryCacheManager.shared.setImageIntoMemory(key: id, image: uiImage)
                        DiskCacheUtil.setImageIntoDisk(key: id, image: uiImage)
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
