//
//  API.swift
//  AppStoreClone
//
//  Created by YD on 5/20/24.
//

import Foundation
import RxSwift

public enum APIError: Error {
    case urlError
    case responseError(String)
    case decodingError
}

public struct API {
    public static func search(_ text: String) -> Single<APISearchResult> {
        guard let encodedKeyword = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: Constants.searchAPIPrefix + "&term=" + encodedKeyword) else { return Single<APISearchResult>.error(APIError.urlError) }
        
        return Single<APISearchResult>.create { observer in
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.timeoutInterval = TimeInterval(10)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    observer(.failure(APIError.responseError(error.localizedDescription)))
                    return
                }
                if let data = data, let result = try? JSONDecoder().decode(APISearchResult.self, from: data) {
                    observer(.success(result))
                } else {
                    observer(.failure(APIError.decodingError))
                }
            }
            
            task.resume()
            
            return Disposables.create() {
                task.cancel()
            }
        }
    }
    
    public static func lookup(_ id: String) -> Single<APISearchResult> {
        guard let encodedId = id.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: Constants.lookupAPIPrefix + "&id=" + encodedId) else { return Single<APISearchResult>.error(APIError.urlError) }
        
        return Single<APISearchResult>.create { observer in
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.timeoutInterval = TimeInterval(10)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    observer(.failure(APIError.responseError(error.localizedDescription)))
                    return
                }
                if let data = data, let result = try? JSONDecoder().decode(APISearchResult.self, from: data) {
                    observer(.success(result))
                } else {
                    observer(.failure(APIError.decodingError))
                }
            }
            
            task.resume()
            
            return Disposables.create() {
                task.cancel()
            }
        }
    }
}
