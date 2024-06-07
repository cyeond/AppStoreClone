//
//  MemoryCacheManager.swift
//  AppStoreClone
//
//  Created by YD on 5/22/24.
//

import UIKit

final class MemoryCacheManager {
    static let shared: MemoryCacheManager = .init()
    
    private init() { }
    
    private let imageCache: NSCache<NSString, UIImage> = .init()
    
    func getImageFromMemory(key: String) -> UIImage? {
        let cacheKey: NSString = .init(string: key)
        return imageCache.object(forKey: cacheKey)
    }
    
    func setImageIntoMemory(key: String, image: UIImage) {
        let cacheKey: NSString = .init(string: key)
        imageCache.setObject(image, forKey: cacheKey)
    }

    func clear() {
        imageCache.removeAllObjects()
    }
}
