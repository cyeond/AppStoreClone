//
//  TopInfoDashboardRouterTests.swift
//  AppStoreClone
//
//  Created by YD on 6/14/24.
//

@testable import AppDetailsImp
import XCTest

final class TopInfoDashboardRouterTests: XCTestCase {

    private var sut: TopInfoDashboardRouter!

    // TODO: declare other objects and mocks you need as private vars

    override func setUp() {
        super.setUp()

        self.sut = TopInfoDashboardRouter(
            interactor: TopInfoDashboardInteractableMock(),
            viewController: TopinfoDashboardViewControllableMock()
        )
    }

    // MARK: - Tests
    func testDidLoad() {
        sut.didLoad()
    }
}
