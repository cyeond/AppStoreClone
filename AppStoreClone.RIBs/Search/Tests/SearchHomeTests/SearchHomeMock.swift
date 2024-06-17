//
//  File.swift
//  
//
//  Created by YD on 6/14/24.
//

@testable import SearchHome
import UIKit
import RxSwift
import RxRelay
import RIBs
import RIBsTestSupport
import ReuseableViews
import Entities

final class SearchHomePresentableMock: SearchHomePresentable {
    var listener: SearchHomePresentableListener?
    
    var updateCallCount = 0
    var updateCalled = PublishSubject<Void>()
    var updateModel: CollectionViewSectionModel?
    func update(with model: CollectionViewSectionModel) {
        updateCallCount += 1
        updateModel = model
        updateCalled.onNext(())
    }
    
    var startLoadingCallCount = 0
    var startLoadingCalled = PublishSubject<Void>()
    func startLoading() {
        startLoadingCallCount += 1
        startLoadingCalled.onNext(())
    }
    
    var stopLoadingCallCount = 0
    var stopLoadingCalled = PublishSubject<Void>()
    func stopLoading() {
        stopLoadingCallCount += 1
        stopLoadingCalled.onNext(())
    }
}

final class SearchHomeRoutingMock: ViewableRoutingMock, SearchHomeRouting {
    var attachAppDetailsCallCount = 0
    var attachAppDetailsInfo: AppPreviewInfo?
    func attachAppDetails(with info: AppPreviewInfo) {
        attachAppDetailsCallCount += 1
        attachAppDetailsInfo = info
    }
    
    var detachAppDetailsCallCount = 0
    func detachAppDetails() {
        detachAppDetailsCallCount += 1
    }
}


final class SearchHomeInteractableMock: SearchHomeInteractable {
    var router: SearchHomeRouting?
    var listener: SearchHomeListener?
    var isActive: Bool { isActiveRelay.value }
    var isActiveStream: Observable<Bool> { isActiveRelay.asObservable() }
    private let isActiveRelay = BehaviorRelay<Bool>(value: false)
    
    func activate() {
    }
    
    func deactivate() {
    }
    
    var appDetailsDidTapCloseCallCount = 0
    func appDetailsDidTapClose() {
        appDetailsDidTapCloseCallCount += 1
    }
}

final class SearchHomeViewControllableMock: SearchHomeViewControllable {
    var uiviewController: UIViewController = UIViewController()
}
