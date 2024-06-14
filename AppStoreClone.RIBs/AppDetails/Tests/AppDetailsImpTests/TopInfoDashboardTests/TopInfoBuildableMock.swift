//
//  TopInfoBuildableMock.swift
//
//
//  Created by YD on 6/14/24.
//

import UIKit
import RIBsTestSupport
import Entities
import RxSwift
import Extensions
@testable import AppDetailsImp

final class TopInfoBuildableMock: TopInfoDashboardBuildable {
    var buildHandler: ((_ listener: TopInfoDashboardListener) -> TopInfoDashboardRouting)?
    
    var buildCallCount = 0
    func build(withListener listener: TopInfoDashboardListener) -> TopInfoDashboardRouting {
        buildCallCount += 1
        
        if let buildHandler = buildHandler {
            return buildHandler(listener)
        }
        
        fatalError()
    }
}

final class TopInfoDashboardRoutingMock: ViewableRoutingMock, TopInfoDashboardRouting {
    
}

final class TopInfoDashboardPresentableMock: TopInfoDashboardPresentable {
    var listener: TopInfoDashboardPresentableListener?
    
    var updateCallCount = 0
    var updateInfo: AppPreviewInfo?
    func update(with info: AppPreviewInfo) {
        updateCallCount += 1
        updateInfo = info
    }
}

final class TopInfoDashboardInteractorDependencyMock: TopInfoDashboardInteractorDependency {
    var appPreviewInfo: AppPreviewInfo = AppPreviewInfo(
        id: "839333328",
        title: "test_title",
        developerName: "test_developer",
        iconUri: ""
    )
    var uiApplication: UIApplicationProtocol = UIApplicationMock()
}

final class UIApplicationMock: UIApplicationProtocol {
    var canOpenURL: Bool = true
    
    var canOpenURLCallCount = 0
    var canOpenURLCalledSubject = PublishSubject<Void>()
    func canOpenURL(_ url: URL) -> Bool {
        canOpenURLCallCount += 1
        canOpenURLCalledSubject.onNext(())
        
        return canOpenURL
    }
    
    var openCallCount = 0
    var openCalledSubject = PublishSubject<Void>()
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any] = [:], completionHandler completion: ((Bool) -> Void)? = nil) {
        openCallCount += 1
        openCalledSubject.onNext(())
    }
}
