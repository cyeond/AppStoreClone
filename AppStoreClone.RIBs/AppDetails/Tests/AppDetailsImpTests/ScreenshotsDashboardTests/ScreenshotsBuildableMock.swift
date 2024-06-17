//
//  ScreenshotsBuildableMock.swift
//
//
//  Created by YD on 6/14/24.
//

import UIKit
import RIBsTestSupport
import ReuseableViews
import RxSwift
import RxRelay
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

final class ScreenshotsDashboardInteractableMock: ScreenshotsDashboardInteractable {
    var router: ScreenshotsDashboardRouting?
    var listener: ScreenshotsDashboardListener?
    var isActive: Bool { isActiveRelay.value }
    var isActiveStream: Observable<Bool> { isActiveRelay.asObservable() }
    private let isActiveRelay = BehaviorRelay<Bool>(value: false)
    
    func activate() {
    }
    
    func deactivate() {
    }
}

final class ScreenshotsDashboardViewControllableMock: ScreenshotsDashboardViewControllable {
    var uiviewController: UIViewController = UIViewController()
}
