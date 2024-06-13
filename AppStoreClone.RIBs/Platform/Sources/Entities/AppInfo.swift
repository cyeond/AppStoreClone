//
//  AppInfo.swift
//  AppStoreClone
//
//  Created by YD on 5/20/24.
//

import Foundation

public struct AppInfo: Decodable {
    public let title, developerName, description, iconUrl, primaryGenreName, trackContentRating, version, releaseDate, appstoreUrl: String
    public let releaseNote: String?
    public let id, userRatingCount: Int
    public let averageUserRating: Double
    public let screenshotUrls, languageCodes: [String]
    
    public enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case title = "trackName"
        case iconUrl = "artworkUrl512"
        case developerName = "artistName"
        case releaseNote = "releaseNotes"
        case releaseDate = "currentVersionReleaseDate"
        case appstoreUrl = "trackViewUrl"
        case languageCodes = "languageCodesISO2A"
        case version, description, primaryGenreName, trackContentRating, userRatingCount, averageUserRating, screenshotUrls
    }
}
