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
}

final class AppDetailsRepositoryImp: AppDetailsRepository {
    let appId: String
    let appInfoObservable: Observable<AppInfo>
    
    init(appId: String) {
        self.appId = appId
        self.appInfoObservable = API.lookup(appId)
            .compactMap { $0.results[safe: 0] }
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .asObservable()
            .share(replay: 1)
    }
}
