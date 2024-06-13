//
//  APISearchResult.swift
//  AppStoreClone
//
//  Created by YD on 5/20/24.
//

import Entities

public struct APISearchResult: Decodable {
    public let resultCount: Int
    public let results: [AppInfo]
}
