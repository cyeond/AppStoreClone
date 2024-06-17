//
//  ScreenshotsBuildableMock.swift
//
//
//  Created by YD on 6/14/24.
//

import Foundation
import RIBsTestSupport
import ReuseableViews
import RxSwift
@testable import AppDetailsImp

final class ScreenshotsBuildableMock: ScreenshotsDashboardBuildable {
    var buildHandler: ((_ listener: ScreenshotsDashboardListener) -> ScreenshotsDashboardRouting)?
    
    var buildCallCount = 0
    func build(withListener listener: ScreenshotsDashboardListener) -> ScreenshotsDashboardRouting {
        buildCallCount += 1
        
        if let buildHandler = buildHandler {
            return buildHandler(listener)
        }
        
        fatalError()
    }
}

final class ScreenshotsRoutingMock: ViewableRoutingMock, ScreenshotsDashboardRouting {
    
}

final class ScreenshotsDashboardPresentableMock: ScreenshotsDashboardPresentable {
    var listener: ScreenshotsDashboardPresentableListener?
    
    var updateCallCount = 0
    var updateCalledSubject = PublishSubject<Void>()
    func update(with sectionModel: CollectionViewSectionModel) {
        updateCallCount += 1
        updateCalledSubject.onNext(())
    }
}

final class ScreenshotsDashboardInteractorDependencyMock: ScreenshotsDashboardInteractorDependency {
    var appDetailsRepository: AppDetailsRepository = AppDetailsRepositoryImp(appId: "839333328")
}
