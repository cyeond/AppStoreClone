//
//  AppInfo.swift
//  AppStoreClone
//
//  Created by YD on 5/20/24.
//

struct AppInfo: Decodable {
    let title, developerName, description, artworkUrl100, primaryGenreName, trackContentRating: String
    let id, userRatingCount: Int
    let averageUserRating: Double
    let screenshotUrls, languageCodes: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case title = "trackName"
        case developerName = "artistName"
        case description, artworkUrl100, primaryGenreName, trackContentRating, userRatingCount, averageUserRating, screenshotUrls
        case languageCodes = "languageCodesISO2A"
    }
}
