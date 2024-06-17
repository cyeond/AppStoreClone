//
//  ReleaseNoteBuilableMock.swift
//
//
//  Created by YD on 6/14/24.
//

import Foundation
import RIBsTestSupport
import Entities
import RxSwift
@testable import AppDetailsImp

final class ReleaseNoteBuildableMock: ReleaseNoteDashboardBuildable {
    var buildHandler: ((_ listener: ReleaseNoteDashboardListener) -> ReleaseNoteDashboardRouting)?
    
    var buildCallCount = 0
    func build(withListener listener: ReleaseNoteDashboardListener) -> ReleaseNoteDashboardRouting {
        buildCallCount += 1
        
        if let buildHandler = buildHandler {
            return buildHandler(listener)
        }
        
        fatalError()
    }
}

final class ReleaseNoteRoutingMock: ViewableRoutingMock, ReleaseNoteDashboardRouting {
    
}

final class ReleaseNoteDashboardPresentableMock: ReleaseNoteDashboardPresentable {
    var listener: ReleaseNoteDashboardPresentableListener?
    
    var updateCallCount = 0
    var updateCalledSubject = PublishSubject<Void>()
    var updatedAppInfo: AppInfo?
    func update(with info: AppInfo) {
        updateCallCount += 1
        updateCalledSubject.onNext(())
        updatedAppInfo = info
    }
}

final class ReleaseNoteInteractorDependencyMock: ReleaseNoteDashboardInteractorDependency {
    var appDetailsRepository: AppDetailsRepository = AppDetailsRepositoryImp(appId: "839333328")
}
