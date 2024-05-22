//
//  DiskCacheUtil.swift
//  AppStoreClone
//
//  Created by YD on 5/22/24.
//

import UIKit

struct DiskCacheUtil {
    static func getImageFromDisk(key: String) -> UIImage? {
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else { return nil }
        
        var filePath = URL(fileURLWithPath: path)
        filePath.appendPathComponent(key)
        
        guard FileManager.default.fileExists(atPath: filePath.path) else { return nil }
        guard let imageData = try? Data(contentsOf: filePath) else { return nil }
        guard let image = UIImage(data: imageData) else { return nil }
        
        return image
    }
    
    static func setImageIntoDisk(key: String, image: UIImage) {
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else { return }
        
        var filePath = URL(fileURLWithPath: path)
        filePath.appendPathComponent(key)
        
        if !FileManager.default.fileExists(atPath: filePath.path) {
            FileManager.default.createFile(atPath: filePath.path, contents: image.pngData(), attributes: nil)
        }
    }
}

