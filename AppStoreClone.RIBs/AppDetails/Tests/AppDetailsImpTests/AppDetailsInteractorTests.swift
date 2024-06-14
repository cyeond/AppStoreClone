//
//  AppDetailsInteractorTests.swift
//  AppStoreClone
//
//  Created by YD on 6/14/24.
//

@testable import AppDetailsImp
import XCTest
import RIBsTestSupport

final class AppDetailsInteractorTests: XCTestCase {

    private var sut: AppDetailsInteractor!
    private var presenter: AppDetailsPresentableMock!
    private var listener: AppDetailsListenerMock!
    private var router: AppDetailsRoutingMock!

    // TODO: declare other objects and mocks you need as private vars

    override func setUp() {
        super.setUp()
        
        self.presenter = AppDetailsPresentableMock()
        self.listener = AppDetailsListenerMock()
        
        let interactor = AppDetailsInteractor(presenter: self.presenter)
        
        self.router = AppDetailsRoutingMock(
            interactable: interactor,
            viewControllable: ViewControllableMock()
        )
        
        interactor.listener = self.listener
        interactor.router = self.router
        
        self.sut = interactor
    }

    func testActivate() {
        // given
        
        // when
        sut.activate()
        
        // then
        XCTAssertEqual(router.attachTopInfoDashboardCallCount, 1)
        XCTAssertEqual(router.attachRatingInfoDashboardCallCount, 1)
        XCTAssertEqual(router.attachReleaseNoteDashboardCallCount, 1)
        XCTAssertEqual(router.attachScreenshotsDashboardCallCount, 1)
    }
    
    func testDidTapBack() {
        // given
        
        // when
        sut.didTapBack()
        
        // then
        XCTAssertEqual(listener.appDetailsDidTapCloseCallCount, 1)
    }
    
    func testDeactivate() {
        // given
        
        // when
        sut.willResignActive()
        
        // then
    }
}
