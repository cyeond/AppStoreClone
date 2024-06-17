//
//  ScreenshotsDashboardRouterTests.swift
//  AppStoreClone
//
//  Created by YD on 6/17/24.
//

@testable import AppDetailsImp
import XCTest

final class ScreenshotsDashboardRouterTests: XCTestCase {

    private var sut: ScreenshotsDashboardRouter!

    // TODO: declare other objects and mocks you need as private vars

    override func setUp() {
        super.setUp()

        self.sut = ScreenshotsDashboardRouter(
            interactor: ScreenshotsDashboardInteractableMock(),
            viewController: ScreenshotsDashboardViewControllableMock()
        )
    }

    // MARK: - Tests
    func testDidLoad() {
        sut.didLoad()
    }
}
