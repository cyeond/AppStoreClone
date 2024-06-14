//
//  TopInfoDashboardInteractorTests.swift
//  AppStoreClone
//
//  Created by YD on 6/14/24.
//

@testable import AppDetailsImp
import XCTest
import RIBsTestSupport
import RxBlocking

final class TopInfoDashboardInteractorTests: XCTestCase {

    private var sut: TopInfoDashboardInteractor!
    private var presenter: TopInfoDashboardPresentableMock!
    private var dependency: TopInfoDashboardInteractorDependencyMock!
    private var uiApplication: UIApplicationMock {
        dependency.uiApplication as! UIApplicationMock
    }

    override func setUp() {
        super.setUp()
        
        self.presenter = TopInfoDashboardPresentableMock()
        self.dependency = TopInfoDashboardInteractorDependencyMock()
        
        self.sut = TopInfoDashboardInteractor(
            presenter: self.presenter,
            dependency: self.dependency
        )
    }
    
    override func tearDown() {
        super.tearDown()
        
        self.presenter = nil
        self.sut = nil
    }
    
    // MARK: - Tests
    func testActivate() {
        // given
        
        // when
        sut.activate()
        
        // then
        XCTAssertEqual(presenter.updateCallCount, 1)
        XCTAssertEqual(presenter.updateInfo?.id, dependency.appPreviewInfo.id)
    }
    
    func testDownloadButtonDidTap() {
        // given
        
        // when
        sut.downloadButtonDidTap()
        
        // then
        do {
            _ = try uiApplication.canOpenURLCalledSubject
                .toBlocking(timeout: 5.0)
                .first()
            
            XCTAssertEqual(uiApplication.openCallCount, 1)
            XCTAssertEqual(uiApplication.canOpenURLCallCount, 1)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testDownloadButtonDidTapWithInvalidURL() {
        // given
        uiApplication.canOpenURL = false
        
        // when
        sut.downloadButtonDidTap()
        
        // then
        do {
            _ = try uiApplication.canOpenURLCalledSubject
                .toBlocking(timeout: 5.0)
                .first()
            
            XCTAssertEqual(uiApplication.canOpenURLCallCount, 1)
            XCTAssertEqual(uiApplication.openCallCount, 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testDownloadButtonDidTapTwice() {
        // given
        
        // when
        sut.downloadButtonDidTap()
        
        // then
        do {
            _ = try uiApplication.canOpenURLCalledSubject
                .toBlocking(timeout: 5.0)
                .first()
            
            sut.downloadButtonDidTap()
            
            XCTAssertEqual(uiApplication.canOpenURLCallCount, 2)
            XCTAssertEqual(uiApplication.openCallCount, 2)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testShareButtonDidTap() {
        sut.shareButtonDidTap()
    }
    
    func testWillResignActive() {
        sut.willResignActive()
    }
}
