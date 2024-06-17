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
import RxBlocking
import RxSwift

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
    
    override func tearDown() {
        self.presenter = nil
        self.router = nil
        self.sut = nil
        
        super.tearDown()
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
    
    func testSearchButtonDidTap() {
        // given
        let text = "Test"
        
        // when
        sut.activate()
        sut.searchButtonDidTap(text)
        
        // then
        XCTAssertEqual(presenter.startLoadingCallCount, 1)
        
        do {
            _ = try presenter.stopLoadingCalled
                .toBlocking(timeout: 5.0)
                .first()
            
            XCTAssertEqual(presenter.stopLoadingCallCount, 1)
            XCTAssertGreaterThan(presenter.updateCallCount, 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testCancelButtonDidTap() {
        // when
        sut.activate()
        sut.searchButtonDidTap("Test")
        
        // then
        do {
            _ = try presenter.updateCalled
                .toBlocking(timeout: 10.0)
                .first()
            
            XCTAssertGreaterThan(presenter.updateModel?.items.count ?? 0, 0)
            
            let count = presenter.updateCallCount
            sut.cancelButtonDidTap()
//            
            XCTAssertEqual(presenter.updateCallCount, count+1)
            XCTAssertEqual(presenter.updateModel?.items.count, 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testWillResignActive() {
        sut.willResignActive()
    }
}
