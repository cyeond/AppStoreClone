//
//  RatingInfoDashboardInteractorTests.swift
//  AppStoreClone
//
//  Created by YD on 6/17/24.
//

@testable import AppDetailsImp
import XCTest
import RxBlocking

final class RatingInfoDashboardInteractorTests: XCTestCase {

    private var sut: RatingInfoDashboardInteractor!
    private var presenter: RatingInfoPresentableMock!
    private var dependency: RatingInfoInteractorDependencyMock!

    // TODO: declare other objects and mocks you need as private vars

    override func setUp() {
        super.setUp()

        self.presenter = RatingInfoPresentableMock()
        self.dependency = RatingInfoInteractorDependencyMock()
        
        self.sut = RatingInfoDashboardInteractor(
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
