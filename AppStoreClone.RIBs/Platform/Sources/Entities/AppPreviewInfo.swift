//
//  AppPreviewInfo.swift
//  RIBsPractice
//
//  Created by YD on 5/17/24.
//

public struct AppPreviewInfo: Hashable {
    public let id: String
    public let title: String
    public let developerName: String
    public let iconUri: String
    
    public init(id: String, title: String, developerName: String, iconUri: String) {
        self.id = id
        self.title = title
        self.developerName = developerName
        self.iconUri = iconUri
    }
}
