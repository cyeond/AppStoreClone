//
//  APISearchResult.swift
//  AppStoreClone
//
//  Created by YD on 5/20/24.
//

struct APISearchResult: Decodable {
    let resultCount: Int
    let results: [AppInfo]
}
