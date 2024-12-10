//
//  API.swift
//  AppStoreClone
//
//  Created by YD on 5/20/24.
//

import Foundation
import RxSwift

enum APIError: Error {
    case urlError
    case responseError(String)
    case decodingError
}

struct API {
    static func search(_ text: String) -> Single<APISearchResult> {
        guard let request = APIRouter.search(text: text).asURLRequest() else { return Single<APISearchResult>.error(APIError.urlError) }
        
        return Single<APISearchResult>.create { observer in
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
    
    static func lookup(_ id: String) -> Single<APISearchResult> {
        guard let request = APIRouter.lookup(id: id).asURLRequest() else { return Single<APISearchResult>.error(APIError.urlError) }
        
        return Single<APISearchResult>.create { observer in
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
