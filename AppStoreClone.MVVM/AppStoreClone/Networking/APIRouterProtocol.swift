//
//  APIRouterProtocol.swift
//  AppStoreClone
//
//  Created by YD on 12/10/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

typealias Parameters = [String: Any]

protocol APIRouterProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var timeoutInterval: TimeInterval { get }
}

extension APIRouterProtocol {
    var baseURL: String { Constants.apiBaseUrl }
    var timeoutInterval: TimeInterval { 10 }
}
