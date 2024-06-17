//
//  ReleaseNoteDashboardInteractorTests.swift
//  AppStoreClone
//
//  Created by YD on 6/17/24.
//

@testable import AppDetailsImp
import XCTest

final class ReleaseNoteDashboardInteractorTests: XCTestCase {

    private var sut: ReleaseNoteDashboardInteractor!
    private var presenter: ReleaseNoteDashboardPresentableMock!
    private var dependency: ReleaseNoteDashboardInteractorDependency!

    // TODO: declare other objects and mocks you need as private vars

    override func setUp() {
        super.setUp()

        self.presenter = ReleaseNoteDashboardPresentableMock()
        self.dependency = ReleaseNoteInteractorDependencyMock()
        
        self.sut = ReleaseNoteDashboardInteractor(
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
            XCTAssertEqual(presenter.updatedAppInfo?.id, 839333328)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testWillResignActive() {
        sut.willResignActive()
    }
}
