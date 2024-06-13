//
//  AppDetailsRepository.swift
//  AppStoreClone
//
//  Created by YD on 6/12/24.
//

import Foundation
import RxSwift
import Entities
import Network

protocol AppDetailsRepository {
    var appId: String { get }
    var appInfoObservable: Observable<AppInfo> { get }
    var errorObservable: Observable<Error> { get }
}

final class AppDetailsRepositoryImp: AppDetailsRepository {
    let appId: String
    let appInfoObservable: Observable<AppInfo>
    var errorObservable: Observable<Error>
    
    init(appId: String) {
        self.appId = appId
        
        let events = API.lookup(appId)
            .asObservable()
            .materialize()
            .share(replay: 1)

        self.appInfoObservable = events
            .compactMap { event -> AppInfo? in
                switch event {
                case .next(let value):
                    return value.results[safe: 0]
                case .error, .completed:
                    return nil
                }
            }
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .asObservable()
            .share(replay: 1)
        
        self.errorObservable = events
            .compactMap { event -> Error? in
                switch event {
                case .error(let error):
                    return error
                case .next, .completed:
                    return nil
                }
            }
            .asObservable()
    }
}
