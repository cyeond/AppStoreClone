//
//  AppDetailsRouterTests.swift
//  AppStoreClone
//
//  Created by YD on 6/14/24.
//

@testable import AppDetailsImp
import XCTest
import RIBsTestSupport
import RIBs

final class AppDetailsRouterTests: XCTestCase {

    private var sut: AppDetailsRouter!
    private var interactor: AppDetailsInteractableMock!
    private var viewController: AppDetailsViewControllableMock!
    private var topInfoDashboardBuildable: TopInfoBuildableMock!
    private var ratingInfoDashboardBuildable: RatingInfoBuildableMock!
    private var screenshotsDashboardBuildable: ScreenshotsBuildableMock!
    private var releaseNoteDashboardBuildable: ReleaseNoteBuildableMock!

    // TODO: declare other objects and mocks you need as private vars

    override func setUp() {
        super.setUp()
        
        self.interactor = AppDetailsInteractableMock()
        self.viewController = AppDetailsViewControllableMock()
        self.topInfoDashboardBuildable = TopInfoBuildableMock()
        self.ratingInfoDashboardBuildable = RatingInfoBuildableMock()
        self.screenshotsDashboardBuildable = ScreenshotsBuildableMock()
        self.releaseNoteDashboardBuildable = ReleaseNoteBuildableMock()
        
        self.sut = AppDetailsRouter(
            interactor: self.interactor,
            viewController: self.viewController,
            topInfoDashboardBuilable: self.topInfoDashboardBuildable,
            ratingInfoDashboardBuilable: self.ratingInfoDashboardBuildable,
            screenshotsDashboardBuildable: self.screenshotsDashboardBuildable,
            releaseNoteDashboardBuildable: self.releaseNoteDashboardBuildable
        )
    }
    
    func testAttachTopInfoDashboard() {
        // given
        let router = TopInfoDashboardRoutingMock(
            interactable: Interactor(),
            viewControllable: ViewControllableMock()
        )
        var assignedListener: TopInfoDashboardListener?
        topInfoDashboardBuildable.buildHandler = { listener in
            assignedListener = listener
            return router
        }
        
        // when
        sut.attachTopInfoDashboard()
        
        // then
        XCTAssertEqual(sut.children.count, 1)
        XCTAssertEqual(topInfoDashboardBuildable.buildCallCount, 1)
        XCTAssertEqual(viewController.addDashboardCallCount, 1)
        XCTAssertTrue(viewController.addDashboardView === router.viewControllable)
        XCTAssertTrue(assignedListener === interactor)
    }
    
    func testAttachTopInfoDashboardWhenAlreadyExist() {
        // given
        let router = TopInfoDashboardRoutingMock(
            interactable: Interactor(),
            viewControllable: ViewControllableMock()
        )
        topInfoDashboardBuildable.buildHandler = { _ in
            return router
        }
        sut.attachTopInfoDashboard()
        
        // when
        sut.attachTopInfoDashboard()
        
        // then
        XCTAssertEqual(sut.children.count, 1)
        XCTAssertEqual(topInfoDashboardBuildable.buildCallCount, 1)
        XCTAssertEqual(viewController.addDashboardCallCount, 1)
    }
    
    func testAttachRatingInfoDashboard() {
        // given
        let router = RatingInfoRoutingMock(
            interactable: Interactor(),
            viewControllable: ViewControllableMock()
        )
        var assignedListener: RatingInfoDashboardListener?
        ratingInfoDashboardBuildable.buildHandler = { listener in
            assignedListener = listener
            return router
        }
        
        // when
        sut.attachRatingInfoDashboard()
        
        // then
        XCTAssertEqual(sut.children.count, 1)
        XCTAssertEqual(ratingInfoDashboardBuildable.buildCallCount, 1)
        XCTAssertEqual(viewController.addDashboardCallCount, 1)
        XCTAssertTrue(viewController.addDashboardView === router.viewControllable)
        XCTAssertTrue(assignedListener === interactor)
    }
    
    func testAttachRatingInfoDashboardWhenAlreadyExist() {
        // given
        let router = RatingInfoRoutingMock(
            interactable: Interactor(),
            viewControllable: ViewControllableMock()
        )
        ratingInfoDashboardBuildable.buildHandler = { _ in
            return router
        }
        sut.attachRatingInfoDashboard()
        
        // when
        sut.attachRatingInfoDashboard()
        
        // then
        XCTAssertEqual(sut.children.count, 1)
        XCTAssertEqual(ratingInfoDashboardBuildable.buildCallCount, 1)
        XCTAssertEqual(viewController.addDashboardCallCount, 1)
    }
    
    func testAttachScreenshotsDashboard() {
        // given
        let router = ScreenshotsRoutingMock(
            interactable: Interactor(),
            viewControllable: ViewControllableMock()
        )
        var assignedListener: ScreenshotsDashboardListener?
        screenshotsDashboardBuildable.buildHandler = { listener in
            assignedListener = listener
            return router
        }
        
        // when
        sut.attachScreenshotsDashboard()
        
        // then
        XCTAssertEqual(sut.children.count, 1)
        XCTAssertEqual(screenshotsDashboardBuildable.buildCallCount, 1)
        XCTAssertEqual(viewController.addDashboardCallCount, 1)
        XCTAssertTrue(viewController.addDashboardView === router.viewControllable)
        XCTAssertTrue(assignedListener === interactor)
    }
    
    func testAttachScreenshotsDashboardWhenAlreadyExist() {
        // given
        let router = ScreenshotsRoutingMock(
            interactable: Interactor(),
            viewControllable: ViewControllableMock()
        )
        screenshotsDashboardBuildable.buildHandler = { _ in
            return router
        }
        sut.attachScreenshotsDashboard()
        
        // when
        sut.attachScreenshotsDashboard()
        
        // then
        XCTAssertEqual(sut.children.count, 1)
        XCTAssertEqual(screenshotsDashboardBuildable.buildCallCount, 1)
        XCTAssertEqual(viewController.addDashboardCallCount, 1)
    }
    
    func testAttachReleaseNoteDashboard() {
        // given
        let router = ReleaseNoteRoutingMock(
            interactable: Interactor(),
            viewControllable: ViewControllableMock()
        )
        var assignedListener: ReleaseNoteDashboardListener?
        releaseNoteDashboardBuildable.buildHandler = { listener in
            assignedListener = listener
            return router
        }
        
        // when
        sut.attachReleaseNoteDashboard()
        
        // then
        XCTAssertEqual(sut.children.count, 1)
        XCTAssertEqual(releaseNoteDashboardBuildable.buildCallCount, 1)
        XCTAssertEqual(viewController.addDashboardCallCount, 1)
        XCTAssertTrue(viewController.addDashboardView === router.viewControllable)
        XCTAssertTrue(assignedListener === interactor)
    }
    
    func testAttachReleaseNoteDashboardWhenAlreadyExist() {
        // given
        let router = ReleaseNoteRoutingMock(
            interactable: Interactor(),
            viewControllable: ViewControllableMock()
        )
        releaseNoteDashboardBuildable.buildHandler = { _ in
            return router
        }
        sut.attachReleaseNoteDashboard()
        
        // when
        sut.attachReleaseNoteDashboard()
        
        // then
        XCTAssertEqual(sut.children.count, 1)
        XCTAssertEqual(releaseNoteDashboardBuildable.buildCallCount, 1)
        XCTAssertEqual(viewController.addDashboardCallCount, 1)
    }
}
