//
//  RatingInfoBuildableMock.swift
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

final class RatingInfoBuildableMock: RatingInfoDashboardBuildable {
    var buildHandler: ((_ listener: RatingInfoDashboardListener) -> RatingInfoDashboardRouting)?
    
    var buildCallCount = 0
    func build(withListener listener: RatingInfoDashboardListener) -> RatingInfoDashboardRouting {
        buildCallCount += 1
        
        if let buildHandler = buildHandler {
            return buildHandler(listener)
        }
        
        fatalError()
    }
}

final class RatingInfoRoutingMock: ViewableRoutingMock, RatingInfoDashboardRouting {
    
}

final class RatingInfoPresentableMock: RatingInfoDashboardPresentable {
    var listener: RatingInfoDashboardPresentableListener?
    
    var updateCallCount = 0
    var updateCalledSubject = PublishSubject<Void>()
    func update(with sectionModel: CollectionViewSectionModel) {
        updateCallCount += 1
        updateCalledSubject.onNext(())
        
    }
}

final class RatingInfoInteractorDependencyMock: RatingInfoDashboardInteractorDependency {
    var appDetailsRepository: AppDetailsRepository = AppDetailsRepositoryImp(appId: "839333328")
}

final class RatingInfoDashboardInteractableMock: RatingInfoDashboardInteractable {
    var router: RatingInfoDashboardRouting?
    var listener: RatingInfoDashboardListener?
    var isActive: Bool { isActiveRelay.value }
    var isActiveStream: Observable<Bool> { isActiveRelay.asObservable() }
    private let isActiveRelay = BehaviorRelay<Bool>(value: false)
    
    func activate() {
    }
    
    func deactivate() {
    }
}

final class RatinginfoDashboardViewControllableMock: RatingInfoDashboardViewControllable {
    var uiviewController: UIViewController = UIViewController()
}
