//
//  ScreenshotsDashboardInteractorTests.swift
//  AppStoreClone
//
//  Created by YD on 6/17/24.
//

@testable import AppDetailsImp
import XCTest
import RxBlocking

final class ScreenshotsDashboardInteractorTests: XCTestCase {

    private var sut: ScreenshotsDashboardInteractor!
    private var presenter: ScreenshotsDashboardPresentableMock!
    private var dependency: ScreenshotsDashboardInteractorDependencyMock!

    // TODO: declare other objects and mocks you need as private vars

    override func setUp() {
        super.setUp()
        
        self.presenter = ScreenshotsDashboardPresentableMock()
        self.dependency = ScreenshotsDashboardInteractorDependencyMock()
        
        self.sut = ScreenshotsDashboardInteractor(
            presenter: self.presenter,
            dependency: self.dependency
        )
    }

    // MARK: - Tests
    func testActivate() {
        // given
        
        // when
        sut.activate()
        
        // then
        do {
            _ = try presenter.updateCalledSubject
                .toBlocking(timeout: 5.0)
                .first()
            
            XCTAssertEqual(presenter.updateCallCount, 1)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testWillResignActive() {
        sut.willResignActive()
    }
}
