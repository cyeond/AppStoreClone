//
//  File.swift
//  
//
//  Created by YD on 6/14/24.
//

@testable import SearchHome
import Foundation
import RxSwift
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

