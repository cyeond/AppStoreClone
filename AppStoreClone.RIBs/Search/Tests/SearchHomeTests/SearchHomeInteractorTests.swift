//
//  SearchHomeInteractorTests.swift
//  AppStoreClone
//
//  Created by YD on 6/14/24.
//

@testable import SearchHome
import XCTest
import Entities
import RIBsTestSupport

final class SearchHomeInteractorTests: XCTestCase {
    
    private var sut: SearchHomeInteractor!
    private var presenter: SearchHomePresentableMock!
    private var router: SearchHomeRoutingMock!
    
    // TODO: declare other objects and mocks you need as private vars
    
    override func setUp() {
        super.setUp()
        
        self.presenter = SearchHomePresentableMock()
        
        let interactor = SearchHomeInteractor(presenter: self.presenter)
        self.router = SearchHomeRoutingMock(
            interactable: interactor,
            viewControllable: ViewControllableMock()
        )
        interactor.router = self.router
        
        self.sut = interactor
    }
    
    // MARK: - Tests
    func testAppPreviewCellDidTap() {
        // given
        let info = AppPreviewInfo(
            id: "app_id_0",
            title: "app_title",
            developerName: "",
            iconUri: ""
        )
        
        // when
        sut.appPreviewCellDidTap(with: info)
        
        // then
        XCTAssertEqual(router.attachAppDetailsCallCount, 1)
        XCTAssertEqual(router.attachAppDetailsInfo?.id, "app_id_0")
    }
    
    func testAppDetailsDidTapClose() {
        // given
        
        // when
        sut.appDetailsDidTapClose()
        
        // then
        XCTAssertEqual(router.detachAppDetailsCallCount, 1)
    }
}
