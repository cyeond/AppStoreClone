//
//  APIRouter.swift
//  AppStoreClone
//
//  Created by YD on 12/10/24.
//

import Foundation

enum APIRouter: APIRouterProtocol {
    case search(text: String)
    case lookup(id: String)
    
    var path: String {
        switch self {
        case .search:
            return "search"
        case .lookup:
            return "lookup"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var queryItems: [URLQueryItem]? {
        var items: [URLQueryItem] = []
        items.append(URLQueryItem(name: "entity", value: "software"))
        items.append(URLQueryItem(name: "country", value: "kr"))
        
        switch self {
        case .search(let text):
            items.append(URLQueryItem(name: "term", value: text))
        case .lookup(let id):
            items.append(URLQueryItem(name: "id", value: id))
        }
        
        return items
    }
}

extension APIRouter {
    func asURLRequest() -> URLRequest? {
        guard var url: URL = URL(string: baseURL)?.appendingPathComponent(path) else { return nil }
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = queryItems

        url = urlComponents?.url ?? url
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = timeoutInterval

        return request
    }
}
