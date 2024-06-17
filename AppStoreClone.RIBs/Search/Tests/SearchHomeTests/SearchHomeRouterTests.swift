//
//  SearchHomeRouterTests.swift
//  AppStoreClone
//
//  Created by YD on 6/14/24.
//

@testable import SearchHome
import XCTest
import AppDetailsTestSupport
import Entities
import RIBsTestSupport
import AppDetails
import RIBs

final class SearchHomeRouterTests: XCTestCase {

    private var sut: SearchHomeRouter!
    private var interactor: SearchHomeInteractableMock!
    private var viewController: SearchHomeViewControllableMock!
    private var appDetailsBuildable: AppDetailsBuildableMock!

    // TODO: declare other objects and mocks you need as private vars

    override func setUp() {
        super.setUp()

        self.interactor = SearchHomeInteractableMock()
        self.viewController = SearchHomeViewControllableMock()
        self.appDetailsBuildable = AppDetailsBuildableMock()
        
        self.sut = SearchHomeRouter(
            interactor: self.interactor,
            viewController: self.viewController,
            appDetailsBuildable: self.appDetailsBuildable
        )
    }
    
    override func tearDown() {
        super.tearDown()
        
        interactor = nil
        viewController = nil
        appDetailsBuildable = nil
        sut = nil
    }

    // MARK: - Tests
    func testAttachAppDetails() {
        // given
        let info = AppPreviewInfo(
            id: "test_id",
            title: "test_title",
            developerName: "test_dev",
            iconUri: ""
        )
        let router = AppDetailsRoutingMock(
            interactable: Interactor(),
            viewControllable: ViewControllableMock()
        )
        var assignedListener: AppDetailsListener?
        appDetailsBuildable.buildHandler = { listener in
            assignedListener = listener
            return router
        }
        
        // when
        sut.attachAppDetails(with: info)
        
        // then
        XCTAssertEqual(sut.children.count, 1)
        XCTAssertEqual(appDetailsBuildable.buildCallCount, 1)
        XCTAssertEqual(appDetailsBuildable.buildInfo?.id, "test_id")
        XCTAssertTrue(assignedListener === interactor)
    }
    
    func testAttachAppDetailsWhenAlreadyExist() {
        // given
        let info = AppPreviewInfo(
            id: "test_id_0",
            title: "test_title",
            developerName: "test_dev",
            iconUri: ""
        )
        let info1 = AppPreviewInfo(
            id: "test_id_1",
            title: "test_title",
            developerName: "test_dev",
            iconUri: ""
        )
        let router = AppDetailsRoutingMock(
            interactable: Interactor(),
            viewControllable: ViewControllableMock()
        )
        var assignedListener: AppDetailsListener?
        appDetailsBuildable.buildHandler = { listener in
            assignedListener = listener
            return router
        }
        sut.attachAppDetails(with: info)
        
        // when
        sut.attachAppDetails(with: info1)
        
        // then
        XCTAssertEqual(sut.children.count, 1)
        XCTAssertEqual(appDetailsBuildable.buildCallCount, 1)
        XCTAssertEqual(appDetailsBuildable.buildInfo?.id, "test_id_0")
        XCTAssertTrue(assignedListener === interactor)
    }
    
    func testDetachAppDetails() {
        // given
        let info = AppPreviewInfo(
            id: "test_id_0",
            title: "test_title",
            developerName: "test_dev",
            iconUri: ""
        )
        let router = AppDetailsRoutingMock(
            interactable: Interactor(),
            viewControllable: ViewControllableMock()
        )
        appDetailsBuildable.buildHandler = { _ in
            return router
        }
        sut.attachAppDetails(with: info)
        
        // when
        sut.detachAppDetails()
        
        // then
        XCTAssertEqual(sut.children.count, 0)
    }
    
    func testDetachAppDetailsWithoutRouter() {
        // given
        
        // when
        sut.detachAppDetails()
        
        // then
        XCTAssertEqual(sut.children.count, 0)
    }
}
